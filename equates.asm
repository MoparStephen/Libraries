; OS Vectors
LINZBS      equ $00         ; Word
CASINI      equ $02         ; Word
RAMLO       equ $04         ; Word
TRAMSZ      equ $06
TSTDAT      equ $07
WARMST      equ $08
BOOT        equ $09
DOSVEC      equ $0A         ; Word
DOSINI      equ $0C         ; Word
APPMHI      equ $0E         ; Word
POKMSK      equ $10
BRKKEY      EQU $11
RTCLOK      equ $12         ; $12, $13, $14 are used
BUFADR      equ $15         ; Word
ICCOMT      equ $17
DSKFMS      equ $18         ; Word
DSKUTL      equ $1A         ; Word
PTIMOT      equ $1C
PBPNT       equ $1D
PBUFSZ      equ $1E
PTEMP       equ $1F
ICHIDZ      equ $20
ICDNOZ      equ $21
ICCOMZ      equ $22
ICSTAZ      equ $23
ICBALZ      equ $24
ICBAHZ      equ $25
ICPTLZ      equ $26
ICPTHZ      equ $27
ICBLLZ      equ $28
ICBLHZ      equ $29
ICAX1Z      equ $2A
ICAX2Z      equ $2B
ICAX3Z      equ $2C
ICAX4Z      equ $2D
ICAX5Z      equ $2E
ICAX6Z      equ $2F
STATUS      equ $30
CHKSUM      equ $31
BUFRLO      equ $32
BUFRHI      equ $33
BFENLO      equ $34
BFENHI      equ $35
CRETRY      equ $36
DRETRY      equ $37
BUFRFL      equ $38
RECVDN      equ $39
XMTDON      equ $3A
CHKSNT      equ $3B
NOCKSUM     equ $3C
BPTR        equ $3D
FTYPE       equ $3E
FEOF        equ $3F
FREQ        equ $40
SOUNDR      equ $41         ; 0 = quiet SIO, 1 = loud SIO
CRITIC      equ $42
FMZSPG      equ $43         ; 7 bytes FMS registers
ZBUFP       equ $43         ; Word
ZDRVA       equ $45         ; Word
ZSBA        equ $47         ; Word
ERRNO       equ $49
CKEY        equ $4A
CASSBT      equ $4B
DSTAT       equ $4C
ATRACT      equ $4D
DRKMSK      equ $4E
COLRSH      equ $4F
TEMP        equ $50
HOLD1       equ $51
LMARGIN     equ $52
RMARGIN     equ $53
ROWCRS      equ $54
COLCRS      equ $55         ; $55-$56
DINDEX      equ $57         ; Display Mode
SAVMSC      equ $58         ; $58-$59
OLDROW      equ $5A
OLDCOL      equ $5B         ; Word
OLDCHR      equ $5D
OLDADR      equ $5E         ; Word
NEWROW      equ $60
NEWCOL      equ $61         ; Word
LOGCOL      equ $63
ADRESS      equ $64         ; Word
MLTTMP      equ $66         ; Word
SAVADR      equ $68         ; Word
RAMTOP      equ $6A
BUFCNT      equ $6B
BUFSTR      equ $6C         ; Word
BITMSK      equ $6E
SHFAMT      equ $6F
ROLAC       equ $70         ; Word
COLAC       equ $72         ; Word
ENDPT       equ $74         ; Word
DELATR      equ $76
DELTAC      equ $77         ; Word
ROWINC      equ $79
COLINC      equ $7A
SWPFLG      equ $7B
HOLDCH      equ $7C
INSDAT      equ $7D
;---------------------------------------
; Mapping Atari Page 26 Starts Here
;      RESUME ENTERING DATA HERE
;---------------------------------------
COUNTR      equ $7E         ; Word
; $D4-$FF reserved for Floating Point routines
FR0         equ $D4         ; $D4-$D9 6-byte BCD Floating Point Register 0
; $DA-$DF free?
FR1         equ $E0         ; $E0-$E5 6-byte BCD Floating Point Register 1
FR2         equ $E6         ; $E6-$EB 6-byte BCD Floating Point Register 2
FRX         equ $EC         ; Spare FP register
EEXP        equ $ED         ; Value of exponent
NSIGN       equ $EE         ; Sign of the Floating Point number
ESIGN       equ $EF         ; Sign of the exponent
FCHRFLG     equ $F0         ; First character flag
DIGRT       equ $F1         ; Number of digits to right of decimal
CIX         equ $F2         ; Character Input indeX - offset into INBUFF
INBUFF      equ $F3         ; $F3-$F4 Input ASCII pointer.  Result output buffer is $580-$5FF
INBUFF_LO   equ $F3         ; $F3-$F4 Input ASCII pointer.  Result output buffer is $580-$5FF
INBUFF_HI   equ $F4         ; $F3-$F4 Input ASCII pointer.  Result output buffer is $580-$5FF
ZTEMP1      equ $F5         ; $F5-$F6 Temp register
ZTEMP4      equ $F7         ; $F7-$F8 Temp register
ZTEMP3      equ $F9         ; $F9-$FA Temp register
RADFLG      equ $FB         ; When 0 use Radians (default OS value) else Degrees
FLPTR       equ $FC         ; $FC-$FD Pointer to user's Floating Point number 1
FPTR2       equ $FE         ; $FE-$FF Pointer to user's Floating Point number 2
; $0100-$01FF Stack
VDSLST      equ $0200       ; Vector to Display List Interrupt routine (Word)
VPRCED      equ $0202       ; Word
VINTER      equ $0204       ; Word
VBREAK      equ $0206       ; Word
VKEYBD      equ $0208       ; Word
VSERIN      equ $020A       ; Word
VSEROR      equ $020C       ; Word
VSEROC      equ $020E       ; Word
VTIMR1      equ $0210       ; Word
VTIMR2      equ $0212       ; Word
VTIMR4      equ $0214       ; Word
VIMIRQ      equ $0216       ; Word
CDTMV1      equ $0218       ; Word
CDTMV2      equ $021A       ; Word
CDTMV3      equ $021C       ; Word
CDTMV4      equ $021E       ; Word
CDTMV5      equ $0220       ; Word
VVBLKI      equ $0222       ; Word
VVBLKD      equ $0224       ; Word
CDTMA1      equ $0226       ; Word
CDTMA2      equ $0228       ; Word
CDTMF3      equ $022A
SRTIMR      equ $022B
CDTMF4      equ $022C
INTEMP      equ $022D
CDTMF5      equ $022E
SDMCTL      equ $022F
SDLSTL      equ $0230       ; Word
SDLSTH      equ $0231
;---------------------------------------
; Mapping Atari Page 48 Starts Here
;      RESUME ENTERING DATA HERE
;---------------------------------------
GPRIOR      equ $026F
STRIG0      equ $0284       ; 0 = Pressed, 1 = Released
STRIG1      equ $0285       ; 0 = Pressed, 1 = Released
STRIG2      equ $0286       ; 0 = Pressed, 1 = Released
STRIG3      equ $0287       ; 0 = Pressed, 1 = Released
TXTROW      equ $0290
TXTCOL      equ $0291       ; Word
PCOLR0      equ $02C0       ; Shadows for $2C0 -> $D012 - $2C8 -> $D01A
PCOLR1      equ $02C1
PCOLR2      equ $02C2
PCOLR3      equ $02C3
COLOR0      equ $02C4
COLOR1      equ $02C5       ; Text      in GR.0
COLOR2      equ $02C6       ; Playfield in GR.0
COLOR3      equ $02C7
COLOR4      equ $02C8       ; Border    in GR.0
KRPDEL      equ $02D9       ; Auto Repeat Delay
KEYREP      equ $02DA       ; Auto Repeat Rate
NOCLIK      equ $02DB       ; Key Click Disable Flag
HELPFLG     equ $02DC       ; Help Key Flag
RAMSIZ      equ $02E4       ; RAM Size (Hi Byte)
MEMTOP      equ $02E5       ; Word Top of user RAM
MEMLO       equ $02E7       ; Word Bottom of user RAM
DVSTAT      equ $02EA       ; 4-byte Device Status for IOCB
CRSINH      equ $02F0       ; Cursor Inhibit (0 = On)
CHACT       equ $02F3       ; Shadow for CHACTL
CHBASE      equ $02F4
DSPFLG      equ $02FE       ; Display control chars is non-zero
CH          equ $02FC       ; Last Key Pressed

