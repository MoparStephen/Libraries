
.if .not .def __VBXE_AUTO__ .and .not .def __VBXE_D700__	; default case - vbxe at $d640
VBXE_BASE		equ	$D600
.elseif .not .def __VBXE_AUTO__ .and def __VBXE_D700__		; vbxe is assumed to be under $d740
VBXE_BASE		equ	$D700
.else								; vbxe should be autodetected
VBXE_BASE		equ	$0000
.endif

VBXE_VIDEO_CONTROL		equ	VBXE_BASE+$40	; Write
VBXE_CORE_VERSION		equ	VBXE_BASE+$40	; Read
VBXE_XDL_ADR0			equ	VBXE_BASE+$41	; Write
VBXE_MINOR				equ	VBXE_BASE+$41	; Read
VBXE_XDL_ADR1			equ	VBXE_BASE+$42
VBXE_XDL_ADR2			equ	VBXE_BASE+$43
VBXE_CSEL				equ	VBXE_BASE+$44
VBXE_PSEL				equ	VBXE_BASE+$45
VBXE_CR					equ	VBXE_BASE+$46
VBXE_CG					equ	VBXE_BASE+$47
VBXE_CB					equ	VBXE_BASE+$48
VBXE_COLMASK			equ	VBXE_BASE+$49
VBXE_COLCLR				equ	VBXE_BASE+$4A
VBXE_BL_ADR0			equ	VBXE_BASE+$50	; Write
VBXE_BLT_COLLISION_CODE	equ	VBXE_BASE+$50	; Read
VBXE_BL_ADR1			equ	VBXE_BASE+$51
VBXE_BL_ADR2			equ	VBXE_BASE+$52
VBXE_BLITTER_START		equ	VBXE_BASE+$53	; Write
VBXE_BLITTER_BUSY		equ	VBXE_BASE+$53	; Read
VBXE_IRQ_CONTROL		equ	VBXE_BASE+$54	; Write
VBXE_IRQ_STATUS			equ	VBXE_BASE+$54	; Read
VBXE_P0					equ	VBXE_BASE+$55
VBXE_P1					equ	VBXE_BASE+$55
VBXE_P2					equ	VBXE_BASE+$55
VBXE_P3					equ	VBXE_BASE+$55
VBXE_MB_CTL				equ	VBXE_BASE+$5D
VBXE_MA_CTL				equ	VBXE_BASE+$5E
VBXE_MA_BSEL			equ	VBXE_BASE+$5F

/* Renamed to match fx1.26-en
VBXE_VIDEO_CONTROL		equ	VBXE_BASE+$40	; Write
VBXE_CORE_VERSION		equ	VBXE_BASE+$40	; Read
VBXE_XDL_ADR0			equ	VBXE_BASE+$41	; Write
VBXE_MINOR_REVISION		equ	VBXE_BASE+$41	; Read
VBXE_XDL_ADR1			equ	VBXE_BASE+$42
VBXE_XDL_ADR2			equ	VBXE_BASE+$43
VBXE_CSEL				equ	VBXE_BASE+$44
VBXE_PSEL				equ	VBXE_BASE+$45
VBXE_CR					equ	VBXE_BASE+$46
VBXE_CG					equ	VBXE_BASE+$47
VBXE_CB					equ	VBXE_BASE+$48
VBXE_COLMASK			equ	VBXE_BASE+$49
VBXE_COLCLR				equ	VBXE_BASE+$4A	; Write
VBXE_COLDETECT			equ	VBXE_BASE+$4A	; Read
VBXE_BL_ADR0			equ	VBXE_BASE+$50	; Write
VBXE_BLT_COLLISION_CODE	equ	VBXE_BASE+$50	; Read
VBXE_BL_ADR1			equ	VBXE_BASE+$51
VBXE_BL_ADR2			equ	VBXE_BASE+$52
VBXE_BLITTER_START		equ	VBXE_BASE+$53	; Write
VBXE_BLITTER_BUSY		equ	VBXE_BASE+$53	; Read
VBXE_IRQ_CONTROL		equ	VBXE_BASE+$54	; Write
VBXE_IRQ_STATUS			equ	VBXE_BASE+$54	; Read
VBXE_P0					equ	VBXE_BASE+$55
VBXE_P1					equ	VBXE_BASE+$55
VBXE_P2					equ	VBXE_BASE+$55
VBXE_P3					equ	VBXE_BASE+$55
VBXE_MEMAC_B_CONTROL	equ	VBXE_BASE+$5D
VBXE_MEMAC_CONTROL		equ	VBXE_BASE+$5E	; Write
VBXE_MEMAC_CONTROL		equ	VBXE_BASE+$5E	; Read
VBXE_MEMAC_BANK_SEL		equ	VBXE_BASE+$5F	; Write
VBXE_MEMAC_BANK_SEL		equ	VBXE_BASE+$5F	; Read
*/

