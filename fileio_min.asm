;-----------------------------------------------------------------------------
; Basic CIO commands (ICCOM)
;-----------------------------------------------------------------------------
CIO_open		equ $03					; OPEN command for IOCB channell
CIO_gettext		equ $05					; READ of text line
CIO_getdata		equ $07					; READ of binary data
CIO_puttext		equ $09					; WRITE of text line
CIO_putdata		equ $0B					; WRITE of binary data
CIO_close    	equ $0C					; CLOSE of IOCB channel
CIO_getstatus	equ $0D					; READ of device status
XIO_changedir	equ $29					; Change working directory (MyDOS)

;-----------------------------------------------------------------------------
; Mode of operation
;-----------------------------------------------------------------------------
CIO_read     	equ $04					; Open to read
CIO_dir       	equ $06					; Get directory
CIO_write     	equ $08					; Open to write

;-----------------------------------------------------------------------------
; Zero page variables for File I/O
;-----------------------------------------------------------------------------
.zpvar	AR_Temp		.byte
.zpvar	XR_Temp		.byte

;-----------------------------------------------------------------------------
; Other variables for File I/O
;-----------------------------------------------------------------------------
.var	TextPtr		.word
.var	LoadStatus	.byte				; $0 = failure, $1 = Success
Console_IOCB		.byte $FF
Temporary_Handler	.byte ' :',$9B,$00

;-----------------------------------------------------------------------------
; Get_HATABS_Entry - retrives handler ID from HATABS table
; takes:
; A - HATABS offset from ICHID
; returns:
; A - letter identificator of the handler
;-----------------------------------------------------------------------------
Get_HATABS_Entry
	stx	XR_Temp
	tax
	lda	HATABS,x
	ldx	XR_Temp
	rts

;-----------------------------------------------------------------------------
;Find_Matching_IOCB - search for first matching IOCB
; takes:
; A - letter identificator of the handler to look for
; returns:
; X - relative offset to first free IOCB (IOCB number * $10)
; Y - error code (126 - nonexistent device) if it fails
;-----------------------------------------------------------------------------
Find_Matching_IOCB
	sta	AR_Temp
	ldx	#$00
	ldy	#$01
Find_Matching_IOCB_l1
	lda	ICHID,x
	jsr	Get_HATABS_Entry
	cmp	AR_Temp							; Compare device ID with the one searched
	beq	Find_Matching_IOCB_Found
	txa
	add	#$10							; Add IOCB structure length to x pointer, and try next channel
	tax
	bpl	Find_Matching_IOCB_l1
	ldy	#-126							; If fails, change error code to "NONEXISTENT DEVICE"
Find_Matching_IOCB_Found
	rts

;-----------------------------------------------------------------------------
;Find_First_IOCB - search for first free IOCB
; returns:
; X - relative offset to first free IOCB (IOCB number * $10)
; Y - error code (95 - too many channels open) if it fails;
; This piece of code comes from Polish Atariki page
; there are no references for its orgins
;-----------------------------------------------------------------------------
Find_First_IOCB
	ldx	#$00							; Start with channel #0
	ldy	#$01							; Set the error code to #1 - success
Find_First_IOCB_l1
	lda	ICHID,x							; Get the device ID
	cmp	#$FF							; If equals to $ff - channel is not opened
	beq	Find_First_IOCB_found
	txa
	add	#$10							; Add IOCB structure length to x pointer, and try next channel
	tax
	bpl	Find_First_IOCB_l1
	ldy	#-95							; If fails, change error code to "TOO MANY CHANNELS OPEN"
Find_First_IOCB_found
	rts

;-----------------------------------------------------------------------------
; PutLine - puts line of text pointed by TextPtr ending with ENTER ($9b)
;-----------------------------------------------------------------------------
PutLine
	ldx	Console_IOCB
	cpx	#$FF
	bne	PutLine_IOCB_Open
	lda	#'E'
	jsr	Find_Matching_IOCB
	cpy	#$01
	beq	PutLine_IOCB_Found
	lda	#'E'							; Open through console handler
	ldy	#$00								; Mode 0 - standard text console
	jsr	SetGraphicsMode
PutLine_IOCB_Open
PutLine_IOCB_Found
	lda	#CIO_puttext
	sta	ICCMD,x
	lda	#$FF
	sta	ICBLL,x
	lda	TextPtr
	sta	ICBAL,x
	lda	TextPtr+1
	sta	ICBAL+1,x
	jsr	CIOV
PutLine_Error
	rts

;-----------------------------------------------------------------------------
; Set_Graphics_Mode - sets graphics mode
; takes:
; A - device handler (E, S)
; X - IOCB offset (IOCB channel number multiplied by 16)
; Y - mode to set
; returns:
; Y - error code (95 - too many channels open) if it fails
;-----------------------------------------------------------------------------
SetGraphicsMode
	jsr	Find_First_IOCB					; Find first free IOCB
	cpy	#1
	bne	SetGraphicsMode_Error			; No more free IOCB
	sta	Temporary_Handler
	lda	#<Temporary_Handler
	sta	ICBAL,x
	lda	#>Temporary_Handler
	sta	ICBAL+1,x
SetGraphicsMode_Common
	tya
	sta	ICAX2,x							; Mode to obtain
	lda	#CIO_open
	sta	ICCMD,x
	lda	#CIO_read | CIO_write			; READ and WRITE
	sta	ICAX1,x
	jsr	CIOV
SetGraphicsMode_Error
	rts
