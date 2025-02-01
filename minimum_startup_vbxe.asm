; NOTE: - Initialization code from VBXE Programming manual
; NOTE: - Do not load S_VBXE.SYS under SDX.  This uses some
;		  VBXE RAM and also Palette 1.  I'm not sure what would
;		  happen when I eventually run my clear VBXE RAM routine!

; VBXE RAM Usage
; MEMAC_A is set to $2000, with a 4kB window
; Bank 00 - XDL & BCBs
; $000000 to $0000FF	Reserved for XDL(s)
; $000100 to $000FFF	Reserved for BCBs (enough space for 182 unique BCBs)
;	$000100 - BLT_CLEAR_SCREEN
;	$000115 - BLT_COPY_PLAYFIELD

; Bank $01 to $02 - Font and screen RAM for Text mode
; $001000 to $002FFF

; Bank $03 to $?? - Screen RAM for graphics modes (320 or 640 * 224 = 70kB max for an image)

; Banks $7C to $7F (Last 4 banks of VBXE RAM - DO NOT TOUCH)
; $7C0000 to $7FFFFF	Reserved for SDX S_VBXE.SYS Driver

;-----------------------------------------------------------------------------
;  HARDWARE EQUATES (Consider making a general include file for these)
;-----------------------------------------------------------------------------
	icl	'equates.asm'

;-----------------------------------------------------------------------------
; Blitter Variables that will need changed
;-----------------------------------------------------------------------------
;BLT_CLEAR_SCREEN
; Where in the VBXE RAM do we clear
clr_screen_16_16_dest_adr0		equ VBXE_WINDOW+$100+6
clr_screen_16_16_dest_adr1		equ VBXE_WINDOW+$100+7
clr_screen_16_16_dest_adr2		equ VBXE_WINDOW+$100+8

.def	__VBXE_AUTO__
.def	VBXE_WINDOW						= $2000
.def 	BLT_CLEAR_SCREEN_ADR0			= $00
.def 	BLT_CLEAR_SCREEN_ADR1			= $01

;-----------------------------------------------------------------------------
; Variables go here
;-----------------------------------------------------------------------------
; Page 0 user data ($80 to $FF with some reserved for OS)
.zpvar	SDMCTL_OLD	.byte			; Save DMA

	org $3000
;-----------------------------------------------------------------------------
; VBXE Helpers
;-----------------------------------------------------------------------------
	icl	'fileio.lib'
	icl	'vbxe.lib'					; Use my VBXE_SetPalette2 to load linear palete

main
	lda SDMCTL
	sta SDMCTL_OLD					; Save SDMCTL so we can restore it later

	mwa	#Welcome_Txt TextPtr		; This is neat feature of mads - it replaces previous lda/sta pairs with single mnemonic
	jsr	PutLine

	mwa #Welcome_Desc TextPtr
	jsr PutLine

	jsr	VBXE_Detect					; VBXE core 1.07 and above detection,
	bcc	Main_VBXE_Found
	mwa	#VBXE_NPresent TextPtr
	jsr	PutLine						; No VBXE no show
	rts								; Exit to dos
;---------------------------------------------------------------------
Main_VBXE_Found
	cpx	#$D6
	beq	Main_VBXE_at_d6
	inc	VBXE_Address+1				; Not at d6, but still found - d7 then!
Main_VBXE_at_d6
	mwa	#VBXE_Present TextPtr		; This is neat feature of mads - it replaces previous lda/sta pairs with single mnemonic
	jsr	Putline

	lda	#$28						; Set the base address of MEMA window to $2000, size to 4k and accesible only by CPU
	vbsta VBXE_MA_CTL

	lda	#$80						; Prepare to copy data into VBXE address space
	vbsta VBXE_MA_BSEL				; Bank 0, bit 7 set = MEMAC GLOBAL ENABLE

;-----------------------------------------------------------------------------
; Copy the XDL into VBXE Memory $000000 (note this can only copy $FF bytes)
;-----------------------------------------------------------------------------
	ldx	#XDL_Length
	ldy	#0
Main_l1	lda	XDL,y
	sta	VBXE_WINDOW,y				; We're in bank 0 so offset accordingly
	iny
	dex
	bne	Main_l1

;-----------------------------------------------------------------------------
; Copy the BCBs into VBXE Memory $000100
;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------
; Point the VBXE to the XDL at $000000
;-----------------------------------------------------------------------------
	lda	#0
	vbsta VBXE_XDL_ADR0
	vbsta VBXE_XDL_ADR1
	vbsta VBXE_XDL_ADR2

;-----------------------------------------------------------------------------
; Load the Text into VBXE
;-----------------------------------------------------------------------------
/*
Load_Sprites
	mwa	#VBXE_Loading_Sprites TextPtr
	jsr	PutLine						; Inform the user that big file is loading

	mwa	#SpriteSheet FileNamePtr
	lda	#1							; Bank $01
	sta	BankIndex					; Load image data under $001000
	jsr	LoadData

	lda LoadStatus					; 0 = failure, 1 = success
	bne Load_Score

	; If I/O error display error and exit
	mwa #File_Error TextPtr			; Display error message
	jsr PutLine
	jmp Exit
*/

;-----------------------------------------------------------------------------
; Load the Palette into VBXE
;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------
; Load the Image into VBXE
;-----------------------------------------------------------------------------

;-----------------------------------------------------------------------------
; If all data has been loaded continue setup here
;-----------------------------------------------------------------------------
Continue
	lda #0