MEMAC_GLOBAL_DISABLE	equ	$00
MEMAC_GLOBAL_ENABLE		equ	$80

;--------------------------------------------------------
;		Structures for VBXE
;--------------------------------------------------------
.struct BLTBLK	
	orgin_ptr	.long
	ostep_y		.word
	ostep_x		.byte
	dest_ptr	.long
	dstep_y		.word
	dstep_x		.byte
	width		.word
	height		.byte
	and_mask	.byte
	xor_mask	.byte
	col_mask	.byte
	zoom		.byte
	pattern		.byte
	control		.byte
.ends

;--------------------------------------------------------
;		Zero page variables for VBXE
;--------------------------------------------------------
.zpvar	VBXEBase	.word
.zpvar	Y_Register	.byte

;--------------------------------------------------------
;		Other variables for VBXE
;--------------------------------------------------------
.var	Pal_ptr		.word

;--------------------------------------------------------
;		Macro definitions for VBXE
;--------------------------------------------------------

;--------------------------------------------------------
;vblda	- loads accumulator with VBXE register value
;	  use:	vblda	VBXE_REGISTER

vblda	.macro
.ifdef	__VBXE_AUTO__
	lda	VBXEBase+1
	sta	vblda_adr
	lda.w	:1
vblda_adr	equ *-1
.else
	lda	:1
.endif
.endm

;--------------------------------------------------------
;vbsta	- stores accumulator in VBXE register
;	  use:	vbsta	VBXE_REGISTER

vbsta	.macro
.ifdef	__VBXE_AUTO__
	pha
	lda	VBXEBase+1
	sta	vbsta_adr
	pla
	sta.w	:1
vbsta_adr	equ *-1
.else
	sta.w	:1
.endif
.endm

;--------------------------------------------------------
;		Common calls for VBXE
;--------------------------------------------------------

;--------------------------------------------------------
;VBXE_Detect - detects VBXE FX core version 1.07 and above,
; and stores VBXE Base address in VBXEBase
VBXE_Detect
	lda	#0
	ldx	#$d6
	sta	$d640			; make sure it isn't coincidence
	lda	$d640
	cmp	#$10			; do we have major version here?
	beq	VBXE_Detected	; if so, then VBXE is detected
	lda	#0
	inx
	sta	$d740			; no such luck, try other location
	lda	$d740
	cmp	#$10
	beq	VBXE_Detected
	ldx 	#0  		; not here, so not present or FX core version too low
	stx	VBXEBase+1
	stx	VBXEBase
	sec
	rts
VBXE_Detected:
	stx	VBXEBase+1
	lda	#0
	sta	VBXEBase
	vblda	VBXE_MINOR	; get core minor version
	clc	 				; x - page of vbxe
	rts

;--------------------------------------------------------
; VBXE_SetPalette2 - sets palette
;	A			- palette number
;	Y_Register	- palette pointer - Data MUST be page aligned
; NOTE: This code can run from ROM
;       The palette is stored as 256 RGB triplets
VBXE_SetPalette2
	vbsta VBXE_PSEL				; Set Palette 1
	lda #0
	vbsta VBXE_CSEL				; Start at colour 0

	tay
LoadPal1_1 lda (Y_Register),y
	sta	VBXE_CR					; set the red component
	iny
	beq OverFlow1				; since 256 / 3 is not even, we must skip to next section and resume at CG
	lda (Y_Register),y
	sta	VBXE_CG					; set the green component
	iny
	lda (Y_Register),y
	sta	VBXE_CB					; set the blue component and increment CSEL
	iny
	bne	LoadPal1_1				; copy a page
LoadPal1_2 lda (Y_Register),y
	sta	VBXE_CR					; set the red component
	iny
	beq LoadPal1_3
LP1_2_G
	lda (Y_Register),y
	sta	VBXE_CG					; set the green component
	iny
	beq OverFlow2				; since 256 / 3 is not even, we must skip to next section and resume at CB
	lda (Y_Register),y
	sta	VBXE_CB					; set the blue component and increment CSEL
	iny
	bne	LoadPal1_2				; copy a page
LoadPal1_3 lda (Y_Register),y
	sta	VBXE_CR					; set the red component
	iny
	lda (Y_Register),y
	sta	VBXE_CG					; set the green component
	iny
LP1_3_B
	lda (Y_Register),y
	sta	VBXE_CB					; set the blue component and increment CSEL
	iny
	bne	LoadPal1_3				; copy a page
	rts

OverFlow1
	inc Y_Register + 1
	jmp LP1_2_G
OverFlow2
	inc Y_Register + 1
	jmp LP1_3_B
