*= $1000

:BasicUpstart2(start)

start:
	lda $d018
	ora #$08
	sta $d018

	lda $d011
	ora #$20
	sta $d011
	
	// riempie la memoria schermo 
	// (locazioni 1024-2023)
	// con il valore 1.

	ldx #$00
	lda #$01

loop:	
	sta $0400,x
	sta $0500,x
	sta $0600,X
	sta $06E8,X
	inx              //Increment accumulator until 256 bytes read
	bne loop

	//////////////////////////

	jmp *

.pc=$2000
.import c64 "hires.dat"