;	sta SDMCTL						; Turn off ANTIC DMA
	vbsta VBXE_BL_ADR2
	vbsta VBXE_BL_ADR0
	lda	#1
	vbsta VBXE_BL_ADR1

	lda	#%00000001					; XDL enabled, and transparent color index 0
	vbsta VBXE_VIDEO_CONTROL		; Turn on the VBXE Overlay

	lda	#$80						; Prepare to copy data into VBXE address space
	vbsta VBXE_MA_BSEL				; Bank 0, bit 7 set = MEMAC GLOBAL ENABLE

;-----------------------------------------------------------------------------
; Main loop starts here
;-----------------------------------------------------------------------------
MainLoop
	lda #0
	sta ATRACT						; Disable screensaver

	jsr Wait_For_Sync				; Wait for VSYNC, Q quits
	jmp MainLoop					; Animate forever

; Begin cleaning up and determing how to exit based on LoadStatus
Exit
	lda	#0
	vbsta VBXE_VIDEO_CONTROL		; Disable XDL
	lda	#0
	sta	VBXE_MA_BSEL				; Restore main memory (and disable VBXE memory window at VBXE_WINDOW)

	lda SDMCTL_OLD
	sta SDMCTL						; Restore SDMCTL

	lda #$FF
	sta CH							; Clear last key pressed
TEST
	lda #1	;LoadStatus
	beq ExitFailure

; I don't know why this is necessary, but if there's a file load error, rts exits because jmp ($000a) causes a crash (11/26/2002)
ExitSuccess
	jmp	($000a)
ExitFailure
	rts
;----------------------------------------------------------------------------
; END OF CODE
;-----------------------------------------------------------------------------

; Subroutines below
;-----------------------------------------------------------------------------
; Wait For VSync (locks to the refresh rate, PAL=50Hz, NTSC=60Hz)
;-----------------------------------------------------------------------------
Wait_For_Sync
	lda	VCOUNT
	rne		 						; Repeat last instruction if not equal
	lda	VCOUNT
	req								; Repeat last instruction if equal
; If present, the next 3 lines will allow a "jump to exit" on a specific key press
	lda CH
	cmp #$2F						; Press Q to quit
	beq	Exit
	rts								; Else return to caller

;-----------------------------------------------------------------------------
; Clear screen RAM via the Blitter
;-----------------------------------------------------------------------------
Clear_Screen
	lda	#BLT_CLEAR_SCREEN_ADR0
	vbsta VBXE_BL_ADR0				; Setup the blitter for memory fill operation
	vbsta VBXE_BL_ADR2				; By pointing Blitter to BLT_CLEAR_SCREEN $000100
	lda	#1
	vbsta VBXE_BL_ADR1
Clear_Screen_l1
	vblda VBXE_BLITTER_BUSY			; Is Blitter busy?
	bne	Clear_Screen_l1				; Wait for blitter to finish
	lda	#1
	vbsta VBXE_BLITTER_START		; Start the blit
	rts

;-----------------------------------------------------------------------------
; Display Strings
;-----------------------------------------------------------------------------
	icl 'strings.asm'

;-----------------------------------------------------------------------------
; Xtended Display List
;-----------------------------------------------------------------------------
XDL
; XDLC Block 1 (8 blank scanlines)
;    76543210
	dta %00110100					; XDLC Byte 1 $34 (XDLC_OVOFF | XDLC_MAPOFF | XDLC_RPTL)
	dta %00000000					; XDLC Byte 2 $00
	dta %00000111					; XDLC_RPTL (1 byte) No changes in next 7 lines

; XDLC Block 2 (192 Med-res scanlines)
;    76543210
	dta %01110010					; XDLC Byte 1 $72 (XDLC_GMON | XDLC_MAPOFF | XDLC_RPTL | XDLC_OVADR)
	dta %00001000					; XDLC Byte 2 $08 (XDLC_ATT)
	dta %10111111					; XDLC_RPTL (1 byte $BF) No changes in next 191 lines
	dta $00,$30,$01,$40,$01			; XDLC_OVADR (5 bytes) = OVADR (3 bytes) $013000, OVSTEP (2 bytes) = $0140
	dta %00010001,$FF				; XDLC_OVATT (2 bytes) OV_WIDTH=01 | XDL_OV_PALETTE=01 | XDL_PF_PALETTE=00, Priority=FF

; XDLC Block 3 (24 Text scanlines)
;    76543210
	dta %01110001					; XDLC Byte 1 $72 (XDLC_TMON | XDLC_MAPOFF | XDLC_RPTL | XDLC_OVADR)
	dta %00001001					; XDLC Byte 2 $08 (XDLC_CHBASE | XDLC_ATT)
	dta %00010111					; XDLC_RPTL (1 byte $17) No changes in next 23 lines
	dta $00,$20,$01,$A0,$00			; XDLC_OVADR (5 bytes) = OVADR (3 bytes) $012000, OVSTEP (2 bytes) = $00A0
	dta $00							; XDLC_CHBASE
	dta %00010001,$FF				; XDLC_OVATT (2 bytes) OV_WIDTH=01 | XDL_OV_PALETTE=01 | XDL_PF_PALETTE=00, Priority=FF

; XDLC Block 4 (8 blank scanlines)
;    76543210
	dta %00110100					; XDLC Byte 1 $34 (XDLC_OVOFF | XDLC_MAPOFF | XDLC_RPTL)
	dta %10000000					; XDLC Byte 2 $80 (XDLC_END)
	dta %00000111					; XDLC_RPTL (1 byte) No changes in next 7 lines
XDL_Length	equ *-XDL

;-----------------------------------------------------------------------------
; Blitter Command Blocks
; NOTE - if this is > $FF code will have to be modified!!!
; Each BCB is $15 bytes so we can use $C BCBs before this is an issue
;-----------------------------------------------------------------------------
	icl 'bcbs.asm'
BLT_Length	equ *-XDL

.var	NMI_Status	.byte
	dta	"Z"

	run main