; DCB (Device Control Block) for SIO
DDEVIC      equ $0300
DUNIT       equ $0301
DCOMND      equ $0302
DSTATS      equ $0303
DBUFLO      equ $0304
DBUFHI      equ $0305
DTIMLO      equ $0306
DUNUSE      equ $0307
DBYTLO      equ $0308
DBYTHI      equ $0309
DAUX1       equ $030A
DAUX2       equ $030B
TIMER1      equ $030C       ; Word
HATABS      equ $031A

/*
$0340-$034F: IOCB For Channel 0
$0350-$035F: IOCB For Channel 1
$0360-$036F: IOCB For Channel 2
$0370-$037F: IOCB For Channel 3
$0380-$038F: IOCB For Channel 4
$0390-$039F: IOCB For Channel 5
$03A0-$03AF: IOCB For Channel 6
$03B0-$03BF: IOCB For Channel 7
*/

ICHID       equ $0340       ; Index into device name
ICDNO       equ $0341       ; Device #
ICCOM       equ $0342       ; Command
ICCMD       equ $0342       ; Command
ICSTA       equ $0343       ; Most recent device status
ICBAL       equ $0344       ; Buffer for data transfer or address of filename for OPEN
ICBAH       equ $0345       ; Buffer for data transfer or address of filename for OPEN
ICPTL       equ $0346       ; Address of PUT-one-byte routine minus one
ICPTH       equ $0347       ; Address of PUT-one-byte routine minus one
ICBLL       equ $0348       ; Buffer length, max # bytes to PUT or GET
ICBLH       equ $0349       ; Buffer length, max # bytes to PUT or GET
ICAX1       equ $034A       ; Auxiliary Byte 1
ICAX2       equ $034B       ; Auxiliary Byte 2
ICAX3       equ $034C       ; Auxiliary Byte 3
ICAX4       equ $034D       ; Auxiliary Byte 4
ICAX5       equ $034E       ; Auxiliary Byte 5
ICAX6       equ $034F       ; Auxiliary Byte 6

LINBUFF     equ $0580       ; FP ASCII output buffer, $580-$5FF

;-----------------------------------------------------------------------------
;  HARDWARE EQUATES
;-----------------------------------------------------------------------------
; GTIA (D000-D0FF)
HPOSP0      equ $D000
HPOSP1      equ $D001
HPOSP2      equ $D002
HPOSP3      equ $D003
HPOSM0      equ $D004
HPOSM1      equ $D005
HPOSM2      equ $D006
HPOSM3      equ $D007
SIZEP0      equ $D008
SIZEP1      equ $D009
SIZEP2      equ $D00A
SIZEP3      equ $D00B
SIZEM       equ $D00C
GRAFP0      equ $D00D       ; W
P1PL        equ $D00D       ; R
GRAFP1      equ $D00E       ; W
P2PL        equ $D00E       ; R
GRAFP2      equ $D00F       ; W
P3PL        equ $D00F       ; R
GRAFP3      equ $D010       ; W
TRIG0       equ $D010       ; R
GRAFM       equ $D011       ; W
TRIG1       equ $D011       ; R
COLPM0      equ $D012       ; Shadowed to $D012 -> $2C0 - $D01A -> $2C8
COLPM1      equ $D013
COLPM2      equ $D014
COLPM3      equ $D015
COLPF0      equ $D016
COLPF1      equ $D017
COLPF2      equ $D018
COLPF3      equ $D019
COLBAK      equ $D01A
PRIOR       equ $D01B
GRACTL      equ $D01D
CONSOL      equ $D01F

; POKEY (D200-D2FF)
AUDF1       equ $D200   ; W
POT0        equ $D200   ; R
AUDC1       equ $D201
STIMER      equ $D209   ; W
KBCODE      equ $D209   ; R
SKSTAT      equ $D20F
RANDOM      equ $D20A
IRQEN       equ $D20E

; PIA (D300-D3FF)
PORTA       equ $D300
PORTB       equ $D301
PACTL       equ $D302
PBCTL       equ $D303
; $D304-$D3FF continually repeat $D300-$D304

; ANTIC (D400-D5FF)
DMACTL      equ $D400
CHACTL      equ $D401
DLISTL      equ $D402
DLISTH      equ $D403
HSCROL      equ $D404
VSCROL      equ $D405
PMBASE      equ $D407
WSYNC       equ $D40A
VCOUNT      equ $D40B
NMIEN       equ $D40E
NMIST       equ $D40F

; FP ROM ($D800-$DFFF)
AFP         equ $D800       ; ASCII to FP
FASC        equ $D8E6       ; FP to ASCII
IFP         equ $D9AA       ; integer to FP
FPI         equ $D9D2       ; FP to integer
ZFR0        equ $DA44       ; clear FR0
ZF1         equ $DA46       ; clear zero page FP buffer
FSUB        equ $DA60       ; FR0 - FR1
FADD        equ $DA66       ; FR0 + FR1
FMUL        equ $DADB       ; FR0 * FR1
FDIV        equ $DB28       ; FR0 / FR1
PLYEVL      equ $DD40       ; polynomial evaluation
FLD0R       equ $DD89       ; load FR0 by X,Y register pointer
FLD0P       equ $DD8D       ; load FR0 by FLPTR pointer
FLD1R       equ $DD98       ; load FR1 by X,Y register pointer
FLD1P       equ $DD9C       ; load FR1 by FLPTR pointer
FST0R       equ $DDA7       ; store FR0 at buffer by X,Y register pointer
FST1P       equ $DDAB       ; store FR0 at buffer by FLPTR pointer
FMOVE       equ $DDB6       ; move FR0 to FR1
EXP         equ $DDC0       ; e exponentiation
EXP10       equ $DDCC       ; base 10 exponentiation
LOG         equ $DECD       ; natural log of FR0
LOG10       equ $DED1       ; base 10 log of FR0

; ROM Vectors
CIOV        equ $E456
SIOV        equ $E459
SETVBV      equ $E45C       ; Set system timers and interrupt vectors
SYSVBV      equ $E45F       ; Stage one VBLANK calculations entry point
XITVBV      equ $E462       ; Exit VBLANK routine entry point
BLKBDV      equ $E471       ; Memo Pad Vector
WARMSV      equ $E474       ; Warm Reset Vector
COLDSV      equ $E477       ; Cold Reset Vector