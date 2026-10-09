#NO_APP
	.file	"seqgen.c"
	.text
	.align	2
	.type	put_number, @function
put_number:
	lea (-24,%sp),%sp
	move.l 36(%sp),%d0
	movem.l #17436,(%sp)
	move.l 28(%sp),%a2
	move.l 32(%sp),%a0
	tst.l %d0
	jlt .L21
	mov3q.l #4,%d2
	clr.l %d1
.L5:
	moveq #10,%d3
	subq.l #1,%d2
	rems.l %d3,%d4:%d0
	divs.l %d3,%d0
	move.l %d4,%a6
	lea (48,%a6),%a6
	move.w %a6,%d3
	move.b %d3,20(%sp,%d1.l)
	addq.l #1,%d1
	tst.l %d0
	jeq .L6
	tst.l %d2
	jne .L5
.L6:
	move.l %a0,%d0
	subq.l #1,%d1
	addq.l #1,%d0
	moveq #15,%d2
	cmp.l %a0,%d2
	jeq .L22
.L8:
	lea 20(%sp,%d1.l),%a1
	move.b (%a1),(%a2,%a0.l)
	tst.l %d1
	jeq .L7
	move.l %d0,%a0
	subq.l #1,%d1
	move.l %a0,%d0
	moveq #15,%d2
	addq.l #1,%d0
	cmp.l %a0,%d2
	jne .L8
.L22:
	moveq #15,%d0
.L7:
	clr.b %d3
	move.b %d3,(%a2,%d0.l)
	movem.l (%sp),#17436
	lea (24,%sp),%sp
	rts
.L21:
	moveq #15,%d1
	cmp.l %a0,%d1
	jeq .L3
	moveq #45,%d2
	move.b %d2,(%a2,%a0.l)
	addq.l #1,%a0
.L3:
	neg.l %d0
	mov3q.l #4,%d2
	clr.l %d1
	jra .L5
	.size	put_number, .-put_number
	.align	2
	.type	ensure_params.part.0, @function
ensure_params.part.0:
	move.w #8,%a1
	move.l %a2,-(%sp)
	clr.l %d1
	lea evo_seed,%a2
.L24:
	move.l %d1,%d0
	move.l %d1,%a0
	addq.l #1,%d1
	lsl.l #4,%d0
	move.l %d1,(%a2,%a0.l*4)
	subq.l #1,%a1
	move.l %d0,%a0
	move.l #805371929,%d0
	add.l #params,%a0
	move.l %d0,4(%a0)
	move.l #65548,%d0
	move.l #658464,(%a0)
	clr.l 8(%a0)
	move.l %d0,12(%a0)
	tst.l %a1
	jne .L24
	move.l (%sp)+,%a2
	mov3q.l #1,params_ready
	rts
	.size	ensure_params.part.0, .-ensure_params.part.0
	.align	2
	.type	sg_read_phrase.part.0, @function
sg_read_phrase.part.0:
	lea (-32,%sp),%sp
	clr.l %d1
	movem.l #3324,(%sp)
	move.l 36(%sp),%a1
	moveq #64,%d3
	move.l 40(%sp),%a2
	move.l 44(%sp),%d4
.L29:
	mvz.w %d1,%d2
	move.l %d1,%d0
	subq.l #1,%d3
	lsl.l #3,%d0
	clr.b %d5
	lsl.l #3,%d2
	clr.w %d7
	addq.l #1,%d1
	move.b %d5,7(%a1,%d0.l)
	move.b %d5,5(%a1,%d0.l)
	move.w %d7,(%a1,%d2.l)
	clr.b %d2
	moveq #-1,%d5
	moveq #-128,%d7
	move.b %d2,6(%a1,%d0.l)
	move.w %d5,2(%a1,%d0.l)
	move.b %d7,4(%a1,%d0.l)
	tst.l %d3
	jne .L29
	move.b %d4,512(%a1)
	tst.l %d4
	jeq .L30
.L38:
	move.l %d3,%d1
	lsr.l #3,%d1
	mov3q.l #7,%d5
	and.l %d3,%d5
	mov3q.l #7,%a0
	sub.l %d1,%a0
	moveq #79,%d6
	mov3q.l #1,%d7
	sub.l %d1,%d6
	mvz.b (%a2,%a0.l),%d1
	mvz.w %d3,%d0
	asr.l %d5,%d1
	move.l %d0,%d2
	lsl.l #3,%d2
	lsl.l #5,%d0
	and.l %d7,%d1
	lea 89(%a2,%d0.l),%a0
	move.b %d1,(%a1,%d2.l)
	mvz.b (%a2,%d6.l),%d0
	asr.l %d5,%d0
	and.l %d7,%d0
	move.b %d0,1(%a1,%d2.l)
	mvz.b (%a0),%d0
	cmp.l #255,%d0
	jeq .L39
	move.l %d0,%d1
	add.l #-64,%d1
	tst.l %d1
	jlt .L32
	add.l #-62,%d0
	mov3q.l #5,%d2
	divs.l %d2,%d0
.L33:
	moveq #12,%d7
	cmp.l %d0,%d7
	jge .L34
	moveq #12,%d0
.L31:
	move.l %d3,%d1
	lsl.l #3,%d1
	move.b %d0,4(%a1,%d1.l)
	move.b 13(%a0),%d0
	jmi .L47
.L36:
	move.b %d0,2(%a1,%d1.l)
	move.b 15(%a0),%d0
	jmi .L48
.L37:
	move.b %d0,3(%a1,%d1.l)
	addq.l #1,%d3
	cmp.l %d4,%d3
	jcs .L38
.L30:
	movem.l (%sp),#3324
	mov3q.l #1,%d0
	lea (32,%sp),%sp
	rts
.L47:
	st %d0
	move.b %d0,2(%a1,%d1.l)
	move.b 15(%a0),%d0
	jpl .L37
.L48:
	st %d0
	addq.l #1,%d3
	move.b %d0,3(%a1,%d1.l)
	cmp.l %d4,%d3
	jcs .L38
	jra .L30
.L34:
	moveq #-12,%d1
	cmp.l %d0,%d1
	jle .L31
	move.l %d3,%d1
	moveq #-12,%d0
	lsl.l #3,%d1
	move.b %d0,4(%a1,%d1.l)
	move.b 13(%a0),%d0
	jpl .L36
	jra .L47
.L39:
	move.l %d3,%d1
	moveq #-128,%d0
	lsl.l #3,%d1
	move.b %d0,4(%a1,%d1.l)
	move.b 13(%a0),%d0
	jpl .L36
	jra .L47
.L32:
	mov3q.l #2,%d0
	sub.l %d1,%d0
	moveq #-5,%d5
	divs.l %d5,%d0
	jra .L33
	.size	sg_read_phrase.part.0, .-sg_read_phrase.part.0
	.align	2
	.globl	seqgen_close
	.type	seqgen_close, @function
seqgen_close:
	tst.l win
	jeq .L49
	pea win
	jsr 1074093492
	pea seqgen_layer
	jsr 1073943660
	clr.l close_pending
	mov3q.l #1,1187497772
	addq.l #8,%sp
.L49:
	rts
	.size	seqgen_close, .-seqgen_close
	.align	2
	.type	pick, @function
pick:
	lea (-560,%sp),%sp
	movem.l #31996,(%sp)
	move.l 568(%sp),%d3
	move.l 564(%sp),%a2
	move.l 572(%sp),%d4
	move.l 576(%sp),%a3
	tst.l %d3
	jeq .L54
	move.l 580(%sp),%a0
	sub.l %a6,%a6
	move.l (%a0),44(%sp)
	move.l 44(%sp),%d2
.L58:
	add.l #1831565813,%d2
	move.l %d2,%d5
	moveq #15,%d7
	mvz.w %a6,%d1
	clr.w %d5
	swap %d5
	lea (%sp,%a6.l*4),%a0
	move.l %a6,%d0
	mvz.w (%a3,%d1.l*2),%d6
	move.l %d5,%d1
	move.l %d6,%d5
	eor.l %d2,%d1
	move.l #569420461,%d6
	swap %d5
	clr.w %d5
	muls.l %d6,%d1
	move.l %d1,%d6
	lsr.l %d7,%d6
	eor.l %d6,%d1
	move.l #1935289751,%d6
	muls.l %d6,%d1
	move.l %d1,%d6
	lsr.l %d7,%d6
	eor.l %d6,%d1
	mvz.w %d1,%d1
	add.l %d1,%d5
	move.l %d5,304(%a0)
	tst.l %a6
	jeq .L64
.L55:
	lea (560,%sp),%a1
	move.l %d0,%d1
	subq.l #1,%d0
	lea (%a1,%d0.l*4),%a0
	lea (%a1,%d1.l*4),%a4
	move.l -512(%a0),%a0
	lea (%a1,%a0.l*4),%a1
	cmp.l -256(%a1),%d5
	jls .L56
	move.l %a0,-512(%a4)
	tst.l %d0
	jne .L55
.L64:
	clr.l %d1
.L56:
	lea (%sp,%d1.l*4),%a0
	move.l %a6,48(%a0)
	addq.l #1,%a6
	cmp.l %d3,%a6
	jcs .L58
	move.l #1831565813,%d1
	clr.l %d0
	muls.l %d3,%d1
	move.l 580(%sp),%a0
	add.l 44(%sp),%d1
	move.l %d1,(%a0)
.L59:
	clr.b %d1
	move.b %d1,(%a2,%d0.l)
	addq.l #1,%d0
	cmp.l %d3,%d0
	jcs .L59
.L54:
	clr.l %d0
	tst.l %d4
	jeq .L53
.L60:
	lea (560,%sp),%a1
	lea (%a1,%d0.l*4),%a0
	cmp.l %d3,%d0
	jcc .L53
	moveq #1,%d2
	move.l -512(%a0),%d1
	addq.l #1,%d0
	move.b %d2,(%a2,%d1.l)
	cmp.l %d4,%d0
	jcs .L60
.L53:
	movem.l (%sp),#31996
	lea (560,%sp),%sp
	rts
	.size	pick, .-pick
	.align	2
	.type	shuffle_fields, @function
shuffle_fields:
	lea (-296,%sp),%sp
	movem.l #23804,(%sp)
	move.l 300(%sp),%a0
	move.l 304(%sp),%d5
	move.l 308(%sp),%a6
	move.l 312(%sp),%a1
	move.b 512(%a0),%d4
	jeq .L75
	mvz.b %d4,%d4
	clr.l %d0
	clr.l %d1
.L80:
	move.l %d0,%d2
	lsl.l #3,%d2
	tst.b (%a0,%d2.l)
	jne .L97
.L78:
	addq.l #1,%d0
	cmp.l %d0,%d4
	jhi .L80
.L98:
	mov3q.l #1,%d7
	cmp.l %d1,%d7
	jcc .L75
	move.l %a6,%d4
	and.l %d7,%d4
	move.l (%a1),%d3
.L84:
	add.l #1831565813,%d3
	move.l %d3,%d0
	move.l #569420461,%d2
	clr.w %d0
	swap %d0
	moveq #15,%d5
	move.l #1935289751,%d6
	move.l %d3,(%a1)
	eor.l %d3,%d0
	muls.l %d2,%d0
	move.l %d0,%d2
	lsr.l %d5,%d2
	eor.l %d2,%d0
	muls.l %d6,%d0
	move.l %d0,%d2
	lsr.l %d5,%d2
	eor.l %d2,%d0
	remu.l %d1,%d2:%d0
	subq.l #1,%d1
	lea (%sp,%d1.l*4),%a3
	lea (%sp,%d2.l*4),%a2
	move.l 40(%a3),%d2
	move.l %d2,%d5
	lsl.l #3,%d5
	move.l 40(%a2),%d0
	tst.l %d4
	jne .L81
	move.l %d5,%d6
	move.l %d0,%d5
	lsl.l #3,%d5
	mov3q.l #2,%d7
	cmp.l %a6,%d7
	jeq .L94
	lsl.l #3,%d0
	move.l %d6,%d5
	lea 3(%a0,%d0.l),%a2
	move.b 3(%a0,%d5.l),%d0
	move.b (%a2),3(%a0,%d5.l)
	move.b %d0,(%a2)
.L83:
	mov3q.l #1,%d5
	cmp.l %d1,%d5
	jne .L84
.L75:
	movem.l (%sp),#23804
	lea (296,%sp),%sp
	rts
.L97:
	move.l (%a1),%d3
	add.l #1831565813,%d3
	move.l %d3,%d2
	moveq #15,%d6
	clr.w %d2
	swap %d2
	move.l %d3,(%a1)
	move.l #1935289751,%d7
	lea (296,%sp),%a3
	lea (%a3,%d1.l*4),%a2
	eor.l %d3,%d2
	move.l #569420461,%d3
	muls.l %d3,%d2
	move.l %d2,%d3
	lsr.l %d6,%d3
	eor.l %d3,%d2
	muls.l %d7,%d2
	move.l %d2,%d3
	lsr.l %d6,%d3
	moveq #100,%d6
	eor.l %d3,%d2
	remu.l %d6,%d3:%d2
	cmp.l %d5,%d3
	jcc .L78
	move.l %d0,-256(%a2)
	addq.l #1,%d1
	addq.l #1,%d0
	cmp.l %d0,%d4
	jhi .L80
	jra .L98
.L81:
	lsl.l #3,%d0
	lea (%a0,%d5.l),%a3
	move.b 4(%a3),%d2
	lea (%a0,%d0.l),%a2
	move.b 4(%a2),4(%a3)
	move.b %d2,4(%a2)
	mov3q.l #1,%d2
	cmp.l %a6,%d2
	jeq .L83
	move.b 2(%a3),%d2
	move.b 2(%a2),2(%a3)
	move.b %d2,2(%a2)
	lea 3(%a0,%d0.l),%a2
	move.b 3(%a0,%d5.l),%d0
	move.b (%a2),3(%a0,%d5.l)
	move.b %d0,(%a2)
	jra .L83
.L94:
	lea 2(%a0,%d5.l),%a2
	move.b 2(%a0,%d6.l),%d0
	mov3q.l #1,%d5
	move.b (%a2),2(%a0,%d6.l)
	move.b %d0,(%a2)
	cmp.l %d1,%d5
	jne .L84
	jra .L75
	.size	shuffle_fields, .-shuffle_fields
	.align	2
	.type	gen_cell, @function
gen_cell:
	link.w %fp,#-140
	move.l 24(%fp),%a0
	clr.l %d0
	movem.l #15612,(%sp)
	move.l 8(%fp),%a3
	moveq #8,%d2
	move.l 20(%fp),%d6
	move.l 32(%fp),%a2
	move.l 12(%fp),%d7
	move.l 16(%fp),%d5
.L100:
	clr.w %d1
	clr.l %d3
	clr.l %d4
	subq.l #1,%d2
	move.w %d1,-80(%fp,%d0.l*2)
	move.l %d0,%d1
	addq.l #1,%d0
	lsl.l #3,%d1
	move.l %d3,-64(%fp,%d1.l)
	move.l %d4,-60(%fp,%d1.l)
	tst.l %d2
	jne .L100
	move.l %d7,12(%fp)
	moveq #8,%d4
	move.l %d5,16(%fp)
	move.l %d6,%d3
	cmp.l %d6,%d4
	jcc .L101
	moveq #8,%d3
.L101:
	move.l %a0,%d0
	moveq #16,%d5
	cmp.l %a0,%d5
	jcc .L102
	moveq #16,%d0
.L102:
	mulu.w %d3,%d0
	addq.l #8,%d0
	lsr.l #4,%d0
	jne .L103
	tst.l %a0
	sne %d0
	mvs.b %d0,%d0
	neg.l %d0
.L103:
	moveq #1,%d7
	move.l %a2,-(%sp)
	pea -80(%fp)
	move.l %d0,-(%sp)
	move.l %d3,-(%sp)
	pea -88(%fp)
	move.w %d7,-80(%fp)
	jsr pick
	lea (20,%sp),%sp
	tst.l %d6
	jeq .L104
	tst.b -88(%fp)
	jeq .L124
	move.l 12(%fp),%a5
	clr.l %d1
	move.l 12(%fp),%a1
	moveq #126,%d0
	move.l 108(%a5),%d7
	move.l 112(%a1),%a0
	cmp.l %d7,%d0
	jcs .L125
.L148:
	move.l (%a2),%d0
	add.l #1831565813,%d0
	move.l %d0,%d4
	move.l #569420461,%d5
	clr.w %d4
	swap %d4
	move.l %d0,(%a2)
	move.l 12(%fp),%a1
	eor.l %d0,%d4
	muls.l %d4,%d5
	moveq #15,%d4
	move.l %d5,%d0
	lsr.l %d4,%d0
	move.l %d5,%d4
	move.l #1935289751,%d5
	eor.l %d0,%d4
	muls.l %d4,%d5
	moveq #15,%d4
	move.l %d5,%d0
	lsr.l %d4,%d0
	eor.l %d0,%d5
	mov3q.l #3,%d0
	remu.l %d0,%d4:%d5
	move.l %d4,%d0
	addq.l #2,%d0
	muls.l %d7,%d0
	move.l 100(%a1),%d4
	lsr.l #2,%d0
	move.b %d0,%d5
	tst.l %d4
	jne .L147
.L108:
	move.l 12(%fp),%a4
	move.l %d5,%d0
	move.l %d1,%d7
	lsl.l #3,%d7
	lea 3(%a4,%d4.l*4),%a5
	moveq #1,%d5
	lsl.l #8,%d0
	moveq #127,%d4
	move.b (%a5),-60(%fp,%d7.l)
	move.b %d5,-64(%fp,%d7.l)
	cmp.l %a0,%d4
	jcc .L109
	move.w #127,%a0
.L109:
	move.w %a0,%d5
	move.b %d5,%d0
	move.l 16(%fp),%d5
	move.w %d0,-62(%fp,%d7.l)
	move.l 12(%fp),%d0
.L111:
	addq.l #1,%d1
	cmp.l %d1,%d3
	jls .L143
	tst.b -88(%fp,%d1.l)
	jeq .L111
	move.l %d0,12(%fp)
	move.l 12(%fp),%a5
	move.l %d0,%a4
	move.l 116(%a4),%a0
	moveq #126,%d0
	move.l %d5,16(%fp)
	move.l 108(%a5),%d7
	cmp.l %d7,%d0
	jcc .L148
.L125:
	move.l 12(%fp),%a1
	moveq #127,%d5
	move.l 100(%a1),%d4
	tst.l %d4
	jeq .L108
.L147:
	move.l (%a2),%a1
	add.l #1831565813,%a1
	move.l %a1,%d0
	move.l %a1,%d7
	clr.w %d0
	swap %d0
	move.l %a1,(%a2)
	eor.l %d7,%d0
	move.l #569420461,%d7
	muls.l %d0,%d7
	moveq #15,%d0
	move.l %d7,%a4
	lsr.l %d0,%d7
	move.l %d7,%d0
	move.l %a4,%d7
	eor.l %d0,%d7
	move.l #1935289751,%d0
	muls.l %d7,%d0
	moveq #15,%d7
	move.l %d0,%a4
	lsr.l %d7,%d0
	move.l %a4,%d7
	eor.l %d0,%d7
	remu.l %d4,%d0:%d7
	move.l %d0,%d4
	jra .L108
.L143:
	move.l %d0,12(%fp)
	move.l %d5,16(%fp)
.L104:
	clr.l %d0
	tst.l 16(%fp)
	jeq .L99
	move.l %d6,%a5
	move.l 16(%fp),%d5
	move.l 12(%fp),-96(%fp)
.L112:
	lsl.l #3,%d2
	move.l %d0,%d1
	addq.l #1,%d0
	lsl.l #3,%d1
	move.l -64(%fp,%d2.l),%d6
	move.l -60(%fp,%d2.l),%d7
	move.l %d6,(%a3,%d1.l)
	move.l %d7,4(%a3,%d1.l)
	cmp.l %d5,%d0
	jcc .L99
.L152:
	move.l %d0,%d1
	remu.l %d3,%d2:%d1
	tst.l %d2
	jne .L112
	tst.l 28(%fp)
	jeq .L112
	tst.l %a5
	jne .L149
	clr.l %d7
	lsl.l #3,%d7
	lea (%fp,%d7.l),%a1
	tst.b -64(%a1)
	jeq .L112
.L153:
	move.l -96(%fp),%a4
	move.l 100(%a4),%a0
	tst.l %a0
	jeq .L129
	mvs.b -60(%a1),%d1
	move.w #99,%a1
	move.l %d7,%d4
	move.l %d5,%d6
	clr.l -92(%fp)
	move.l %d1,%a4
	move.l %d3,%d5
	clr.l %d1
	move.l %d2,%d3
	move.l %a5,%d7
	move.l %d0,%d2
	move.l %d4,%d0
.L120:
	move.l -96(%fp),%a5
	move.l (%a5,%d1.l*4),%d4
	sub.l %a4,%d4
	jmi .L150
.L118:
	cmp.l %d4,%a1
	jle .L119
	move.l %d1,-92(%fp)
	move.l %d4,%a1
.L119:
	addq.l #1,%d1
	cmp.l %a0,%d1
	jcs .L120
	move.l %d0,%d1
	move.l %d7,%a5
	move.l -92(%fp),%a1
	move.l %d1,%d7
	move.l (%a2),-92(%fp)
	move.l -92(%fp),%a4
	add.l #1831565813,%a4
	move.l %a4,%d4
	move.l %a4,%d1
	clr.w %d4
	swap %d4
	move.l %d2,%d0
	move.l %d3,%d2
	move.l %d5,%d3
	move.l %d6,%d5
	move.l %a4,(%a2)
	add.l %a0,%a1
	eor.l %d4,%d1
	move.l #569420461,%d4
	move.l %d1,%d6
	muls.l %d4,%d6
	moveq #15,%d4
	move.l %d6,%d1
	lsr.l %d4,%d1
	eor.l %d6,%d1
	move.l #1935289751,%d6
	muls.l %d1,%d6
	move.l %d6,%d1
	lsr.l %d4,%d1
	mov3q.l #1,%d4
	eor.l %d6,%d1
	and.l %d1,%d4
	move.l %d4,%a4
	btst #0,%d1
	jeq .L151
.L121:
	add.l %a4,%a1
	move.l %a0,%d1
	move.l %a1,%d6
	remu.l %d1,%d4:%d6
	move.l -96(%fp),%a1
	moveq #126,%d1
	move.l 108(%a1),%a0
	lea 3(%a1,%d4.l*4),%a4
	move.b (%a4),-60(%fp,%d7.l)
	cmp.l %a0,%d1
	jcs .L130
.L154:
	move.l -92(%fp),%d4
	add.l #-631835670,%d4
	move.l %d4,%d1
	moveq #15,%d6
	clr.w %d1
	swap %d1
	move.l %d4,(%a2)
	eor.l %d4,%d1
	move.l #569420461,%d4
	muls.l %d1,%d4
	move.l %d4,%d1
	lsr.l %d6,%d4
	eor.l %d4,%d1
	move.l #1935289751,%d4
	muls.l %d1,%d4
	mov3q.l #3,%d1
	move.l %d4,%a1
	lsr.l %d6,%d4
	move.l %a1,%d6
	eor.l %d4,%d6
	remu.l %d1,%d4:%d6
	move.l %a0,%d6
	move.l %d4,%d1
	addq.l #2,%d1
	muls.l %d6,%d1
	lsr.l #2,%d1
	move.b %d1,-62(%fp,%d7.l)
.L155:
	lsl.l #3,%d2
	move.l %d0,%d1
	addq.l #1,%d0
	lsl.l #3,%d1
	move.l -64(%fp,%d2.l),%d6
	move.l -60(%fp,%d2.l),%d7
	move.l %d6,(%a3,%d1.l)
	move.l %d7,4(%a3,%d1.l)
	cmp.l %d5,%d0
	jcs .L152
.L99:
	movem.l -140(%fp),#15612
	unlk %fp
	rts
.L124:
	move.l 12(%fp),%d0
	clr.l %d1
	move.l 16(%fp),%d5
	jra .L111
.L150:
	neg.l %d4
	jra .L118
.L149:
	move.l (%a2),%d4
	add.l #1831565813,%d4
	move.l %d4,%d1
	move.l #569420461,%d6
	clr.w %d1
	swap %d1
	moveq #15,%d7
	move.l %d4,(%a2)
	eor.l %d4,%d1
	muls.l %d6,%d1
	move.l %d1,%d4
	lsr.l %d7,%d4
	eor.l %d4,%d1
	move.l #1935289751,%d4
	muls.l %d4,%d1
	move.l %d1,%d4
	lsr.l %d7,%d4
	eor.l %d4,%d1
	remu.l %d3,%d7:%d1
	lsl.l #3,%d7
	lea (%fp,%d7.l),%a1
	tst.b -64(%a1)
	jeq .L112
	jra .L153
.L151:
	lea (-1,%a0),%a4
	add.l %a4,%a1
	move.l %a0,%d1
	move.l %a1,%d6
	remu.l %d1,%d4:%d6
	move.l -96(%fp),%a1
	moveq #126,%d1
	move.l 108(%a1),%a0
	lea 3(%a1,%d4.l*4),%a4
	move.b (%a4),-60(%fp,%d7.l)
	cmp.l %a0,%d1
	jcc .L154
.L130:
	moveq #127,%d1
	move.b %d1,-62(%fp,%d7.l)
	jra .L155
.L129:
	move.l (%a2),-92(%fp)
	move.l -92(%fp),%a4
	add.l #1831565813,%a4
	move.l %a4,%d4
	move.l %a4,%d1
	clr.w %d4
	swap %d4
	move.l %a4,(%a2)
	sub.l %a1,%a1
	eor.l %d4,%d1
	move.l #569420461,%d4
	move.l %d1,%d6
	muls.l %d4,%d6
	moveq #15,%d4
	move.l %d6,%d1
	lsr.l %d4,%d1
	eor.l %d6,%d1
	move.l #1935289751,%d6
	muls.l %d1,%d6
	move.l %d6,%d1
	lsr.l %d4,%d1
	mov3q.l #1,%d4
	eor.l %d6,%d1
	and.l %d1,%d4
	move.l %d4,%a4
	btst #0,%d1
	jne .L121
	jra .L151
	.size	gen_cell, .-gen_cell
	.align	2
	.globl	sg_get
	.type	sg_get, @function
sg_get:
	lea (-64,%sp),%sp
	move.l 68(%sp),%d0
	move.l %d0,%a0
	addq.l #1,%a0
	move.l %a0,4(%sp)
	addq.l #1,%a0
	move.l %a0,8(%sp)
	addq.l #1,%a0
	move.l %a0,12(%sp)
	addq.l #6,%a0
	move.l %a0,36(%sp)
	addq.l #1,%a0
	move.l %a0,40(%sp)
	addq.l #1,%a0
	move.l %a0,44(%sp)
	addq.l #1,%a0
	move.l %a0,48(%sp)
	subq.l #8,%a0
	move.l %a0,16(%sp)
	addq.l #1,%a0
	move.l %a0,20(%sp)
	addq.l #1,%a0
	move.l %a0,24(%sp)
	addq.l #1,%a0
	move.l %a0,28(%sp)
	addq.l #6,%a0
	move.l %a0,52(%sp)
	addq.l #1,%a0
	move.l %d0,(%sp)
	move.l %a0,56(%sp)
	addq.l #8,%d0
	move.l 72(%sp),%d1
	addq.l #1,%a0
	move.l %d0,32(%sp)
	moveq #15,%d0
	move.l %a0,60(%sp)
	cmp.l %d1,%d0
	jcs .L158
	move.l (%sp,%d1.l*4),%a0
	move.b (%a0),%d0
	lea (64,%sp),%sp
	rts
.L158:
	clr.b %d0
	lea (64,%sp),%sp
	rts
	.size	sg_get, .-sg_get
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"SEQGEN T"
.LC1:
	.string	"INV"
.LC2:
	.string	"DBL"
.LC3:
	.string	"TURN"
.LC4:
	.string	"ON"
.LC5:
	.string	"OFF"
.LC6:
	.string	"INF"
.LC7:
	.string	"AUDIO TRACKS ONLY"
	.text
	.align	2
	.type	draw.part.0, @function
draw.part.0:
	lea (-80,%sp),%sp
	clr.l %d0
	movem.l #31996,(%sp)
	moveq #83,%d1
	move.w #15,%a1
	lea .LC0,%a0
	mvz.b 269161676,%d5
.L163:
	move.b %d1,48(%sp,%d0.l)
	addq.l #1,%a0
	addq.l #1,%d0
	subq.l #1,%a1
	move.b (%a0),%d1
	jeq .L162
	tst.l %a1
	jne .L163
.L162:
	clr.b %d1
	mov3q.l #7,%d2
	move.b %d1,48(%sp,%d0.l)
	cmp.l %d5,%d2
	jcs .L211
	move.l %d5,%d1
	addq.l #1,%d1
.L164:
	move.l %d1,-(%sp)
	moveq #15,%d3
	move.l %d0,-(%sp)
	lea (56,%sp),%a3
	move.l %a3,-(%sp)
	jsr put_number
	lea (12,%sp),%sp
	cmp.l %d0,%d3
	jeq .L212
	move.l page,%d2
	mov3q.l #3,%d7
	moveq #32,%d6
	lea page_names,%a0
	remu.l %d7,%d1:%d2
	move.b %d6,48(%sp,%d0.l)
	addq.l #1,%d0
	lea (%a3,%d0.l),%a1
	clr.b (%a1)
	move.l (%a0,%d1.l*4),%a0
	move.b (%a0),%d1
	jeq .L167
.L166:
	addq.l #1,%a0
	moveq #15,%d2
	cmp.l %d0,%d2
	jeq .L251
.L168:
	move.b %d1,48(%sp,%d0.l)
	move.b (%a0),%d1
	jeq .L252
	addq.l #1,%d0
	addq.l #1,%a0
	moveq #15,%d2
	cmp.l %d0,%d2
	jne .L168
.L251:
	lea (63,%sp),%a1
.L167:
	clr.b (%a1)
	clr.l -(%sp)
	move.l %a3,-(%sp)
	move.l win,-(%sp)
	jsr 1074098360
	move.l win,%d3
	add.l #36,%d3
	move.l %d3,-(%sp)
	jsr 1073960572
	lea (16,%sp),%sp
	move.l win,%a0
	move.l 40(%a0),%a3
	tst.l -2147483630
	jne .L169
	mvz.b 269161676,%d0
	mov3q.l #7,%d6
	cmp.l %d0,%d6
	jcs .L169
	tst.l params_ready
	jne .L170
	jsr (ensure_params.part.0)
.L170:
	move.l %d5,%d0
	move.l %a3,%d1
	lsl.l #4,%d0
	add.l #-22,%d1
	clr.l %d2
	mov3q.l #6,%d4
	move.l %d1,%a6
	add.l #params,%d0
	move.l %d0,44(%sp)
.L210:
	mov3q.l #3,%d7
	move.l %d2,%d0
	remu.l %d7,%d1:%d0
	divu.l %d7,%d0
	move.l page,%d6
	mov3q.l #6,%d7
	muls.l %d7,%d6
	muls.w #-18,%d0
	muls.w #37,%d1
	add.l %d2,%d6
	lea (%a6,%d0.l),%a5
	moveq #15,%d0
	move.l %d1,%a4
	addq.l #5,%a4
	cmp.l %d6,%d0
	jcc .L173
	moveq #16,%d1
	cmp.l %d6,%d1
	jeq .L253
	move.l #.LC2,%d0
	move.l %d0,-(%sp)
	mov3q.l #-1,-(%sp)
	move.l %a5,-(%sp)
	move.l %a4,-(%sp)
	move.l %d3,-(%sp)
	move.l #1074505846,-(%sp)
	jsr 1073818584
	move.w #15,%a1
	lea (24,%sp),%sp
	moveq #84,%d1
	clr.l %d0
	lea .LC3,%a0
.L176:
	move.b %d1,64(%sp,%d0.l)
	addq.l #1,%a0
	addq.l #1,%d0
	subq.l #1,%a1
	move.b (%a0),%d1
	jeq .L208
	tst.l %a1
	jne .L176
.L208:
	clr.b %d6
	move.b %d6,64(%sp,%d0.l)
.L177:
	pea 64(%sp)
	move.l #1073818584,%a0
	mov3q.l #-1,-(%sp)
	pea -7(%a5)
	move.l %a4,-(%sp)
	move.l %d3,-(%sp)
	move.l #1074505846,-(%sp)
	jsr (%a0)
	addq.l #1,%d2
	subq.l #1,%d4
	lea (24,%sp),%sp
	tst.l %d4
	jne .L210
.L255:
	move.l status,%d0
	tst.l %d0
	jeq .L172
	move.l %d0,-(%sp)
	move.l #1073818584,%a0
	mov3q.l #-1,-(%sp)
	pea -58(%a3)
	mov3q.l #5,-(%sp)
	move.l %d3,-(%sp)
	move.l #1074505846,-(%sp)
	jsr (%a0)
	lea (24,%sp),%sp
.L172:
	move.l %d5,shown_track
	move.l #-2147483630,%a0
	movem.l (%sp),#31996
	move.l (%a0),shown_midi
	mov3q.l #1,1187497772
	lea (80,%sp),%sp
	rts
.L169:
	pea .LC7
	mov3q.l #-1,-(%sp)
	pea -30(%a3)
	mov3q.l #5,-(%sp)
	move.l %d3,-(%sp)
	move.l #1074505846,-(%sp)
	jsr 1073818584
	lea (24,%sp),%sp
	move.l %d5,shown_track
	movem.l (%sp),#31996
	move.l #-2147483630,%a0
	move.l (%a0),shown_midi
	mov3q.l #1,1187497772
	lea (80,%sp),%sp
	rts
.L211:
	clr.l %d1
	jra .L164
.L173:
	lea sg_control_names,%a0
	moveq #12,%d7
	move.l (%a0,%d6.l*4),-(%sp)
	mov3q.l #-1,-(%sp)
	move.l %a5,-(%sp)
	move.l %a4,-(%sp)
	move.l %d3,-(%sp)
	move.l #1074505846,-(%sp)
	jsr 1073818584
	move.l %d6,-(%sp)
	move.l 72(%sp),-(%sp)
	jsr sg_get
	clr.b %d1
	mvz.b %d0,%d0
	move.b %d1,96(%sp)
	lea (32,%sp),%sp
	cmp.l %d6,%d7
	jeq .L178
	jcs .L179
	mov3q.l #6,%d1
	cmp.l %d6,%d1
	jeq .L180
	jcs .L181
	tst.l %d6
	jeq .L182
	subq.l #3,%d6
	tst.l %d6
	jne .L184
	moveq #126,%d1
	cmp.l %d0,%d1
	jcs .L254
.L184:
	move.l %d0,-(%sp)
	clr.l -(%sp)
	pea 72(%sp)
	jsr put_number
	lea (12,%sp),%sp
	addq.l #1,%d2
	pea 64(%sp)
	mov3q.l #-1,-(%sp)
	pea -7(%a5)
	move.l #1073818584,%a0
	move.l %a4,-(%sp)
	move.l %d3,-(%sp)
	move.l #1074505846,-(%sp)
	jsr (%a0)
	subq.l #1,%d4
	lea (24,%sp),%sp
	tst.l %d4
	jne .L210
	jra .L255
.L252:
	lea 1(%a3,%d0.l),%a1
	jra .L167
.L179:
	moveq #14,%d7
	cmp.l %d6,%d7
	jeq .L186
	moveq #15,%d1
	cmp.l %d6,%d1
	jeq .L256
	moveq #18,%d7
	remu.l %d7,%d1:%d0
	lea sg_scale_names,%a0
	move.l (%a0,%d1.l*4),%a0
	move.b (%a0),%d1
	jeq .L219
	move.w #15,%a1
	clr.l %d0
.L203:
	move.b %d1,64(%sp,%d0.l)
	addq.l #1,%a0
	addq.l #1,%d0
	subq.l #1,%a1
	move.b (%a0),%d1
	jeq .L248
	tst.l %a1
	jne .L203
	lea (79,%sp),%a0
.L206:
	clr.b (%a0)
.L257:
	pea 64(%sp)
	move.l #1073818584,%a0
	mov3q.l #-1,-(%sp)
	pea -7(%a5)
	move.l %a4,-(%sp)
	move.l %d3,-(%sp)
	move.l #1074505846,-(%sp)
	jsr (%a0)
	addq.l #1,%d2
	subq.l #1,%d4
	lea (24,%sp),%sp
	tst.l %d4
	jne .L210
	jra .L255
.L253:
	move.l #.LC1,%d0
	move.l %d0,-(%sp)
	mov3q.l #-1,-(%sp)
	move.l %a5,-(%sp)
	move.l %a4,-(%sp)
	move.l %d3,-(%sp)
	move.l #1074505846,-(%sp)
	jsr 1073818584
	move.w #15,%a1
	lea (24,%sp),%sp
	moveq #84,%d1
	clr.l %d0
	lea .LC3,%a0
	jra .L176
.L181:
	subq.l #8,%d6
	tst.l %d6
	jne .L184
	mov3q.l #6,%d7
	remu.l %d7,%d1:%d0
	lea auto_names,%a0
	move.l (%a0,%d1.l*4),%a0
	move.b (%a0),%d1
	jeq .L219
	move.w #15,%a1
	clr.l %d0
.L197:
	move.b %d1,64(%sp,%d0.l)
	addq.l #1,%a0
	addq.l #1,%d0
	subq.l #1,%a1
	move.b (%a0),%d1
	jeq .L248
	tst.l %a1
	jne .L197
	lea (79,%sp),%a0
	jra .L206
.L256:
	move.l %d0,%a0
	addq.l #1,%d2
	pea -12(%a0)
	clr.l -(%sp)
	pea 72(%sp)
	jsr put_number
	lea (12,%sp),%sp
	subq.l #1,%d4
	pea 64(%sp)
	mov3q.l #-1,-(%sp)
	pea -7(%a5)
	move.l #1073818584,%a0
	move.l %a4,-(%sp)
	move.l %d3,-(%sp)
	move.l #1074505846,-(%sp)
	jsr (%a0)
	lea (24,%sp),%sp
	tst.l %d4
	jne .L210
	jra .L255
.L248:
	lea 64(%sp,%d0.l),%a0
	clr.b (%a0)
	jra .L257
.L182:
	moveq #9,%d7
	remu.l %d7,%d1:%d0
	lea sg_algo_names,%a0
	move.l (%a0,%d1.l*4),%a0
	move.b (%a0),%d0
	jeq .L219
	moveq #15,%d1
.L191:
	move.b %d0,64(%sp,%d6.l)
	addq.l #1,%a0
	addq.l #1,%d6
	subq.l #1,%d1
	move.b (%a0),%d0
	jeq .L258
	tst.l %d1
	jne .L191
	lea (79,%sp),%a0
	jra .L206
.L180:
	mov3q.l #7,%d6
	remu.l %d6,%d1:%d0
	lea sg_evo_names,%a0
	move.l (%a0,%d1.l*4),%a0
	move.b (%a0),%d1
	jeq .L219
	move.w #15,%a1
	clr.l %d0
.L194:
	move.b %d1,64(%sp,%d0.l)
	addq.l #1,%a0
	addq.l #1,%d0
	subq.l #1,%a1
	move.b (%a0),%d1
	jeq .L248
	tst.l %a1
	jne .L194
	lea (79,%sp),%a0
	jra .L206
.L178:
	moveq #12,%d6
	remu.l %d6,%d1:%d0
	lea root_names,%a0
	move.l (%a0,%d1.l*4),%a0
	move.b (%a0),%d1
	jeq .L219
	move.w #15,%a1
	clr.l %d0
.L200:
	move.b %d1,64(%sp,%d0.l)
	addq.l #1,%a0
	addq.l #1,%d0
	subq.l #1,%a1
	move.b (%a0),%d1
	jeq .L248
	tst.l %a1
	jne .L200
	lea (79,%sp),%a0
	jra .L206
.L186:
	tst.l %d0
	jeq .L220
	moveq #79,%d1
	move.w #15,%a1
	lea .LC4,%a0
	clr.l %d0
.L207:
	move.b %d1,64(%sp,%d0.l)
	addq.l #1,%a0
	addq.l #1,%d0
	subq.l #1,%a1
	move.b (%a0),%d1
	jeq .L248
	tst.l %a1
	jne .L207
	lea (79,%sp),%a0
	jra .L206
.L212:
	move.l page,%d2
	mov3q.l #3,%d7
	moveq #15,%d0
	lea (%a3,%d0.l),%a1
	remu.l %d7,%d1:%d2
	clr.b (%a1)
	lea page_names,%a0
	move.l (%a0,%d1.l*4),%a0
	move.b (%a0),%d1
	jne .L166
	jra .L167
.L220:
	moveq #79,%d1
	move.w #15,%a1
	lea .LC5,%a0
	clr.l %d0
	jra .L207
.L254:
	moveq #73,%d1
	move.w #15,%a1
	clr.l %d0
	lea .LC6,%a0
.L209:
	move.b %d1,64(%sp,%d0.l)
	addq.l #1,%a0
	addq.l #1,%d0
	subq.l #1,%a1
	move.b (%a0),%d1
	jeq .L208
	tst.l %a1
	jne .L209
	clr.b %d6
	move.b %d6,64(%sp,%d0.l)
	jra .L177
.L258:
	lea 64(%sp,%d6.l),%a0
	clr.b (%a0)
	jra .L257
.L219:
	lea (64,%sp),%a0
	clr.b (%a0)
	jra .L257
	.size	draw.part.0, .-draw.part.0
	.align	2
	.globl	sg_set
	.type	sg_set, @function
sg_set:
	lea (-64,%sp),%sp
	move.l 68(%sp),%d0
	move.l %d0,%a0
	addq.l #1,%a0
	move.l %a0,4(%sp)
	addq.l #1,%a0
	move.l %a0,8(%sp)
	addq.l #1,%a0
	move.l %a0,12(%sp)
	addq.l #6,%a0
	move.l %a0,36(%sp)
	addq.l #1,%a0
	move.l %a0,40(%sp)
	addq.l #1,%a0
	move.l %a0,44(%sp)
	addq.l #1,%a0
	move.l %a0,48(%sp)
	subq.l #8,%a0
	move.l %a0,16(%sp)
	addq.l #1,%a0
	move.l %a0,20(%sp)
	addq.l #1,%a0
	move.l %a0,24(%sp)
	addq.l #1,%a0
	move.l %a0,28(%sp)
	addq.l #6,%a0
	move.l %a0,52(%sp)
	addq.l #1,%a0
	move.l %d0,(%sp)
	move.l %a0,56(%sp)
	addq.l #8,%d0
	move.l 72(%sp),%d1
	addq.l #1,%a0
	move.l %d0,32(%sp)
	moveq #15,%d0
	move.l %a0,60(%sp)
	cmp.l %d1,%d0
	jcs .L259
	lea sg_control_max,%a0
	mvz.b (%a0,%d1.l),%d0
	move.l (%sp,%d1.l*4),%a0
	cmp.l 76(%sp),%d0
	jhi .L264
	move.b %d0,(%a0)
.L259:
	lea (64,%sp),%sp
	rts
.L264:
	move.l 76(%sp),%d0
	move.b %d0,(%a0)
	jra .L259
	.size	sg_set, .-sg_set
	.align	2
	.globl	sg_clamp
	.type	sg_clamp, @function
sg_clamp:
	lea (-20,%sp),%sp
	movem.l #3100,(%sp)
	move.l 24(%sp),%d4
	moveq #16,%d3
	clr.l %d2
	lea sg_get,%a3
	lea sg_set,%a2
.L266:
	move.l %d2,-(%sp)
	move.l %d4,-(%sp)
	jsr (%a3)
	addq.l #8,%sp
	subq.l #1,%d3
	mvz.b %d0,%d0
	move.l %d0,-(%sp)
	move.l %d2,-(%sp)
	move.l %d4,-(%sp)
	jsr (%a2)
	addq.l #1,%d2
	lea (12,%sp),%sp
	tst.l %d3
	jne .L266
	movem.l (%sp),#3100
	lea (20,%sp),%sp
	rts
	.size	sg_clamp, .-sg_clamp
	.align	2
	.globl	sg_pack
	.type	sg_pack, @function
sg_pack:
	lea (-52,%sp),%sp
	movem.l #31772,(%sp)
	move.l 60(%sp),%a0
	moveq #16,%d2
	move.l 56(%sp),%a5
	sub.l %a6,%a6
	lea (36,%sp),%a2
	lea sg_get,%a4
	lea sg_set,%a3
	move.l (%a0)+,(%a2)
	move.l (%a0)+,40(%sp)
	move.l (%a0)+,44(%sp)
	move.l (%a0),48(%sp)
.L271:
	move.l %a6,-(%sp)
	move.l %a2,-(%sp)
	jsr (%a4)
	addq.l #8,%sp
	subq.l #1,%d2
	mvz.b %d0,%d0
	move.l %d0,-(%sp)
	move.l %a6,-(%sp)
	move.l %a2,-(%sp)
	jsr (%a3)
	addq.l #1,%a6
	lea (12,%sp),%sp
	tst.l %d2
	jne .L271
	move.b 48(%sp),%d3
	move.b 49(%sp),%d1
	move.b 36(%sp),%d4
	move.b 50(%sp),%d0
	move.b 37(%sp),35(%sp)
	move.b 44(%sp),%d2
	move.w 39(%sp),3(%a5)
	move.b 41(%sp),5(%a5)
	move.b 43(%sp),7(%a5)
	move.w 45(%sp),8(%a5)
	move.w %d3,%a0
	move.b 38(%sp),%d3
	move.w %d4,%a4
	move.b 42(%sp),%d4
	lsl.l #5,%d0
	lsl.l #4,%d2
	move.b 47(%sp),10(%a5)
	move.b 51(%sp),11(%a5)
	move.w %d3,%a3
	move.l %d1,%d3
	lsl.l #2,%d3
	move.w %d4,%a2
	move.l %a0,%d4
	lsl.l #4,%d4
	lsl.l #4,%d1
	and.l #960,%d3
	move.l %d3,%a1
	move.b 35(%sp),%d3
	or.l %d3,%d0
	move.l %d4,%d3
	move.l %a4,%d4
	or.l %d4,%d1
	move.l %a3,%d4
	or.l %d4,%d3
	move.l %a1,%d4
	or.l %d4,%d0
	move.b %d1,(%a5)
	move.l %d3,%a0
	move.l %a2,%d3
	or.l %d3,%d2
	move.w %a0,%d1
	move.b %d0,1(%a5)
	move.b %d2,6(%a5)
	move.b %d1,2(%a5)
	movem.l (%sp),#31772
	lea (52,%sp),%sp
	rts
	.size	sg_pack, .-sg_pack
	.align	2
	.globl	sg_unpack
	.type	sg_unpack, @function
sg_unpack:
	lea (-20,%sp),%sp
	moveq #15,%d1
	movem.l #7180,(%sp)
	move.l 28(%sp),%a0
	moveq #16,%d3
	move.l 24(%sp),%a2
	clr.l %d2
	lea sg_get,%a4
	lea sg_set,%a3
	move.b (%a0),%d0
	and.l %d1,%d0
	move.b %d0,(%a2)
	mvz.b 1(%a0),%d0
	mvz.b (%a0),%d1
	lsr.l #6,%d0
	lsr.l #4,%d1
	lsl.l #4,%d0
	or.l %d1,%d0
	moveq #31,%d1
	move.b %d0,13(%a2)
	move.b 1(%a0),%d0
	and.l %d1,%d0
	mov3q.l #1,%d1
	move.b %d0,1(%a2)
	mvz.b 1(%a0),%d0
	lsr.l #5,%d0
	and.l %d1,%d0
	moveq #15,%d1
	move.b %d0,14(%a2)
	move.b 2(%a0),%d0
	and.l %d1,%d0
	move.b %d0,2(%a2)
	mvz.b 2(%a0),%d0
	lsr.l #4,%d0
	move.b %d0,12(%a2)
	move.b 3(%a0),3(%a2)
	move.b 4(%a0),4(%a2)
	move.b 5(%a0),5(%a2)
	move.b 6(%a0),%d0
	and.l %d1,%d0
	move.b %d0,6(%a2)
	mvz.b 6(%a0),%d0
	lsr.l #4,%d0
	move.b %d0,8(%a2)
	move.b 7(%a0),7(%a2)
	move.b 8(%a0),9(%a2)
	move.b 9(%a0),10(%a2)
	move.b 10(%a0),11(%a2)
	move.b 11(%a0),15(%a2)
.L276:
	move.l %d2,-(%sp)
	move.l %a2,-(%sp)
	jsr (%a4)
	addq.l #8,%sp
	subq.l #1,%d3
	mvz.b %d0,%d0
	move.l %d0,-(%sp)
	move.l %d2,-(%sp)
	move.l %a2,-(%sp)
	jsr (%a3)
	addq.l #1,%d2
	lea (12,%sp),%sp
	tst.l %d3
	jne .L276
	movem.l (%sp),#7180
	lea (20,%sp),%sp
	rts
	.size	sg_unpack, .-sg_unpack
	.align	2
	.globl	sg_next_seed
	.type	sg_next_seed, @function
sg_next_seed:
	move.l 4(%sp),%d0
	moveq #127,%d1
	addq.l #1,%d0
	and.l %d1,%d0
	rts
	.size	sg_next_seed, .-sg_next_seed
	.align	2
	.globl	sg_in_scale
	.type	sg_in_scale, @function
sg_in_scale:
	lea (-12,%sp),%sp
	moveq #24,%d1
	move.l 16(%sp),%d0
	add.l #12,%d0
	movem.l #1036,(%sp)
	cmp.l %d0,%d1
	jcs .L285
	moveq #17,%d2
	cmp.l 24(%sp),%d2
	jcs .L285
	move.l 20(%sp),%d0
	moveq #12,%d3
	lea sg_scale_masks,%a2
	remu.l %d3,%d1:%d0
	move.l %d1,%a1
	move.l 24(%sp),%d1
	mvz.w (%a2,%d1.l*2),%d0
	moveq #48,%d1
	sub.l %a1,%d1
	add.l 16(%sp),%d1
	remu.l %d3,%d2:%d1
	mov3q.l #1,%d3
	asr.l %d2,%d0
	and.l %d3,%d0
	movem.l (%sp),#1036
	lea (12,%sp),%sp
	rts
.L285:
	movem.l (%sp),#1036
	clr.l %d0
	lea (12,%sp),%sp
	rts
	.size	sg_in_scale, .-sg_in_scale
	.align	2
	.globl	sg_fit
	.type	sg_fit, @function
sg_fit:
	lea (-28,%sp),%sp
	moveq #12,%d1
	move.l 32(%sp),%a1
	movem.l #1276,(%sp)
	move.l 36(%sp),%d0
	move.l 40(%sp),%d3
	cmp.l %a1,%d1
	jge .L289
	move.w #12,%a1
.L290:
	moveq #12,%d4
	moveq #48,%d5
	remu.l %d4,%d2:%d0
	move.w #13,%a0
	clr.l %d1
	lea sg_scale_masks,%a2
	sub.l %d2,%d5
.L298:
	move.l %a1,%d0
	sub.l %d1,%d0
	move.l %d0,%d2
	moveq #24,%d6
	add.l #12,%d2
	cmp.l %d2,%d6
	jcs .L303
	moveq #17,%d2
	cmp.l %d3,%d2
	jcs .L293
	mvz.w (%a2,%d3.l*2),%d4
.L297:
	move.l %d5,%d2
	moveq #12,%d7
	add.l %d0,%d2
	remu.l %d7,%d6:%d2
	btst %d6,%d4
	jne .L288
	move.l %a1,%d0
	add.l %d1,%d0
	move.l %d0,%d2
	moveq #24,%d6
	add.l #12,%d2
	cmp.l %d2,%d6
	jcs .L304
	move.l %d5,%d2
	moveq #12,%d7
	add.l %d0,%d2
	remu.l %d7,%d6:%d2
	btst %d6,%d4
	jne .L288
.L293:
	addq.l #1,%d1
	subq.l #1,%a0
	tst.l %a0
	jne .L298
.L299:
	clr.l %d0
.L288:
	movem.l (%sp),#1276
	lea (28,%sp),%sp
	rts
.L304:
	subq.l #1,%a0
	tst.l %a0
	jeq .L299
	addq.l #1,%d1
	move.l %a1,%d0
	sub.l %d1,%d0
	jra .L297
.L303:
	moveq #17,%d7
	cmp.l %d3,%d7
	jcs .L293
	move.l %a1,%d0
	add.l %d1,%d0
	move.l %d5,%d2
	moveq #12,%d7
	add.l %d0,%d2
	remu.l %d7,%d6:%d2
	mvz.w (%a2,%d3.l*2),%d4
	btst %d6,%d4
	jeq .L293
	jra .L288
.L289:
	moveq #-12,%d2
	cmp.l %a1,%d2
	jle .L290
	moveq #12,%d4
	moveq #48,%d5
	remu.l %d4,%d2:%d0
	move.w #-12,%a1
	move.w #13,%a0
	clr.l %d1
	lea sg_scale_masks,%a2
	sub.l %d2,%d5
	jra .L298
	.size	sg_fit, .-sg_fit
	.align	2
	.type	sg_fit_record.part.0, @function
sg_fit_record.part.0:
	lea (-40,%sp),%sp
	movem.l #15612,(%sp)
	move.l 44(%sp),%a3
	moveq #64,%d3
	move.l 48(%sp),%a2
	clr.l %d2
	lea sg_fit,%a4
.L311:
	mvz.w %d2,%d0
	lsl.l #5,%d0
	lea 89(%a3,%d0.l),%a5
	move.b (%a5),%d0
	mvz.b %d0,%d1
	tst.b %d0
	jlt .L306
	move.l %d1,%d0
	mov3q.l #2,%d6
	add.l #-64,%d1
	mvz.b 13(%a2),%d5
	mvz.b 12(%a2),%d4
	add.l #-62,%d0
	sub.l %d1,%d6
	tst.l %d1
	jlt .L307
	mov3q.l #5,%d6
	divs.l %d6,%d0
.L308:
	move.l %d5,-(%sp)
	moveq #12,%d1
	move.l %d4,-(%sp)
	cmp.l %d0,%d1
	jge .L309
	moveq #12,%d0
.L310:
	move.l %d0,-(%sp)
	jsr (%a4)
	lea (12,%sp),%sp
	muls.w #5,%d0
	add.l #64,%d0
	move.b %d0,(%a5)
.L306:
	addq.l #1,%d2
	subq.l #1,%d3
	tst.l %d3
	jne .L311
	movem.l (%sp),#15612
	mov3q.l #1,%d0
	lea (40,%sp),%sp
	rts
.L309:
	moveq #-12,%d6
	cmp.l %d0,%d6
	jle .L310
	moveq #-12,%d0
	move.l %d0,-(%sp)
	jsr (%a4)
	lea (12,%sp),%sp
	muls.w #5,%d0
	add.l #64,%d0
	move.b %d0,(%a5)
	jra .L306
.L307:
	move.l %d6,%d0
	moveq #-5,%d7
	divs.l %d7,%d0
	jra .L308
	.size	sg_fit_record.part.0, .-sg_fit_record.part.0
	.align	2
	.type	context.isra.0, @function
context.isra.0:
	lea (-36,%sp),%sp
	moveq #12,%d0
	movem.l #3324,(%sp)
	mvz.b 47(%sp),%d4
	move.l 40(%sp),%a0
	cmp.l %d4,%d0
	jcc .L316
	moveq #12,%d4
.L316:
	mvz.b 63(%sp),%d5
	mvz.b 59(%sp),%d2
	move.l %d4,%d0
	neg.l %d0
.L322:
	moveq #17,%d1
	cmp.l %d5,%d1
	jcc .L338
	addq.l #1,%d0
	cmp.l %d4,%d0
	jle .L322
	sub.l %a1,%a1
.L321:
	move.l %a1,100(%a0)
	tst.l %a1
	jeq .L323
	mov3q.l #6,%d6
	cmp.l %d2,%d6
	jcc .L324
	add.l #-12,%d2
.L324:
	clr.l %d4
	moveq #99,%d3
	clr.l %d0
.L327:
	move.l (%a0,%d0.l*4),%d1
	sub.l %d2,%d1
	jmi .L339
.L325:
	cmp.l %d1,%d3
	jle .L326
	move.l %d0,%d4
	move.l %d1,%d3
.L326:
	addq.l #1,%d0
	cmp.l %d0,%a1
	jhi .L327
	mvz.b 51(%sp),%d0
	move.l %d4,104(%a0)
	moveq #127,%d1
	move.l %d0,108(%a0)
	cmp.l %d0,%d1
	jcc .L328
	moveq #127,%d0
.L328:
	move.l %d0,108(%a0)
	mvz.b 55(%sp),%d1
	move.l 64(%sp),112(%a0)
	tst.b 55(%sp)
	jge .L329
	moveq #127,%d1
.L329:
	mvz.w #254,%d0
	mvz.w #254,%d6
	sub.l %d1,%d0
	mulu.w 66(%sp),%d0
	divu.l %d6,%d0
	movem.l (%sp),#3324
	move.l %d0,116(%a0)
	lea (36,%sp),%sp
	rts
.L338:
	moveq #12,%d6
	move.l %d2,%d3
	remu.l %d6,%d1:%d3
	lea sg_scale_masks,%a1
	mvz.w (%a1,%d5.l*2),%d7
	move.w #48,%a3
	clr.l %d3
	move.l %d3,%a1
	addq.l #1,%a1
	move.l %d7,%a2
	moveq #12,%d7
	sub.l %d1,%a3
	move.l %d0,%d1
	add.l %a3,%d1
	remu.l %d7,%d6:%d1
	move.l %a2,%d1
	btst %d6,%d1
	jeq .L340
.L319:
	move.l %d0,(%a0,%d3.l*4)
	addq.l #1,%d0
	cmp.l %d4,%d0
	jgt .L321
	move.l %a1,%d3
.L341:
	move.l %d0,%d1
	moveq #12,%d7
	add.l %a3,%d1
	remu.l %d7,%d6:%d1
	move.l %d3,%a1
	addq.l #1,%a1
	move.l %a2,%d1
	btst %d6,%d1
	jne .L319
.L340:
	addq.l #1,%d0
	move.l %d3,%a1
	cmp.l %d4,%d0
	jgt .L321
	move.l %a1,%d3
	jra .L341
.L339:
	neg.l %d1
	jra .L325
.L323:
	move.l %d5,-(%sp)
	move.l %d2,-(%sp)
	clr.l -(%sp)
	move.l %a0,44(%sp)
	jsr sg_fit
	lea (12,%sp),%sp
	mov3q.l #6,%d7
	move.l 32(%sp),%a0
	move.l %d0,(%a0)
	mov3q.l #1,100(%a0)
	cmp.l %d2,%d7
	jcc .L331
	add.l #-12,%d2
	mov3q.l #1,%a1
	clr.l %d4
	moveq #99,%d3
	clr.l %d0
	jra .L327
.L331:
	mov3q.l #1,%a1
	clr.l %d4
	moveq #99,%d3
	clr.l %d0
	jra .L327
	.size	context.isra.0, .-context.isra.0
	.align	2
	.type	sg_evolve.part.0, @function
sg_evolve.part.0:
	link.w %fp,#-204
	move.l 12(%fp),%a1
	moveq #16,%d0
	movem.l #15612,(%sp)
	move.l %fp,%d3
	add.l #-136,%d3
	move.l %d3,%a0
	clr.l %d2
	move.l 8(%fp),%a2
	move.l %d0,-144(%fp)
	lea sg_get,%a4
	lea sg_set,%a3
	move.l (%a1)+,(%a0)+
	move.l (%a1)+,(%a0)+
	move.l (%a1)+,(%a0)+
	move.l (%a1),(%a0)
.L343:
	move.l %d2,-(%sp)
	move.l %d3,-(%sp)
	jsr (%a4)
	addq.l #8,%sp
	mvz.b %d0,%d0
	move.l %d0,-(%sp)
	move.l %d2,-(%sp)
	move.l %d3,-(%sp)
	jsr (%a3)
	addq.l #1,%d2
	lea (12,%sp),%sp
	subq.l #1,-144(%fp)
	tst.l -144(%fp)
	jne .L343
	mvz.b -124(%fp),%d1
	mvz.b -123(%fp),%d4
	mvz.b -132(%fp),%d2
	move.l 16(%fp),-(%sp)
	move.l %d1,-156(%fp)
	mvz.b -133(%fp),%d1
	move.l %d4,-(%sp)
	mvz.b -134(%fp),%d0
	move.l -156(%fp),-(%sp)
	move.l %d2,-(%sp)
	move.l %d1,-(%sp)
	move.l %d0,-(%sp)
	pea -120(%fp)
	jsr (context.isra.0)
	lea (28,%sp),%sp
	move.b -130(%fp),%d7
	move.l 20(%fp),%d2
	mvz.b -129(%fp),%d6
	mvz.b %d7,%d3
	move.l %d3,%d0
	lsl.l #8,%d0
	eor.l %d2,%d0
	moveq #15,%d2
	eor.l #-419364864,%d0
	move.l %d0,%d1
	clr.w %d1
	swap %d1
	eor.l %d0,%d1
	move.l #569420461,%d0
	muls.l %d0,%d1
	move.l %d1,%d0
	lsr.l %d2,%d0
	eor.l %d0,%d1
	move.l #1935289751,%d0
	muls.l %d0,%d1
	move.l %d1,%d0
	lsr.l %d2,%d0
	eor.l %d1,%d0
	mov3q.l #5,%d1
	cmp.l %d3,%d1
	jeq .L344
	jcs .L345
	mov3q.l #3,%d2
	cmp.l %d3,%d2
	jeq .L346
	mov3q.l #4,%d1
	cmp.l %d3,%d1
	jne .L411
	pea -140(%fp)
	mov3q.l #1,-(%sp)
	move.l %d6,-(%sp)
	move.l %a2,-(%sp)
	move.l %d0,-140(%fp)
	jsr shuffle_fields
	lea (16,%sp),%sp
.L351:
	mov3q.l #1,%d0
	movem.l -204(%fp),#15612
	unlk %fp
	rts
.L345:
	mov3q.l #6,%d2
	cmp.l %d3,%d2
	jne .L407
	pea -140(%fp)
	mov3q.l #4,-(%sp)
	move.l %d6,-(%sp)
	move.l %a2,-(%sp)
	move.l %d0,-140(%fp)
	jsr shuffle_fields
	lea (16,%sp),%sp
	jra .L351
.L344:
	pea -140(%fp)
	mov3q.l #2,-(%sp)
	move.l %d6,-(%sp)
	move.l %a2,-(%sp)
	move.l %d0,-140(%fp)
	jsr shuffle_fields
	lea (16,%sp),%sp
	jra .L351
.L346:
	pea -140(%fp)
	mov3q.l #7,-(%sp)
	move.l %d6,-(%sp)
	move.l %a2,-(%sp)
	move.l %d0,-140(%fp)
	jsr shuffle_fields
	lea (16,%sp),%sp
	jra .L351
.L411:
	mov3q.l #1,-152(%fp)
	tst.b %d7
	jne .L407
.L350:
	mvz.b 512(%a2),%d5
	tst.l %d5
	jeq .L351
	move.b %d7,-161(%fp)
	move.l -144(%fp),-160(%fp)
	move.l -20(%fp),%a5
	move.l %d3,-144(%fp)
	clr.l %d3
	move.l %d4,-148(%fp)
.L374:
	move.l %d0,%d2
	add.l #1831565813,%d2
	move.l %d2,%d1
	move.l #569420461,%d4
	clr.w %d1
	swap %d1
	moveq #15,%d7
	eor.l %d2,%d1
	muls.l %d4,%d1
	move.l %d1,%d4
	lsr.l %d7,%d4
	eor.l %d4,%d1
	move.l #1935289751,%d4
	muls.l %d4,%d1
	move.l %d1,%d4
	lsr.l %d7,%d4
	moveq #100,%d7
	eor.l %d4,%d1
	remu.l %d7,%d4:%d1
	cmp.l %d6,%d4
	jcc .L363
	mvz.w %d3,%d1
	lsl.l #3,%d1
	lea (%a2,%d1.l),%a0
	move.b (%a0),%d4
	tst.b -161(%fp)
	jne .L412
	tst.b %d4
	jeq .L363
	move.l %d3,%d7
	moveq #-128,%d1
	lsl.l #3,%d7
	mvs.b 4(%a2,%d7.l),%d0
	move.l %d7,%a0
	move.l %d0,%a3
	cmp.l %d0,%d1
	jeq .L363
.L362:
	tst.l %a5
	jeq .L381
	move.b -161(%fp),%d7
	move.w #99,%a1
	sub.l %a4,%a4
	clr.l %d0
.L369:
	move.l -120(%fp,%d0.l*4),%d1
	sub.l %a3,%d1
	jmi .L413
.L367:
	cmp.l %d1,%a1
	jle .L368
	move.l %d0,%a4
	move.l %d1,%a1
.L368:
	addq.l #1,%d0
	cmp.l %a5,%d0
	jcs .L369
	move.b %d7,-161(%fp)
	move.l %a4,%a1
.L366:
	move.l %d2,%a4
	add.l #1831565813,%a4
	move.l %d2,%d0
	move.l %a4,%d2
	clr.w %d2
	swap %d2
	add.l #-631835670,%d0
	move.l %d0,%d1
	move.l %a4,%d4
	clr.w %d1
	swap %d1
	move.l #569420461,%d7
	eor.l %d4,%d2
	eor.l %d0,%d1
	muls.l %d7,%d2
	muls.l %d7,%d1
	moveq #15,%d7
	move.l %d2,%d4
	lsr.l %d7,%d4
	move.l %d4,%a3
	move.l %d1,%d4
	lsr.l %d7,%d4
	move.l %a3,%d7
	eor.l %d7,%d2
	eor.l %d4,%d1
	move.l #1935289751,%d4
	muls.l %d4,%d2
	muls.l %d4,%d1
	moveq #15,%d4
	move.l %d2,%d7
	lsr.l %d4,%d7
	move.l %d7,%a3
	move.l %d1,%d7
	lsr.l %d4,%d7
	move.l %a3,%d4
	eor.l %d2,%d4
	eor.l %d7,%d1
	move.l -152(%fp),%d7
	remu.l %d7,%d2:%d4
	btst #0,%d1
	jeq .L370
	lea 1(%a1,%d2.l),%a1
.L371:
	cmp.l %a5,%a1
	jlt .L373
	lea (-1,%a5),%a1
.L373:
	lea -117(%fp,%a1.l*4),%a1
	move.b (%a1),4(%a2,%a0.l)
.L353:
	addq.l #1,%d3
	cmp.l %d5,%d3
	jcs .L374
	move.l -160(%fp),-144(%fp)
	move.l -148(%fp),%d4
	move.l -144(%fp),%d2
	move.l -156(%fp),%d3
	lea sg_fit,%a4
.L376:
	move.l %d2,%d0
	lsl.l #3,%d0
	lea 4(%a2,%d0.l),%a3
	tst.b (%a2,%d0.l)
	jeq .L375
	mvs.b (%a3),%d0
	moveq #-128,%d7
	cmp.l %d0,%d7
	jeq .L375
	move.l %d4,-(%sp)
	move.l %d3,-(%sp)
	move.l %d0,-(%sp)
	jsr (%a4)
	lea (12,%sp),%sp
	move.b %d0,(%a3)
.L375:
	addq.l #1,%d2
	cmp.l %d5,%d2
	jcs .L376
	movem.l -204(%fp),#15612
	mov3q.l #1,%d0
	unlk %fp
	rts
.L413:
	neg.l %d1
	jra .L367
.L412:
	move.l %d0,%d2
	add.l #-631835670,%d2
	move.l %d2,%d1
	move.l #569420461,%d7
	clr.w %d1
	swap %d1
	eor.l %d2,%d1
	muls.l %d1,%d7
	moveq #15,%d1
	move.l %d7,%a1
	lsr.l %d1,%d7
	move.l %a1,%d1
	eor.l %d7,%d1
	move.l #1935289751,%d7
	muls.l %d1,%d7
	moveq #15,%d1
	move.l %d7,%a1
	lsr.l %d1,%d7
	move.l %a1,%d1
	eor.l %d7,%d1
	btst #0,%d1
	jne .L355
	tst.b %d4
	jeq .L356
	clr.w (%a0)
.L363:
	move.l %d2,%d0
	jra .L353
.L355:
	tst.b %d4
	jeq .L363
	move.l %d3,%d4
	moveq #-128,%d1
	lsl.l #3,%d4
	mvs.b 4(%a2,%d4.l),%d7
	move.l %d4,%a0
	move.l %d7,%a3
	cmp.l %d7,%d1
	jeq .L363
	mov3q.l #2,%d4
	cmp.l -144(%fp),%d4
	jne .L362
	tst.l %a5
	jne .L414
	clr.l %d0
	lea -117(%fp,%d0.l*4),%a3
	move.l -12(%fp),%a1
	moveq #126,%d0
	move.b (%a3),4(%a2,%a0.l)
	cmp.l %a1,%d0
	jcs .L380
.L415:
	move.l %d2,%d0
	add.l #1831565813,%d0
	move.l %d0,%d1
	move.l #569420461,%d2
	clr.w %d1
	swap %d1
	moveq #15,%d4
	move.l #1935289751,%d7
	eor.l %d0,%d1
	muls.l %d2,%d1
	move.l %d1,%d2
	lsr.l %d4,%d2
	eor.l %d2,%d1
	muls.l %d7,%d1
	move.l %a1,%d7
	move.l %d1,%d2
	lsr.l %d4,%d2
	mov3q.l #3,%d4
	eor.l %d1,%d2
	remu.l %d4,%d1:%d2
	addq.l #2,%d1
	muls.l %d7,%d1
	lsr.l #2,%d1
	move.b %d1,2(%a2,%a0.l)
	jra .L353
.L370:
	not.l %d2
	add.l %d2,%a1
	tst.l %a1
	jge .L371
	sub.l %a1,%a1
	jra .L371
.L407:
	mov3q.l #2,-152(%fp)
	jra .L350
.L356:
	tst.l %d3
	sne %d1
	move.l -12(%fp),%d4
	moveq #126,%d7
	move.l -4(%fp),%a4
	mvs.b %d1,%d1
	add.l %d3,%d1
	lsl.l #3,%d1
	move.b 4(%a2,%d1.l),%d1
	move.w %d1,%a1
	cmp.l %d4,%d7
	jcs .L378
	add.l #1199730143,%d0
	move.l %d0,%d1
	move.l #569420461,%d2
	clr.w %d1
	swap %d1
	moveq #15,%d7
	eor.l %d0,%d1
	muls.l %d2,%d1
	move.l %d1,%d2
	lsr.l %d7,%d2
	eor.l %d2,%d1
	move.l #1935289751,%d2
	muls.l %d2,%d1
	move.l %d1,%d2
	lsr.l %d7,%d2
	mov3q.l #3,%d7
	eor.l %d1,%d2
	remu.l %d7,%d1:%d2
	addq.l #2,%d1
	muls.l %d4,%d1
	lsr.l #2,%d1
	move.b %d1,%d4
.L357:
	move.l %a4,%d2
	moveq #127,%d1
	cmp.l %a4,%d1
	jcc .L358
	moveq #127,%d2
.L358:
	mvs.b %a1,%d1
	move.w %d2,%a3
	moveq #-128,%d7
	cmp.l %d1,%d7
	jeq .L359
	move.l %d3,%d1
	lsl.l #3,%d1
	move.w %a1,%d7
	move.b #1,(%a0)
	move.b %d4,2(%a2,%d1.l)
	move.b %d7,4(%a2,%d1.l)
	move.b %d2,3(%a2,%d1.l)
	jra .L353
.L380:
	moveq #127,%d1
	move.l %d2,%d0
	move.b %d1,2(%a2,%a0.l)
	jra .L353
.L378:
	moveq #127,%d4
	move.l %d2,%d0
	jra .L357
.L414:
	move.l %d0,%d2
	add.l #1199730143,%d2
	move.l %d2,%d0
	move.l #569420461,%d7
	clr.w %d0
	swap %d0
	moveq #15,%d4
	move.l -12(%fp),%a1
	eor.l %d2,%d0
	muls.l %d7,%d0
	move.l #1935289751,%d7
	move.l %d0,%d1
	lsr.l %d4,%d1
	eor.l %d1,%d0
	muls.l %d7,%d0
	move.l %d0,%d1
	lsr.l %d4,%d1
	move.l %a5,%d4
	eor.l %d0,%d1
	remu.l %d4,%d0:%d1
	lea -117(%fp,%d0.l*4),%a3
	moveq #126,%d0
	move.b (%a3),4(%a2,%a0.l)
	cmp.l %a1,%d0
	jcc .L415
	jra .L380
.L381:
	sub.l %a1,%a1
	jra .L366
.L359:
	tst.l %a5
	jne .L416
	move.l %d3,%d1
	lsl.l #3,%d1
	move.b #1,(%a0)
	move.w %a3,%d2
	move.b %d4,2(%a2,%d1.l)
	moveq #-128,%d4
	move.b %d2,3(%a2,%d1.l)
	move.b %d4,4(%a2,%d1.l)
	jra .L353
.L416:
	move.l %d3,%d1
	add.l #1831565813,%d0
	lsl.l #3,%d1
	move.b #1,(%a0)
	move.w %a3,%d2
	move.b %d4,2(%a2,%d1.l)
	moveq #-128,%d4
	move.b %d2,3(%a2,%d1.l)
	move.b %d4,4(%a2,%d1.l)
	jra .L353
	.size	sg_evolve.part.0, .-sg_evolve.part.0
	.align	2
	.globl	sg_transpose
	.type	sg_transpose, @function
sg_transpose:
	lea (-132,%sp),%sp
	moveq #25,%d0
	movem.l #17532,(%sp)
	move.l 140(%sp),%a0
	moveq #-12,%d1
	move.l 136(%sp),%a2
	move.b 12(%a0),%d2
	mvz.b 13(%a0),%d3
.L424:
	moveq #17,%d4
	cmp.l %d3,%d4
	jcc .L455
	addq.l #1,%d1
	subq.l #1,%d0
	tst.l %d0
	jne .L424
	sub.l %a0,%a0
.L422:
	tst.l %a2
	jeq .L417
	tst.l %a0
	jeq .L417
	tst.l 144(%sp)
	jeq .L417
	move.b 512(%a2),%d5
	jeq .L417
	mvz.b %d5,%d5
	lea (-1,%a0),%a1
	clr.l %d2
	move.l %a1,28(%sp)
.L433:
	move.l %d2,%d4
	lsl.l #3,%d4
	tst.b (%a2,%d4.l)
	jeq .L427
	mvs.b 4(%a2,%d4.l),%d0
	moveq #-128,%d6
	move.l %d0,%a6
	cmp.l %d0,%d6
	jeq .L427
	move.w #99,%a1
	clr.l %d3
	clr.l %d0
.L430:
	move.l 32(%sp,%d0.l*4),%d1
	sub.l %a6,%d1
	jmi .L456
.L428:
	cmp.l %d1,%a1
	jle .L429
	move.l %d0,%d3
	move.l %d1,%a1
.L429:
	addq.l #1,%d0
	cmp.l %d0,%a0
	jhi .L430
	add.l 144(%sp),%d3
	tst.l %d3
	jlt .L457
.L431:
	cmp.l %a0,%d3
	jlt .L432
	move.l 28(%sp),%d3
.L432:
	lea 35(%sp,%d3.l*4),%a1
	move.b (%a1),4(%a2,%d4.l)
.L427:
	addq.l #1,%d2
	cmp.l %d2,%d5
	jhi .L433
.L417:
	movem.l (%sp),#17532
	lea (132,%sp),%sp
	rts
.L455:
	mvz.b %d2,%d2
	lea sg_scale_masks,%a0
	moveq #12,%d6
	mvz.w (%a0,%d3.l*2),%d5
	remu.l %d6,%d3:%d2
	moveq #48,%d4
	sub.l %a1,%a1
	sub.l %d3,%d4
.L419:
	move.l %d1,%d2
	moveq #12,%d6
	add.l %d4,%d2
	remu.l %d6,%d3:%d2
	lea (1,%a1),%a0
	btst %d3,%d5
	jeq .L458
.L420:
	move.l %d1,32(%sp,%a1.l*4)
	subq.l #1,%d0
	tst.l %d0
	jeq .L422
	addq.l #1,%d1
	move.l %d1,%d2
	moveq #12,%d6
	add.l %d4,%d2
	remu.l %d6,%d3:%d2
	move.l %a0,%a1
	lea (1,%a1),%a0
	btst %d3,%d5
	jne .L420
.L458:
	subq.l #1,%d0
	tst.l %d0
	jeq .L459
	addq.l #1,%d1
	jra .L419
.L456:
	neg.l %d1
	jra .L428
.L457:
	clr.l %d3
	jra .L431
.L459:
	move.l %a1,%a0
	jra .L422
	.size	sg_transpose, .-sg_transpose
	.align	2
	.type	sg_generate.part.0, @function
sg_generate.part.0:
	link.w %fp,#-452
	move.l 12(%fp),%a1
	movem.l #15612,(%sp)
	move.l %fp,%d2
	add.l #-360,%d2
	move.l %d2,%a0
	moveq #16,%d4
	move.l 16(%fp),%d3
	clr.l %d5
	lea sg_get,%a3
	lea sg_set,%a2
	move.l 8(%fp),-400(%fp)
	move.l (%a1)+,(%a0)+
	move.l (%a1)+,(%a0)+
	move.l (%a1)+,(%a0)+
	move.l (%a1),(%a0)
.L461:
	move.l %d5,-(%sp)
	move.l %d2,-(%sp)
	jsr (%a3)
	addq.l #8,%sp
	subq.l #1,%d4
	mvz.b %d0,%d0
	move.l %d0,-(%sp)
	move.l %d5,-(%sp)
	move.l %d2,-(%sp)
	jsr (%a2)
	addq.l #1,%d5
	lea (12,%sp),%sp
	tst.l %d4
	jne .L461
	mvz.b -348(%fp),%d0
	mvz.b -347(%fp),%d7
	mvz.b -356(%fp),%d5
	move.l 20(%fp),-(%sp)
	mvz.b -357(%fp),%d1
	move.l %d0,-396(%fp)
	move.l #569420461,%d6
	move.l %d7,-(%sp)
	move.l %d3,%a5
	mvz.b -358(%fp),%d0
	move.l -396(%fp),-(%sp)
	move.l %d5,-(%sp)
	move.l %d1,-(%sp)
	move.l %d0,-(%sp)
	pea -248(%fp)
	move.l -400(%fp),8(%fp)
	jsr (context.isra.0)
	move.b -360(%fp),%d1
	move.l 8(%fp),%a4
	lea (28,%sp),%sp
	moveq #64,%d0
	move.w %d1,%a3
	mvz.b -355(%fp),%d1
	move.w %a3,%d5
	mvz.b %d5,%d5
	move.l %d5,%a2
	lsl.l #8,%d5
	eor.l %d5,%d1
	eor.l #1587437214,%d1
	muls.l %d6,%d1
	moveq #15,%d6
	move.l %d1,%d5
	lsr.l %d6,%d5
	eor.l %d5,%d1
	move.l #1935289751,%d5
	muls.l %d5,%d1
	move.l %d1,%d5
	lsr.l %d6,%d5
	eor.l %d1,%d5
.L462:
	move.l %d4,%d1
	subq.l #1,%d0
	lsl.l #3,%d1
	clr.b %d3
	mvz.w %d4,%d6
	addq.l #1,%d4
	lsl.l #3,%d6
	move.b %d3,7(%a4,%d1.l)
	move.b %d3,5(%a4,%d1.l)
	clr.w %d3
	move.w %d3,(%a4,%d6.l)
	clr.b %d6
	moveq #-1,%d3
	move.b %d6,6(%a4,%d1.l)
	moveq #-128,%d6
	move.w %d3,2(%a4,%d1.l)
	move.b %d6,4(%a4,%d1.l)
	tst.l %d0
	jne .L462
	move.l %a5,%d3
	mov3q.l #4,%d4
	move.b %d3,512(%a4)
	mvz.b -359(%fp),%d1
	move.l %a4,8(%fp)
	cmp.l %a2,%d4
	jeq .L463
	jcs .L464
	mov3q.l #2,%d6
	cmp.l %a2,%d6
	jeq .L465
	mov3q.l #3,%d4
	cmp.l %a2,%d4
	jeq .L466
	move.w %a3,%d6
	tst.b %d6
	jeq .L715
	move.l %a5,%d4
	addq.l #1,%d4
	lsr.l #1,%d4
	move.l %d4,%a4
	tst.l %d4
	jeq .L566
	move.l -144(%fp),%a2
	tst.l %a2
	jlt .L716
	move.l -148(%fp),-400(%fp)
	moveq #16,%d6
	cmp.l %d1,%d6
	jcs .L717
.L500:
	move.w %a4,%d4
	move.l 8(%fp),-392(%fp)
	mulu.w %d1,%d4
	clr.l %d1
	move.l %d4,%a0
	addq.l #8,%a0
	move.l %a0,%d6
	lsr.l #4,%d6
	move.l %d6,%a0
.L501:
	move.l %d1,%d4
	mov3q.l #1,%d6
	not.l %d4
	and.l %d6,%d4
	move.w %d4,-128(%fp,%d1.l*2)
	addq.l #1,%d1
	cmp.l %a4,%d1
	jcs .L501
	pea -364(%fp)
	pea -128(%fp)
	move.l %a0,-(%sp)
	move.l %a4,-(%sp)
	pea -312(%fp)
	move.l %d5,-364(%fp)
	move.l %d0,-404(%fp)
	move.l -392(%fp),8(%fp)
	jsr pick
	move.l -364(%fp),%d5
	move.l -404(%fp),%d0
	lea (20,%sp),%sp
	cmp.l -400(%fp),%a2
	jlt .L502
	move.l -400(%fp),%a2
	subq.l #1,%a2
.L502:
	lea (%fp,%a2.l*4),%a0
	move.l -400(%fp),%a2
	clr.l %d4
	move.l -140(%fp),%a3
	move.l -248(%fp),-376(%fp)
	lea -4(%fp,%a2.l*4),%a2
	move.l -132(%fp),-388(%fp)
	move.l -136(%fp),-392(%fp)
	move.l %d3,-368(%fp)
	move.l 8(%fp),-408(%fp)
	move.l %d7,-412(%fp)
	move.l -248(%a0),%a5
	move.l %a5,%d6
	move.l %a2,-380(%fp)
	add.l #-11,%d6
	lea (19,%a5),%a0
	lea (11,%a5),%a1
	move.l %d6,%a2
	move.l %d5,%d6
	move.l %a0,-372(%fp)
	move.l %a3,%d5
	move.l %d0,%a3
	move.l %a1,-384(%fp)
.L513:
	lea (%fp,%d4.l),%a0
	tst.b -312(%a0)
	jeq .L503
	move.l %d6,%d0
	add.l #1831565813,%d0
	move.l %d0,%d1
	move.l #569420461,%d3
	clr.w %d1
	swap %d1
	moveq #15,%d7
	eor.l %d0,%d1
	muls.l %d3,%d1
	move.l %d1,%d3
	lsr.l %d7,%d3
	eor.l %d3,%d1
	move.l #1935289751,%d3
	muls.l %d3,%d1
	move.l %d1,%d3
	lsr.l %d7,%d3
	moveq #100,%d7
	eor.l %d1,%d3
	remu.l %d7,%d1:%d3
	moveq #19,%d3
	move.l %d1,%a0
	lea (-50,%a0),%a0
	cmp.l %a0,%d3
	jcs .L504
	move.l -384(%fp),%a1
	move.l -380(%fp),%a0
	cmp.l -248(%a0),%a1
	jge .L505
	move.l %a5,%d3
	add.l #12,%d3
.L506:
	btst #0,%d4
	jne .L613
	move.l -392(%fp),%a0
	moveq #126,%d7
	cmp.l %d5,%d7
	jcs .L614
.L739:
	move.l %d0,%d6
	add.l #1831565813,%d6
	move.l %d6,%d0
	move.l #569420461,%d1
	clr.w %d0
	swap %d0
	moveq #15,%d7
	eor.l %d6,%d0
	muls.l %d1,%d0
	move.l %d0,%d1
	lsr.l %d7,%d1
	eor.l %d1,%d0
	move.l #1935289751,%d1
	muls.l %d1,%d0
	move.l %d0,%d1
	lsr.l %d7,%d1
	mov3q.l #3,%d7
	eor.l %d0,%d1
	remu.l %d7,%d0:%d1
	move.l %d0,%d1
	addq.l #2,%d1
	muls.l %d5,%d1
	lsr.l #2,%d1
.L511:
	mvz.w %d4,%d0
	moveq #1,%d7
	move.l -408(%fp),%a1
	lsl.l #4,%d0
	move.b %d7,(%a1,%d0.l)
	add.l %d0,%a1
	move.b %d3,4(%a1)
	move.b %d1,2(%a1)
	moveq #127,%d0
	cmp.l %a0,%d0
	jcc .L512
	move.w #127,%a0
.L512:
	move.w %a0,%d1
	move.b %d1,3(%a1)
.L503:
	addq.l #1,%d4
	cmp.l %a4,%d4
	jcs .L513
	move.l %a3,%d0
	moveq #126,%d1
	move.l %d5,%a3
	move.l %d6,%d5
	move.l -368(%fp),%d3
	move.l -408(%fp),8(%fp)
	cmp.l %a3,%d1
	jcc .L592
	mov3q.l #1,%d4
	cmp.l %d3,%d4
	jeq .L592
.L602:
	mov3q.l #1,%a1
	move.l 8(%fp),-400(%fp)
.L595:
	mvz.w %a1,%d1
	move.l -400(%fp),%a0
	addq.l #1,%a1
	lsl.l #3,%d1
	add.l %d1,%a0
	tst.b (%a0)
	jeq .L594
	tst.b -8(%a0)
	jeq .L594
	moveq #1,%d1
	move.b %d1,1(%a0)
.L594:
	cmp.l %d3,%a1
	jcs .L595
	move.l -400(%fp),8(%fp)
.L592:
	move.b -351(%fp),%d1
	move.b -349(%fp),%d6
	move.b -350(%fp),%d4
	move.l 8(%fp),-400(%fp)
	move.w %d1,%a1
	mvz.b %d6,%d7
	move.b %d6,-385(%fp)
	move.w %d4,%a0
	mvz.b %d1,%d1
	add.l %d7,%d7
	mvz.b %d4,%d4
	move.l %d1,%a3
	move.w %a1,%d6
	move.l %d4,%a2
	addq.l #1,%d7
	move.l %d7,%a1
	move.b %d6,-392(%fp)
.L599:
	move.l %d0,%d4
	lsl.l #3,%d4
	move.l -400(%fp),%a4
	tst.b (%a4,%d4.l)
	jeq .L596
	tst.b -392(%fp)
	jne .L718
	move.w %a0,%d1
	tst.b %d1
	jne .L719
.L598:
	tst.b -385(%fp)
	jne .L720
.L596:
	addq.l #1,%d0
	cmp.l %d3,%d0
	jcs .L599
	move.l -400(%fp),8(%fp)
.L517:
	mvz.b -345(%fp),%d0
	move.l %d0,%a0
	pea -12(%a0)
	move.l %d2,-(%sp)
	move.l 8(%fp),-(%sp)
	jsr sg_transpose
	lea (12,%sp),%sp
	movem.l -452(%fp),#15612
	mov3q.l #1,%d0
	unlk %fp
	rts
.L464:
	mov3q.l #6,%d7
	cmp.l %a2,%d7
	jeq .L469
	mov3q.l #7,%d4
	cmp.l %a2,%d4
	jeq .L470
	mov3q.l #5,%d6
	cmp.l %a2,%d6
	jne .L721
	tst.l %a5
	jeq .L517
	moveq #16,%d4
	cmp.l %d1,%d4
	jcc .L526
	moveq #16,%d1
.L526:
	mulu.w %d3,%d1
	move.l -132(%fp),%a4
	add.l #1831565813,%d5
	move.l -136(%fp),%a3
	clr.l %d4
	move.l -140(%fp),%a1
	move.l -144(%fp),%a0
	move.l -148(%fp),-400(%fp)
	addq.l #8,%d1
	lsr.l #4,%d1
	jne .L722
	move.l 8(%fp),-400(%fp)
.L527:
	addq.l #1,%d4
	cmp.l %d3,%d4
	jcs .L527
	move.l -400(%fp),8(%fp)
	moveq #126,%d1
	cmp.l %a1,%d1
	jcc .L592
.L753:
	mov3q.l #1,%d4
	cmp.l %d3,%d4
	jne .L602
	jra .L592
.L469:
	move.l %d1,%a2
	moveq #16,%d4
	cmp.l %d1,%d4
	jcs .L723
	move.l %a2,%d6
	mov3q.l #3,%d7
	divu.l %d7,%d6
	move.l -144(%fp),%a0
	move.l %d6,%a4
	addq.l #1,%a4
	tst.l %a0
	jlt .L724
.L540:
	move.l -148(%fp),%d7
	cmp.l %a0,%d7
	sle %d6
	neg.l %d6
	tst.b %d6
	jne .L725
.L542:
	lea (%fp,%a0.l*4),%a1
	sub.l %a0,%a0
	move.l %a2,%d4
	move.l 8(%fp),-400(%fp)
	move.l -248(%a1),%a1
.L543:
	move.l %a1,-128(%fp,%a0.l*4)
	addq.l #1,%a0
	cmp.l %a4,%a0
	jcc .L726
	tst.l %d7
	jne .L727
	move.l -248(%fp),%a1
	jra .L543
.L725:
	move.l %d7,%a0
	subq.l #1,%a0
	lea (%fp,%a0.l*4),%a1
	sub.l %a0,%a0
	move.l %a2,%d4
	move.l 8(%fp),-400(%fp)
	move.l -248(%a1),%a1
	jra .L543
.L723:
	move.w #16,%a2
	mov3q.l #3,%d7
	move.l -144(%fp),%a0
	move.l %a2,%d6
	divu.l %d7,%d6
	move.l %d6,%a4
	addq.l #1,%a4
	tst.l %a0
	jge .L540
.L724:
	move.l -148(%fp),%d7
	sub.l %a0,%a0
	cmp.l %a0,%d7
	sle %d6
	neg.l %d6
	tst.b %d6
	jeq .L542
	jra .L725
.L715:
	tst.l %a5
	jeq .L566
	move.l -144(%fp),%a2
	tst.l %a2
	jlt .L728
	move.l -148(%fp),%a5
	moveq #16,%d7
	cmp.l %d1,%d7
	jcs .L729
.L475:
	move.w %d1,%d7
	move.l 8(%fp),%a3
	clr.l %d1
	move.l %d0,%a1
	mulu.w %d3,%d7
	addq.l #8,%d7
	lsr.l #4,%d7
.L477:
	mov3q.l #3,%d0
	and.l %d1,%d0
	move.l %d1,%d6
	not.l %d6
	moveq #2,%d4
	tst.l %d0
	jeq .L476
	mov3q.l #1,%d4
	and.l %d6,%d4
.L476:
	move.w %d4,-128(%fp,%d1.l*2)
	addq.l #1,%d1
	cmp.l %d3,%d1
	jcs .L477
	pea -364(%fp)
	pea -128(%fp)
	move.l %d7,-(%sp)
	move.l %d3,-(%sp)
	pea -312(%fp)
	move.l %d5,-364(%fp)
	move.l %a3,8(%fp)
	move.l %a1,-404(%fp)
	jsr pick
	lea (20,%sp),%sp
	move.l -364(%fp),%d5
	move.l -404(%fp),%d0
	cmp.l %a2,%a5
	jgt .L478
	lea (-1,%a5),%a2
.L478:
	lea (%fp,%a2.l*4),%a0
	lea -4(%fp,%a5.l*4),%a1
	move.l -140(%fp),%a3
	clr.l %d1
	move.l -132(%fp),-388(%fp)
	move.l -136(%fp),-392(%fp)
	move.l %a3,-376(%fp)
	move.l 8(%fp),-380(%fp)
	move.l %d3,-372(%fp)
	move.l %d0,%a3
	move.l %a1,-384(%fp)
	move.l -248(%a0),%a0
	move.l %a0,%d7
	move.l %a0,-396(%fp)
.L495:
	lea (%fp,%d1.l),%a1
	tst.b -312(%a1)
	jeq .L479
	move.l %d5,%d6
	add.l #1831565813,%d6
	move.l %d6,%d4
	move.l #569420461,%d0
	clr.w %d4
	swap %d4
	eor.l %d6,%d4
	muls.l %d0,%d4
	moveq #15,%d0
	move.l %d4,%d3
	lsr.l %d0,%d3
	eor.l %d3,%d4
	move.l #1935289751,%d3
	muls.l %d3,%d4
	move.l %d4,%d3
	lsr.l %d0,%d3
	moveq #100,%d0
	eor.l %d3,%d4
	remu.l %d0,%d3:%d4
	moveq #34,%d4
	cmp.l %d3,%d4
	jcc .L607
	moveq #69,%d0
	cmp.l %d3,%d0
	jcc .L730
	tst.l %a5
	jne .L731
	clr.l %d5
	lea (%fp,%d5.l*4),%a0
	move.l -248(%a0),%d7
.L480:
	move.l %d6,%d5
	add.l #1831565813,%d5
	move.l %d5,%d4
	moveq #15,%d0
	clr.w %d4
	swap %d4
	move.l #1935289751,%d3
	eor.l %d5,%d4
	move.l #569420461,%d5
	muls.l %d5,%d4
	move.l %d4,%d5
	lsr.l %d0,%d5
	eor.l %d5,%d4
	muls.l %d3,%d4
	move.l %d4,%d5
	lsr.l %d0,%d5
	mov3q.l #7,%d0
	eor.l %d4,%d5
	remu.l %d0,%d4:%d5
	tst.l %d4
	jne .L490
	move.l -384(%fp),%a2
	move.l %d7,%a0
	lea (11,%a0),%a0
	cmp.l -248(%a2),%a0
	jge .L490
	add.l #12,%d7
.L490:
	move.l %d6,%d5
	add.l #-631835670,%d5
	move.l %d5,%d4
	move.l #569420461,%d0
	clr.w %d4
	swap %d4
	eor.l %d5,%d4
	muls.l %d0,%d4
	moveq #15,%d0
	move.l %d4,%d3
	lsr.l %d0,%d3
	eor.l %d3,%d4
	move.l #1935289751,%d3
	muls.l %d3,%d4
	move.l %d4,%d3
	lsr.l %d0,%d3
	mov3q.l #3,%d0
	eor.l %d3,%d4
	and.l %d0,%d4
	tst.l %d4
	jne .L610
	move.l -392(%fp),%a2
	moveq #126,%d3
	cmp.l -376(%fp),%d3
	jcs .L611
.L740:
	move.l %d6,%d5
	add.l #1199730143,%d5
	move.l %d5,%d4
	move.l #569420461,%d6
	clr.w %d4
	swap %d4
	moveq #15,%d0
	move.l #1935289751,%d3
	eor.l %d5,%d4
	muls.l %d6,%d4
	move.l %d4,%d6
	lsr.l %d0,%d6
	eor.l %d6,%d4
	muls.l %d3,%d4
	move.l -376(%fp),%d3
	move.l %d4,%d6
	lsr.l %d0,%d6
	mov3q.l #3,%d0
	eor.l %d4,%d6
	remu.l %d0,%d4:%d6
	move.l %d4,%d6
	addq.l #2,%d6
	muls.l %d3,%d6
	lsr.l #2,%d6
.L493:
	mvz.w %d1,%d4
	move.l %d1,%d0
	moveq #127,%d3
	lsl.l #3,%d0
	move.l -380(%fp),%a0
	lsl.l #3,%d4
	move.l %d0,%a4
	add.l -380(%fp),%a4
	add.l %d4,%a0
	move.b #1,(%a0)
	move.b %d7,4(%a4)
	move.b %d6,2(%a4)
	cmp.l %a2,%d3
	jcc .L494
	move.w #127,%a2
.L494:
	move.w %a2,%d4
	move.b %d4,3(%a4)
	tst.l %d1
	jeq .L479
	tst.b -313(%a1)
	jne .L732
.L479:
	addq.l #1,%d1
	cmp.l -372(%fp),%d1
	jcs .L495
	move.l %a3,%d0
	moveq #126,%d1
	move.l -376(%fp),%a3
	move.l -372(%fp),%d3
	move.l -380(%fp),8(%fp)
	cmp.l %a3,%d1
	jcc .L592
	mov3q.l #1,%d1
	cmp.l %d3,%d1
	jeq .L592
.L711:
	mov3q.l #1,%a1
	move.l 8(%fp),-400(%fp)
	jra .L595
.L470:
	add.l #1831565813,%d5
	move.l %d5,%d4
	move.l #569420461,%d6
	clr.w %d4
	swap %d4
	moveq #15,%d7
	lea (sizes.2),%a0
	eor.l %d5,%d4
	muls.l %d6,%d4
	move.l %d4,%d6
	lsr.l %d7,%d6
	eor.l %d6,%d4
	move.l #1935289751,%d6
	muls.l %d6,%d4
	move.l %d4,%d6
	lsr.l %d7,%d6
	mov3q.l #3,%d7
	eor.l %d6,%d4
	remu.l %d7,%d6:%d4
	mvz.b (%a0,%d6.l),%d4
	tst.l %d4
	jeq .L564
	move.l -148(%fp),%d7
	sub.l %a0,%a0
	tst.l %d7
	jne .L733
	move.l 8(%fp),-400(%fp)
.L562:
	lea (%fp,%a0.l*4),%a1
	addq.l #1,%a0
	move.l -248(%fp),-344(%a1)
	cmp.l %d4,%a0
	jcs .L562
	move.l -400(%fp),8(%fp)
.L564:
	tst.l %d3
	jeq .L566
	moveq #16,%d6
	cmp.l %d1,%d6
	jcs .L734
	mulu.w %d3,%d1
	clr.l %d6
	move.l 8(%fp),-400(%fp)
	addq.l #8,%d1
	lsr.l #4,%d1
	move.l %d1,%a0
.L568:
	move.l %d6,%d7
	remu.l %d4,%d1:%d7
	tst.l %d1
	seq %d1
	ext.w %d1
	neg.l %d1
	move.w %d1,-128(%fp,%d6.l*2)
	addq.l #1,%d6
	cmp.l %d3,%d6
	jcs .L568
	pea -364(%fp)
	pea -128(%fp)
	move.l %a0,-(%sp)
	move.l %d3,-(%sp)
	pea -312(%fp)
	move.l %d5,-364(%fp)
	move.l %d0,-404(%fp)
	move.l %d4,%a3
	subq.l #1,%a3
	move.l -400(%fp),%a2
	jsr pick
	lea (20,%sp),%sp
	move.l -140(%fp),%a0
	move.l -364(%fp),%d5
	move.l -132(%fp),%a5
	clr.l %d1
	move.l %a0,-396(%fp)
	move.l -136(%fp),%a4
	move.l -404(%fp),%a0
	move.l %a3,-392(%fp)
	move.l %a2,-400(%fp)
	move.l %d3,-388(%fp)
.L579:
	move.l %d1,%d6
	mov3q.l #1,%d3
	remu.l %d4,%d7:%d6
	divu.l %d4,%d6
	lea (%fp,%d1.l),%a1
	move.b -312(%a1),%d0
	and.l %d3,%d6
	tst.l %d7
	jeq .L569
	tst.l %d6
	jne .L570
	tst.b %d0
	jeq .L576
	move.l %d7,%d6
	move.l %a5,%a1
.L571:
	moveq #126,%d7
	cmp.l -396(%fp),%d7
	jcs .L628
.L738:
	add.l #1831565813,%d5
	move.l %d5,%d7
	move.l #569420461,%d0
	clr.w %d7
	swap %d7
	moveq #15,%d3
	eor.l %d5,%d7
	muls.l %d0,%d7
	move.l %d7,%d0
	lsr.l %d3,%d0
	eor.l %d0,%d7
	move.l #1935289751,%d0
	muls.l %d0,%d7
	move.l %d7,%d0
	lsr.l %d3,%d0
	mov3q.l #3,%d3
	eor.l %d7,%d0
	remu.l %d3,%d7:%d0
	move.l -396(%fp),%d0
	addq.l #2,%d7
	muls.l %d0,%d7
	lsr.l #2,%d7
.L577:
	move.l %d1,%d3
	lsl.l #3,%d3
	moveq #1,%d0
	lea (%fp,%d6.l*4),%a2
	move.l %a1,%d6
	move.l %d3,%a1
	move.l -400(%fp),%d3
	move.b %d0,(%a1,%d3.l)
	add.l %d3,%a1
	move.b %d7,2(%a1)
	move.b -341(%a2),4(%a1)
	moveq #127,%d7
	cmp.l %d6,%d7
	jcc .L578
	moveq #127,%d6
.L578:
	move.b %d6,3(%a1)
.L576:
	addq.l #1,%d1
	cmp.l -388(%fp),%d1
	jcs .L579
	move.l %a0,%d0
	moveq #126,%d1
	move.l -396(%fp),%a0
	move.l -388(%fp),%d3
	move.l -400(%fp),8(%fp)
	cmp.l %a0,%d1
	jcc .L592
	mov3q.l #1,%d7
	cmp.l %d3,%d7
	jeq .L592
.L712:
	mov3q.l #1,%a1
	move.l 8(%fp),-400(%fp)
	jra .L595
.L732:
	add.l #1831565813,%d5
	move.l %d5,%d4
	move.l #569420461,%d6
	clr.w %d4
	swap %d4
	moveq #15,%d0
	move.l #1935289751,%d3
	eor.l %d5,%d4
	muls.l %d6,%d4
	move.l %d4,%d6
	lsr.l %d0,%d6
	eor.l %d6,%d4
	muls.l %d3,%d4
	move.l %d4,%d6
	lsr.l %d0,%d6
	mov3q.l #6,%d0
	eor.l %d6,%d4
	remu.l %d0,%d6:%d4
	tst.l %d6
	jne .L479
	moveq #1,%d3
	move.b %d3,1(%a0)
	jra .L479
.L720:
	add.l #1831565813,%d5
	move.l %d5,%d1
	move.l #569420461,%d6
	clr.w %d1
	swap %d1
	moveq #15,%d7
	move.l -400(%fp),%a4
	eor.l %d5,%d1
	muls.l %d1,%d6
	move.l %d6,%d1
	lsr.l %d7,%d6
	eor.l %d6,%d1
	move.l #1935289751,%d6
	muls.l %d1,%d6
	move.l %a1,%d1
	move.l %d6,%a5
	lsr.l %d7,%d6
	move.l %a5,%d7
	eor.l %d6,%d7
	remu.l %d1,%d6:%d7
	move.b -385(%fp),%d7
	move.l %d6,%d1
	sub.l %d7,%d1
	move.b %d1,6(%a4,%d4.l)
	jra .L596
.L719:
	move.l %d5,%a4
	add.l #1831565813,%a4
	move.l %a4,%d1
	move.l %a4,%d6
	clr.w %d1
	swap %d1
	move.l #569420461,%d7
	eor.l %d6,%d1
	moveq #15,%d6
	muls.l %d1,%d7
	move.l %d7,%d1
	lsr.l %d6,%d1
	eor.l %d7,%d1
	move.l #1935289751,%d7
	muls.l %d1,%d7
	move.l %d7,%d1
	lsr.l %d6,%d1
	moveq #100,%d6
	eor.l %d7,%d1
	remu.l %d6,%d7:%d1
	cmp.l %a2,%d7
	jcs .L735
	move.l %a4,%d5
	tst.b -385(%fp)
	jeq .L596
	jra .L720
.L718:
	move.l %d5,%a4
	add.l #1831565813,%a4
	move.l %a4,%d7
	move.l %a4,%d1
	clr.w %d7
	swap %d7
	move.l #569420461,%d6
	eor.l %d1,%d7
	moveq #15,%d1
	muls.l %d7,%d6
	move.l %d6,%d7
	lsr.l %d1,%d7
	move.l %d7,%d1
	eor.l %d6,%d1
	move.l #1935289751,%d6
	muls.l %d1,%d6
	moveq #15,%d1
	move.l %d6,%d7
	lsr.l %d1,%d7
	eor.l %d6,%d7
	moveq #100,%d6
	remu.l %d6,%d1:%d7
	cmp.l %a3,%d1
	jcs .L736
	move.w %a0,%d1
	move.l %a4,%d5
	tst.b %d1
	jeq .L598
	jra .L719
.L735:
	add.l #-631835670,%d5
	move.l %d5,%d1
	move.l #569420461,%d6
	clr.w %d1
	swap %d1
	moveq #15,%d7
	move.l -400(%fp),%a4
	eor.l %d5,%d1
	muls.l %d1,%d6
	move.l %d6,%d1
	lsr.l %d7,%d6
	eor.l %d6,%d1
	move.l #1935289751,%d6
	muls.l %d1,%d6
	mov3q.l #3,%d1
	move.l %d6,%a5
	lsr.l %d7,%d6
	move.l %a5,%d7
	eor.l %d6,%d7
	remu.l %d1,%d6:%d7
	move.l %d6,%d1
	addq.l #2,%d1
	move.b %d1,7(%a4,%d4.l)
	tst.b -385(%fp)
	jeq .L596
	jra .L720
.L736:
	add.l #-631835670,%d5
	move.l %d5,%d1
	move.l #569420461,%d6
	clr.w %d1
	swap %d1
	moveq #15,%d7
	eor.l %d5,%d1
	muls.l %d1,%d6
	move.l %d6,%d1
	lsr.l %d7,%d6
	eor.l %d6,%d1
	move.l #1935289751,%d6
	muls.l %d1,%d6
	mov3q.l #5,%d1
	move.l %d6,%a5
	lsr.l %d7,%d6
	move.l %a5,%d7
	move.l -400(%fp),%a5
	eor.l %d6,%d7
	remu.l %d1,%d6:%d7
	move.w %a0,%d1
	move.l %d6,%a4
	add.l #pcts.1,%a4
	move.b (%a4),5(%a5,%d4.l)
	tst.b %d1
	jeq .L598
	jra .L719
.L569:
	cmp.l %d4,%d1
	jcs .L707
	tst.l %d4
	jne .L737
	sub.l %a2,%a2
	lea (%fp,%a2.l*4),%a3
	sub.l %a1,%a1
	lea (%fp,%a1.l*4),%a2
	move.l -344(%a3),%d7
	move.l -344(%a2),-344(%a3)
	move.l %d7,-344(%a2)
.L707:
	tst.l %d6
	jne .L574
	tst.b %d0
	jeq .L576
	move.l %a4,%a1
	moveq #126,%d7
	cmp.l -396(%fp),%d7
	jcc .L738
.L628:
	moveq #127,%d7
	jra .L577
.L570:
	tst.b %d0
	jeq .L576
	move.l -392(%fp),%d6
	move.l %a5,%a1
	sub.l %d7,%d6
	jra .L571
.L613:
	move.l -388(%fp),%a0
	moveq #126,%d7
	cmp.l %d5,%d7
	jcc .L739
.L614:
	moveq #127,%d1
	move.l %d0,%d6
	jra .L511
.L504:
	move.l %d1,%a0
	moveq #19,%d3
	lea (-70,%a0),%a0
	cmp.l %a0,%d3
	jcs .L508
	moveq #24,%d6
	cmp.l -372(%fp),%d6
	jcs .L507
	moveq #17,%d7
	cmp.l -412(%fp),%d7
	jcs .L507
	move.l -396(%fp),%d1
	moveq #12,%d3
	move.l -412(%fp),%d7
	lea sg_scale_masks,%a0
	remu.l %d3,%d6:%d1
	mvz.w (%a0,%d7.l*2),%d7
	move.l %a5,%d3
	addq.l #7,%d3
	moveq #48,%d1
	sub.l %d6,%d1
	move.l %d7,%a0
	add.l %d3,%d1
	moveq #12,%d7
	remu.l %d7,%d6:%d1
	move.l %a0,%d1
	btst %d6,%d1
	jeq .L507
	move.l -400(%fp),%d6
	move.l %a5,%d1
	addq.l #6,%d1
	lea -4(%fp,%d6.l*4),%a0
	cmp.l -248(%a0),%d1
	jlt .L506
.L507:
	move.l %a5,%d3
	jra .L506
.L607:
	move.l -396(%fp),%d7
	jra .L480
.L610:
	move.l -388(%fp),%a2
	moveq #126,%d3
	cmp.l -376(%fp),%d3
	jcc .L740
.L611:
	moveq #127,%d6
	jra .L493
.L574:
	tst.b %d0
	jeq .L576
	move.l -392(%fp),%d6
	move.l %a4,%a1
	jra .L571
.L505:
	cmp.l -376(%fp),%a2
	jle .L507
	move.l %a5,%d3
	add.l #-12,%d3
	jra .L506
.L721:
	tst.l %a5
	jeq .L566
	moveq #16,%d4
	cmp.l %d1,%d4
	jcs .L741
	move.w %d1,%d4
	move.l 8(%fp),%a2
	clr.l %d1
	move.l %d0,%a1
	mulu.w %d3,%d4
	addq.l #8,%d4
	lsr.l #4,%d4
.L585:
	mov3q.l #7,%d0
	and.l %d1,%d0
	mov3q.l #3,%d7
	and.l %d1,%d7
	moveq #3,%d6
	tst.l %d0
	jeq .L584
	tst.l %d7
	jeq .L630
	move.l %d1,%d6
	mov3q.l #1,%d7
	not.l %d6
	and.l %d7,%d6
.L584:
	move.w %d6,-128(%fp,%d1.l*2)
	addq.l #1,%d1
	cmp.l %d3,%d1
	jcs .L585
	pea -364(%fp)
	pea -128(%fp)
	move.l %d4,-(%sp)
	move.l %d3,-(%sp)
	pea -312(%fp)
	move.l %a2,8(%fp)
	move.l %d5,-364(%fp)
	move.l %a1,-404(%fp)
	jsr pick
	lea (20,%sp),%sp
	move.l -364(%fp),%d5
	clr.l %d1
	move.l -132(%fp),%a2
	move.l -136(%fp),%a1
	move.l -140(%fp),%d6
	move.l -404(%fp),%a5
	move.l 8(%fp),%a4
.L590:
	lea (%fp,%d1.l),%a0
	tst.b -312(%a0)
	jeq .L586
	mov3q.l #3,%d4
	and.l %d1,%d4
	tst.l %d4
	jne .L631
	move.l %a1,%a0
	moveq #126,%d0
	cmp.l %d6,%d0
	jcs .L632
.L742:
	add.l #1831565813,%d5
	move.l %d5,%d4
	move.l #569420461,%d7
	clr.w %d4
	swap %d4
	moveq #15,%d0
	eor.l %d5,%d4
	muls.l %d7,%d4
	move.l %d4,%d7
	lsr.l %d0,%d7
	eor.l %d7,%d4
	move.l #1935289751,%d7
	muls.l %d7,%d4
	move.l %d4,%d7
	lsr.l %d0,%d7
	mov3q.l #3,%d0
	eor.l %d4,%d7
	remu.l %d0,%d4:%d7
	addq.l #2,%d4
	muls.l %d6,%d4
	lsr.l #2,%d4
.L588:
	move.l %d1,%d7
	lsl.l #3,%d7
	moveq #1,%d0
	lea (%a4,%d7.l),%a3
	move.b %d0,(%a4,%d7.l)
	move.b %d4,2(%a3)
	moveq #127,%d4
	cmp.l %a0,%d4
	jcc .L589
	move.w #127,%a0
.L589:
	move.w %a0,%d0
	moveq #-128,%d4
	move.b %d0,3(%a3)
	move.b %d4,4(%a4,%d7.l)
.L586:
	addq.l #1,%d1
	cmp.l %d3,%d1
	jcs .L590
	move.l %a5,%d0
	moveq #126,%d7
	move.l %a4,8(%fp)
	cmp.l %d6,%d7
	jcc .L592
	mov3q.l #1,%d1
	cmp.l %d3,%d1
	jne .L711
	jra .L592
.L631:
	move.l %a2,%a0
	moveq #126,%d0
	cmp.l %d6,%d0
	jcc .L742
.L632:
	moveq #127,%d4
	jra .L588
.L630:
	moveq #2,%d6
	jra .L584
.L466:
	pea -364(%fp)
	move.l #569420461,%d4
	mov3q.l #1,-(%sp)
	move.l #1935289751,%d6
	add.l #1831565813,%d5
	move.l %d1,-(%sp)
	move.l %d5,%d1
	mov3q.l #6,%d7
	move.l %d5,-364(%fp)
	clr.w %d1
	swap %d1
	eor.l %d5,%d1
	moveq #15,%d5
	muls.l %d4,%d1
	move.l %d1,%d4
	lsr.l %d5,%d4
	eor.l %d4,%d1
	muls.l %d6,%d1
	move.l %d1,%d4
	lsr.l %d5,%d4
	eor.l %d4,%d1
	remu.l %d7,%d4:%d1
	move.l %d4,%a0
	pea 2(%a0)
.L705:
	move.l %d3,-(%sp)
	moveq #126,%d4
	pea -248(%fp)
	move.l 8(%fp),-(%sp)
	move.l %d0,-404(%fp)
	jsr gen_cell
	lea (28,%sp),%sp
	move.l -140(%fp),%d1
	move.l -364(%fp),%d5
	move.l -404(%fp),%d0
	cmp.l %d1,%d4
	jcc .L593
	mov3q.l #1,%d6
	cmp.l %d3,%d6
	jcs .L602
.L593:
	tst.l %d3
	jeq .L517
	move.b -351(%fp),%d1
	move.b -349(%fp),%d6
	move.b -350(%fp),%d4
	move.l 8(%fp),-400(%fp)
	move.w %d1,%a1
	mvz.b %d6,%d7
	move.b %d6,-385(%fp)
	move.w %d4,%a0
	mvz.b %d1,%d1
	add.l %d7,%d7
	mvz.b %d4,%d4
	move.l %d1,%a3
	move.w %a1,%d6
	move.l %d4,%a2
	addq.l #1,%d7
	move.l %d7,%a1
	move.b %d6,-392(%fp)
	jra .L599
.L465:
	pea -364(%fp)
	move.l #569420461,%d4
	clr.l -(%sp)
	move.l #1935289751,%d6
	add.l #1831565813,%d5
	move.l %d1,-(%sp)
	move.l %d5,%d1
	mov3q.l #3,%d7
	move.l %d5,-364(%fp)
	clr.w %d1
	swap %d1
	lea (n.3),%a0
	eor.l %d5,%d1
	moveq #15,%d5
	muls.l %d4,%d1
	move.l %d1,%d4
	lsr.l %d5,%d4
	eor.l %d4,%d1
	muls.l %d6,%d1
	move.l %d1,%d4
	lsr.l %d5,%d4
	eor.l %d4,%d1
	remu.l %d7,%d4:%d1
	mvz.b (%a0,%d4.l),%d1
	move.l %d1,-(%sp)
	jra .L705
.L463:
	tst.l %a5
	jeq .L517
	move.l -140(%fp),%a2
	move.l -136(%fp),%a0
	addq.l #1,%a0
	move.l -132(%fp),%a4
	sub.l %a4,%a0
	move.l %a2,-392(%fp)
	move.l %a0,-396(%fp)
	tst.l %a2
	jeq .L743
	move.l -148(%fp),%a3
	clr.l %d4
	move.l %d1,-388(%fp)
	move.l %d0,%a5
	move.l 8(%fp),-400(%fp)
	move.l %d3,-384(%fp)
.L524:
	move.l %d5,%d6
	add.l #1831565813,%d6
	move.l %d6,%d7
	move.l #569420461,%d0
	moveq #15,%d1
	move.l #1935289751,%d3
	clr.w %d7
	swap %d7
	eor.l %d6,%d7
	muls.l %d0,%d7
	move.l %d7,%d0
	lsr.l %d1,%d0
	eor.l %d0,%d7
	muls.l %d3,%d7
	move.l %d7,%d0
	lsr.l %d1,%d0
	eor.l %d0,%d7
	and.l %d1,%d7
	cmp.l -388(%fp),%d7
	jcc .L615
	tst.l -396(%fp)
	jne .L744
	move.l %a4,%d5
	moveq #126,%d1
	cmp.l %a2,%d1
	jcc .L745
.L617:
	moveq #127,%d7
	tst.l %a3
	jne .L746
.L618:
	sub.l %a0,%a0
.L522:
	move.l %d4,%d0
	lsl.l #3,%d0
	moveq #1,%d1
	lea (%fp,%a0.l*4),%a1
	move.l -400(%fp),%d3
	move.l %d0,%a0
	move.b %d1,(%a0,%d3.l)
	add.l %d3,%a0
	move.b %d7,2(%a0)
	move.b -245(%a1),4(%a0)
	moveq #127,%d7
	cmp.l %d5,%d7
	jcc .L523
	moveq #127,%d5
.L523:
	move.b %d5,3(%a0)
	move.l %d6,%d5
.L519:
	addq.l #1,%d4
	cmp.l -384(%fp),%d4
	jcs .L524
	move.l -384(%fp),%d3
	move.l %a5,%d0
	move.l -400(%fp),8(%fp)
	moveq #126,%d6
	cmp.l %a2,%d6
	jcc .L592
	mov3q.l #1,%d7
	cmp.l %d3,%d7
	jne .L712
	jra .L592
.L615:
	move.l %d6,%d5
	jra .L519
.L744:
	add.l #1831565813,%d6
	move.l %d6,%d5
	move.l #569420461,%d7
	clr.w %d5
	swap %d5
	move.l -396(%fp),%d0
	eor.l %d6,%d5
	muls.l %d7,%d5
	move.l %d5,%d7
	lsr.l %d1,%d7
	eor.l %d7,%d5
	muls.l %d3,%d5
	move.l %d5,%d7
	lsr.l %d1,%d7
	moveq #126,%d1
	eor.l %d7,%d5
	remu.l %d0,%d7:%d5
	move.l %d7,%d5
	add.l %a4,%d5
	cmp.l %a2,%d1
	jcs .L617
.L745:
	add.l #1831565813,%d6
	move.l %d6,%d7
	move.l #569420461,%d3
	clr.w %d7
	swap %d7
	moveq #15,%d1
	eor.l %d6,%d7
	muls.l %d3,%d7
	move.l #1935289751,%d3
	move.l %d7,%d0
	lsr.l %d1,%d0
	eor.l %d0,%d7
	muls.l %d3,%d7
	move.l %d7,%d0
	lsr.l %d1,%d0
	move.l -392(%fp),%d1
	eor.l %d0,%d7
	remu.l %d1,%d3:%d7
	move.l %d3,%d7
	addq.l #1,%d7
	tst.l %a3
	jeq .L618
.L746:
	add.l #1831565813,%d6
	move.l %d6,%d0
	move.l #569420461,%d1
	clr.w %d0
	swap %d0
	moveq #15,%d3
	eor.l %d6,%d0
	muls.l %d1,%d0
	move.l %d0,%d1
	lsr.l %d3,%d0
	move.l #1935289751,%d3
	eor.l %d0,%d1
	moveq #15,%d0
	muls.l %d3,%d1
	move.l %d1,%d3
	lsr.l %d0,%d1
	move.l %a3,%d0
	eor.l %d3,%d1
	remu.l %d0,%d3:%d1
	move.l %d3,%a0
	jra .L522
.L730:
	add.l #1831565813,%d6
	move.l %d6,%d5
	move.l #569420461,%d3
	clr.w %d5
	swap %d5
	moveq #15,%d0
	eor.l %d6,%d5
	muls.l %d3,%d5
	move.l #1935289751,%d3
	move.l %d5,%d4
	lsr.l %d0,%d4
	eor.l %d5,%d4
	muls.l %d3,%d4
	move.l %d4,%d5
	lsr.l %d0,%d5
	eor.l %d5,%d4
	mov3q.l #3,%d5
	remu.l %d5,%d0:%d4
	move.l %d0,-400(%fp)
	tst.l %a5
	jeq .L482
	move.l -376(%fp),%d0
	sub.l %a2,%a2
	move.l -372(%fp),%d3
	sub.l %a0,%a0
	moveq #99,%d5
.L485:
	lea (%fp,%a0.l*4),%a4
	move.l -248(%a4),%d4
	sub.l %d7,%d4
	jmi .L747
.L483:
	cmp.l %d4,%d5
	jle .L484
	move.l %a0,%a2
	move.l %d4,%d5
.L484:
	addq.l #1,%a0
	cmp.l %a0,%a5
	jhi .L485
	move.l %d3,-372(%fp)
	move.l -400(%fp),%d3
	mov3q.l #-1,%d4
	move.l %d0,-376(%fp)
	lea -1(%a2,%d3.l),%a0
	cmp.l %a0,%d4
	jeq .L486
	cmp.l %a0,%a5
	jle .L600
	lea (%fp,%a0.l*4),%a0
	move.l -248(%a0),%d7
	jra .L480
.L747:
	neg.l %d4
	jra .L483
.L726:
	move.l %d4,%a2
	move.l -400(%fp),8(%fp)
.L546:
	tst.l %d1
	jeq .L548
	mvz.w %a2,%d1
	lsl.l #2,%d1
	add.l #30,%d1
.L548:
	tst.l %d3
	jeq .L517
	move.l -140(%fp),%a3
	clr.l %d6
	move.l -132(%fp),-388(%fp)
	move.l -136(%fp),-392(%fp)
	move.l %a3,-384(%fp)
	move.l %a4,-400(%fp)
	move.l %d1,%a1
	move.l %d3,%a2
	move.l %d0,%a3
	move.l 8(%fp),-396(%fp)
.L557:
	move.l %d5,%d7
	add.l #1831565813,%d7
	move.l %d7,%d0
	move.l #569420461,%d1
	clr.w %d0
	swap %d0
	moveq #15,%d3
	eor.l %d7,%d0
	muls.l %d1,%d0
	moveq #100,%d1
	move.l %d0,%d4
	lsr.l %d3,%d4
	eor.l %d4,%d0
	move.l #1935289751,%d4
	muls.l %d4,%d0
	move.l %d0,%d4
	lsr.l %d3,%d4
	eor.l %d4,%d0
	remu.l %d1,%d4:%d0
	cmp.l %d4,%a1
	jls .L622
	mov3q.l #3,%d0
	and.l %d6,%d0
	tst.l %d0
	jne .L623
	move.l -392(%fp),%d0
	moveq #126,%d3
	cmp.l -384(%fp),%d3
	jcs .L624
.L749:
	move.l %d5,%d7
	add.l #-631835670,%d7
	move.l %d7,%d4
	move.l #569420461,%d5
	clr.w %d4
	swap %d4
	moveq #15,%d1
	move.l #1935289751,%d3
	eor.l %d7,%d4
	muls.l %d5,%d4
	move.l %d4,%d5
	lsr.l %d1,%d5
	eor.l %d5,%d4
	muls.l %d3,%d4
	move.l -384(%fp),%d3
	move.l %d4,%d5
	lsr.l %d1,%d5
	mov3q.l #3,%d1
	eor.l %d4,%d5
	remu.l %d1,%d4:%d5
	addq.l #2,%d4
	muls.l %d3,%d4
	lsr.l #2,%d4
	move.b %d4,%d1
.L552:
	mvz.w %d6,%d4
	move.l %d7,%d5
	add.l #1831565813,%d5
	move.l %d6,%d3
	lsl.l #3,%d3
	lsl.l #3,%d4
	move.l %d3,%a4
	moveq #15,%d3
	move.l %d4,%a0
	move.l %d5,%d4
	clr.w %d4
	swap %d4
	add.l -396(%fp),%a0
	add.l -396(%fp),%a4
	move.b #1,(%a0)
	move.b %d1,2(%a4)
	move.l #569420461,%d1
	eor.l %d5,%d4
	muls.l %d1,%d4
	move.l %d4,%d1
	lsr.l %d3,%d1
	eor.l %d1,%d4
	move.l #1935289751,%d1
	muls.l %d1,%d4
	move.l %d4,%d1
	lsr.l %d3,%d1
	move.l -400(%fp),%d3
	eor.l %d1,%d4
	remu.l %d3,%d1:%d4
	moveq #127,%d3
	move.l -128(%fp,%d1.l*4),%d4
	move.b %d4,4(%a4)
	cmp.l %d0,%d3
	jcc .L553
	moveq #127,%d0
.L553:
	move.b %d0,3(%a4)
	tst.l %d6
	jeq .L550
	tst.b -8(%a0)
	jeq .L550
	move.l %d6,%d0
	lsl.l #3,%d0
	move.l -396(%fp),%a4
	mvs.b %d4,%d4
	mvs.b -4(%a4,%d0.l),%d0
	cmp.l %d4,%d0
	jeq .L748
.L550:
	addq.l #1,%d6
	cmp.l %a2,%d6
	jcs .L557
	move.l %a3,%d0
	move.l %a2,%d3
	move.l -384(%fp),%a3
	moveq #126,%d1
	move.l -396(%fp),8(%fp)
	cmp.l %a3,%d1
	jcc .L592
	mov3q.l #1,%d6
	cmp.l %a2,%d6
	jeq .L592
	mov3q.l #1,%a1
	move.l 8(%fp),-400(%fp)
	jra .L595
.L623:
	move.l -388(%fp),%d0
	moveq #126,%d3
	cmp.l -384(%fp),%d3
	jcc .L749
.L624:
	moveq #127,%d1
	jra .L552
.L622:
	move.l %d7,%d5
	jra .L550
.L508:
	moveq #89,%d7
	cmp.l %d1,%d7
	jcc .L507
	tst.l -400(%fp)
	jne .L750
	move.l -376(%fp),%d3
	jra .L506
.L737:
	move.l %d5,%d7
	add.l #-631835670,%d5
	move.l %d5,%d3
	add.l #1831565813,%d7
	clr.w %d3
	swap %d3
	move.l %d3,%a2
	move.l %d7,%d3
	clr.w %d3
	swap %d3
	move.l %d3,%a3
	move.l %a2,%d3
	eor.l %d5,%d3
	move.l %d3,%a2
	move.l %a3,%d3
	eor.l %d7,%d3
	move.l %a2,%d7
	move.l %d3,%a1
	move.l #569420461,%d3
	muls.l %d3,%d7
	moveq #15,%d3
	move.l %d7,%a2
	lsr.l %d3,%d7
	move.l #569420461,%d3
	move.l %d7,%a3
	move.l %a1,%d7
	muls.l %d3,%d7
	move.l %a3,%d3
	move.l %d7,%a1
	move.l %a2,%d7
	eor.l %d3,%d7
	moveq #15,%d3
	move.l %d7,%a3
	move.l %a1,%d7
	lsr.l %d3,%d7
	move.l %a1,%d3
	eor.l %d3,%d7
	move.l #1935289751,%d3
	move.l %d7,%a2
	move.l %a3,%d7
	muls.l %d3,%d7
	moveq #15,%d3
	move.l %d7,%a1
	lsr.l %d3,%d7
	move.l #1935289751,%d3
	move.l %d7,%a3
	move.l %a2,%d7
	muls.l %d3,%d7
	move.l %a3,%d3
	move.l %d7,%a2
	move.l %a1,%d7
	eor.l %d3,%d7
	moveq #15,%d3
	move.l %d7,%a1
	move.l %a2,%d7
	lsr.l %d3,%d7
	move.l %a2,%d3
	eor.l %d3,%d7
	move.l %d7,%a3
	move.l %a1,%d7
	remu.l %d4,%d3:%d7
	move.l %a3,%d7
	move.l %d3,%a1
	remu.l %d4,%d3:%d7
	move.l %d3,%a2
	lea (%fp,%a2.l*4),%a3
	lea (%fp,%a1.l*4),%a2
	move.l -344(%a3),%d7
	move.l -344(%a2),-344(%a3)
	move.l %d7,-344(%a2)
	jra .L707
.L743:
	move.l -148(%fp),%a3
	clr.l %d4
	mov3q.l #1,-392(%fp)
	move.l %d1,-388(%fp)
	move.l %d0,%a5
	move.l 8(%fp),-400(%fp)
	move.l %d3,-384(%fp)
	jra .L524
.L741:
	moveq #16,%d1
	move.w %d1,%d4
	move.l 8(%fp),%a2
	clr.l %d1
	move.l %d0,%a1
	mulu.w %d3,%d4
	addq.l #8,%d4
	lsr.l #4,%d4
	jra .L585
.L729:
	moveq #16,%d1
	move.w %d1,%d7
	move.l 8(%fp),%a3
	clr.l %d1
	move.l %d0,%a1
	mulu.w %d3,%d7
	addq.l #8,%d7
	lsr.l #4,%d7
	jra .L477
.L717:
	move.w %a4,%d4
	moveq #16,%d1
	move.l 8(%fp),-392(%fp)
	mulu.w %d1,%d4
	clr.l %d1
	move.l %d4,%a0
	addq.l #8,%a0
	move.l %a0,%d6
	lsr.l #4,%d6
	move.l %d6,%a0
	jra .L501
.L734:
	moveq #16,%d1
	clr.l %d6
	mulu.w %d3,%d1
	move.l 8(%fp),-400(%fp)
	addq.l #8,%d1
	lsr.l #4,%d1
	move.l %d1,%a0
	jra .L568
.L728:
	move.l -148(%fp),%a5
	sub.l %a2,%a2
	moveq #16,%d7
	cmp.l %d1,%d7
	jcc .L475
	jra .L729
.L716:
	sub.l %a2,%a2
	move.l -148(%fp),-400(%fp)
	moveq #16,%d6
	cmp.l %d1,%d6
	jcc .L500
	jra .L717
.L748:
	move.l %d7,%d5
	add.l #-631835670,%d5
	move.l %d5,%d0
	move.l #569420461,%d1
	clr.w %d0
	swap %d0
	moveq #15,%d3
	mov3q.l #3,%d7
	eor.l %d5,%d0
	muls.l %d1,%d0
	move.l %d0,%d4
	lsr.l %d3,%d4
	eor.l %d4,%d0
	move.l #1935289751,%d4
	muls.l %d4,%d0
	move.l %d0,%d4
	lsr.l %d3,%d4
	eor.l %d4,%d0
	remu.l %d7,%d4:%d0
	tst.l %d4
	jne .L550
	moveq #1,%d0
	move.b %d0,1(%a0)
	jra .L550
.L482:
	tst.l -400(%fp)
	jeq .L486
.L600:
	lea (-1,%a5),%a0
	lea (%fp,%a0.l*4),%a0
	move.l -248(%a0),%d7
	jra .L480
.L722:
	move.l %d5,%d7
	move.l %d3,%a2
	clr.w %d7
	swap %d7
	move.l %d7,%d6
	move.l #569420461,%d7
	eor.l %d5,%d6
	muls.l %d6,%d7
	moveq #15,%d6
	move.l %d7,%a5
	lsr.l %d6,%d7
	move.l %d7,%d6
	move.l %a5,%d7
	eor.l %d6,%d7
	move.l #1935289751,%d6
	muls.l %d7,%d6
	moveq #15,%d7
	move.l %d6,%a5
	lsr.l %d7,%d6
	move.l %a5,%d7
	eor.l %d6,%d7
	remu.l %d3,%d6:%d7
	sub.l %d6,%a2
	tst.l %a0
	jlt .L751
.L528:
	cmp.l -400(%fp),%a0
	sge %d7
	neg.l %d7
	tst.b %d7
	jeq .L530
	move.l -400(%fp),%a0
	subq.l #1,%a0
.L530:
	lea (%fp,%a0.l*4),%a0
	move.l %a3,-392(%fp)
	move.l %d0,-388(%fp)
	move.l 8(%fp),-400(%fp)
	move.l %a0,%a5
	mov3q.l #1,%a0
.L531:
	move.l %a2,%d7
	add.l %d4,%d7
	remu.l %d3,%d6:%d7
	mulu.w %d1,%d6
	remu.l %d3,%d7:%d6
	cmp.l %d1,%d7
	jcc .L532
.L752:
	tst.l %a0
	jeq .L619
	move.l -392(%fp),%a3
	moveq #126,%d0
	cmp.l %a1,%d0
	jcs .L620
.L754:
	add.l #1831565813,%d5
	move.l %d5,%d6
	move.l #569420461,%d7
	clr.w %d6
	swap %d6
	eor.l %d5,%d6
	muls.l %d7,%d6
	moveq #15,%d7
	move.l %d6,%d0
	lsr.l %d7,%d0
	eor.l %d0,%d6
	move.l #1935289751,%d0
	muls.l %d0,%d6
	move.l %d6,%d0
	lsr.l %d7,%d0
	eor.l %d6,%d0
	mov3q.l #3,%d6
	remu.l %d6,%d7:%d0
	move.l %a1,%d0
	move.l %d7,%d6
	addq.l #2,%d6
	muls.l %d0,%d6
	lsr.l #2,%d6
.L534:
	move.l %d4,%d0
	move.l %a3,%d7
	lsl.l #3,%d0
	move.l -400(%fp),%a3
	move.l %d0,%a0
	moveq #1,%d0
	move.b %d0,(%a0,%a3.l)
	add.l %a3,%a0
	move.b -245(%a5),4(%a0)
	move.b %d6,2(%a0)
	moveq #127,%d0
	cmp.l %d7,%d0
	jcc .L535
	moveq #127,%d7
.L535:
	move.b %d7,3(%a0)
	addq.l #1,%d4
	cmp.l %d3,%d4
	jcc .L708
	move.l %a2,%d7
	add.l %d4,%d7
	remu.l %d3,%d6:%d7
	sub.l %a0,%a0
	mulu.w %d1,%d6
	remu.l %d3,%d7:%d6
	cmp.l %d1,%d7
	jcs .L752
.L532:
	addq.l #1,%d4
	cmp.l %d3,%d4
	jcs .L531
.L708:
	move.l -388(%fp),%d0
	moveq #126,%d1
	move.l -400(%fp),8(%fp)
	cmp.l %a1,%d1
	jcs .L753
	jra .L592
.L751:
	sub.l %a0,%a0
	jra .L528
.L619:
	move.l %a4,%a3
	moveq #126,%d0
	cmp.l %a1,%d0
	jcc .L754
.L620:
	moveq #127,%d6
	jra .L534
.L566:
	pea -364(%fp)
	pea -128(%fp)
	clr.l -(%sp)
	clr.l -(%sp)
	move.l %d5,-364(%fp)
	pea -312(%fp)
	jsr pick
	lea (20,%sp),%sp
	mvz.b -345(%fp),%d0
	move.l %d0,%a0
	pea -12(%a0)
	move.l %d2,-(%sp)
	move.l 8(%fp),-(%sp)
	jsr sg_transpose
	lea (12,%sp),%sp
	movem.l -452(%fp),#15612
	mov3q.l #1,%d0
	unlk %fp
	rts
.L731:
	move.l %d5,%d6
	add.l #-631835670,%d6
	move.l %d6,%d4
	move.l #569420461,%d5
	clr.w %d4
	swap %d4
	moveq #15,%d7
	move.l #1935289751,%d0
	move.l %a5,%d3
	eor.l %d6,%d4
	muls.l %d5,%d4
	move.l %d4,%d5
	lsr.l %d7,%d5
	eor.l %d5,%d4
	muls.l %d0,%d4
	move.l %d4,%d5
	lsr.l %d7,%d5
	eor.l %d5,%d4
	remu.l %d3,%d5:%d4
	lea (%fp,%d5.l*4),%a0
	move.l -248(%a0),%d7
	jra .L480
.L733:
	move.l 8(%fp),%a5
	move.l %d1,%a4
	move.l %d0,%a3
.L563:
	add.l #1831565813,%d5
	move.l %d5,%d6
	move.l #569420461,%d0
	clr.w %d6
	swap %d6
	moveq #15,%d1
	lea (%fp,%a0.l*4),%a1
	addq.l #1,%a0
	eor.l %d5,%d6
	muls.l %d0,%d6
	move.l %d6,%d0
	lsr.l %d1,%d0
	eor.l %d0,%d6
	move.l #1935289751,%d0
	muls.l %d0,%d6
	move.l %d6,%d0
	lsr.l %d1,%d0
	eor.l %d0,%d6
	remu.l %d7,%d1:%d6
	lea (%fp,%d1.l*4),%a2
	move.l -248(%a2),-344(%a1)
	cmp.l %a0,%d4
	jhi .L563
	move.l %a4,%d1
	move.l %a3,%d0
	move.l %a5,8(%fp)
	jra .L564
.L486:
	sub.l %a0,%a0
	lea (%fp,%a0.l*4),%a0
	move.l -248(%a0),%d7
	jra .L480
.L750:
	move.l %d6,%d0
	add.l #-631835670,%d0
	move.l %d0,%d1
	move.l #569420461,%d3
	clr.w %d1
	swap %d1
	moveq #15,%d6
	move.l #1935289751,%d7
	eor.l %d0,%d1
	muls.l %d3,%d1
	move.l %d1,%d3
	lsr.l %d6,%d3
	eor.l %d3,%d1
	muls.l %d7,%d1
	move.l %d1,%d3
	lsr.l %d6,%d3
	move.l -400(%fp),%d6
	eor.l %d3,%d1
	remu.l %d6,%d3:%d1
	lea (%fp,%d3.l*4),%a0
	move.l -248(%a0),%d3
	jra .L506
.L727:
	move.l %d7,%a2
	move.l %d0,%a3
.L545:
	add.l #1831565813,%d5
	move.l %d5,%d6
	move.l #569420461,%d0
	clr.w %d6
	swap %d6
	eor.l %d5,%d6
	muls.l %d0,%d6
	moveq #15,%d0
	move.l %d6,%d7
	lsr.l %d0,%d7
	eor.l %d7,%d6
	move.l #1935289751,%d7
	muls.l %d7,%d6
	move.l %d6,%d7
	lsr.l %d0,%d7
	move.l %a2,%d0
	eor.l %d7,%d6
	remu.l %d0,%d7:%d6
	lea (%fp,%d7.l*4),%a1
	lea (-248,%a1),%a1
	move.l (%a1),-128(%fp,%a0.l*4)
	addq.l #1,%a0
	cmp.l %a4,%a0
	jcs .L545
	move.l %d4,%a2
	move.l %a3,%d0
	move.l -400(%fp),8(%fp)
	jra .L546
	.size	sg_generate.part.0, .-sg_generate.part.0
	.align	2
	.globl	sg_generate
	.type	sg_generate, @function
sg_generate:
	move.l %d2,-(%sp)
	move.l 8(%sp),%d0
	move.l 12(%sp),%d1
	move.l 16(%sp),%a0
	tst.l %d0
	jeq .L757
	tst.l %d1
	jeq .L757
	lea (-1,%a0),%a1
	moveq #63,%d2
	cmp.l %a1,%d2
	jcs .L757
	moveq #127,%d2
	cmp.l 20(%sp),%d2
	jcc .L764
.L757:
	move.l (%sp)+,%d2
	clr.l %d0
	rts
.L764:
	move.l %a0,16(%sp)
	move.l %d1,12(%sp)
	move.l %d0,8(%sp)
	move.l (%sp)+,%d2
	jra (sg_generate.part.0)
	.size	sg_generate, .-sg_generate
	.align	2
	.globl	sg_invert
	.type	sg_invert, @function
sg_invert:
	lea (-32,%sp),%sp
	mov3q.l #6,%d0
	movem.l #15420,(%sp)
	move.l 40(%sp),%a4
	move.l 36(%sp),%a2
	mvz.b 12(%a4),%d4
	move.l %d4,%d5
	cmp.l %d4,%d0
	jcc .L766
	add.l #-12,%d5
.L766:
	move.b 512(%a2),%d3
	jeq .L765
	add.l %d5,%d5
	mvz.b %d3,%d3
	clr.l %d2
	lea sg_fit,%a5
.L769:
	move.l %d2,%d0
	lsl.l #3,%d0
	lea 4(%a2,%d0.l),%a3
	tst.b (%a2,%d0.l)
	jeq .L768
	mvs.b (%a3),%d0
	moveq #-128,%d1
	cmp.l %d0,%d1
	jeq .L768
	mvz.b 13(%a4),%d1
	move.l %d1,-(%sp)
	move.l %d4,-(%sp)
	move.l %d5,%d1
	sub.l %d0,%d1
	move.l %d1,-(%sp)
	jsr (%a5)
	lea (12,%sp),%sp
	move.b %d0,(%a3)
.L768:
	addq.l #1,%d2
	cmp.l %d2,%d3
	jhi .L769
.L765:
	movem.l (%sp),#15420
	lea (32,%sp),%sp
	rts
	.size	sg_invert, .-sg_invert
	.align	2
	.globl	sg_double
	.type	sg_double, @function
sg_double:
	lea (-16,%sp),%sp
	movem.l #60,(%sp)
	move.l 20(%sp),%a0
	mvz.b 512(%a0),%d0
	move.l %d0,%a1
	lsr.l #1,%d0
	jeq .L779
	mvz.b %d0,%d3
	cmp.l %d0,%a1
	jls .L779
	move.l %d3,%d0
.L781:
	move.l %d0,%d1
	sub.l %d3,%d1
	lsl.l #3,%d1
	move.l %d0,%d2
	addq.l #1,%d0
	lsl.l #3,%d2
	move.l (%a0,%d1.l),%d4
	move.l 4(%a0,%d1.l),%d5
	move.l %d4,(%a0,%d2.l)
	move.l %d5,4(%a0,%d2.l)
	cmp.l %d0,%a1
	jhi .L781
.L779:
	movem.l (%sp),#60
	lea (16,%sp),%sp
	rts
	.size	sg_double, .-sg_double
	.align	2
	.globl	sg_fit_phrase
	.type	sg_fit_phrase, @function
sg_fit_phrase:
	lea (-24,%sp),%sp
	movem.l #15372,(%sp)
	move.l 28(%sp),%a2
	move.l 32(%sp),%a4
	move.b 512(%a2),%d3
	jeq .L788
	mvz.b %d3,%d3
	clr.l %d2
	lea sg_fit,%a5
.L791:
	move.l %d2,%d0
	lsl.l #3,%d0
	lea 4(%a2,%d0.l),%a3
	tst.b (%a2,%d0.l)
	jeq .L790
	mvs.b (%a3),%d0
	moveq #-128,%d1
	cmp.l %d0,%d1
	jeq .L790
	mvz.b 13(%a4),%d1
	move.l %d1,%a0
	mvz.b 12(%a4),%d1
	move.l %a0,-(%sp)
	move.l %d1,-(%sp)
	move.l %d0,-(%sp)
	jsr (%a5)
	lea (12,%sp),%sp
	move.b %d0,(%a3)
.L790:
	addq.l #1,%d2
	cmp.l %d2,%d3
	jhi .L791
.L788:
	movem.l (%sp),#15372
	lea (24,%sp),%sp
	rts
	.size	sg_fit_phrase, .-sg_fit_phrase
	.align	2
	.globl	sg_evolve
	.type	sg_evolve, @function
sg_evolve:
	move.l %d2,-(%sp)
	move.l 8(%sp),%a0
	move.l 12(%sp),%d1
	tst.l %a0
	jeq .L803
	tst.l %d1
	jeq .L803
	move.b 512(%a0),%d0
	moveq #63,%d2
	subq.l #1,%d0
	mvz.b %d0,%d0
	cmp.l %d0,%d2
	jcs .L803
	moveq #127,%d0
	cmp.l 16(%sp),%d0
	jcc .L810
.L803:
	move.l (%sp)+,%d2
	clr.l %d0
	rts
.L810:
	move.l %d1,12(%sp)
	move.l %a0,8(%sp)
	move.l (%sp)+,%d2
	jra (sg_evolve.part.0)
	.size	sg_evolve, .-sg_evolve
	.align	2
	.globl	sg_read_phrase
	.type	sg_read_phrase, @function
sg_read_phrase:
	move.l %d2,-(%sp)
	move.l 8(%sp),%d0
	move.l 12(%sp),%d1
	tst.l %d0
	jeq .L813
	tst.l %d1
	jeq .L813
	mvz.w #2329,%d2
	cmp.l 16(%sp),%d2
	jcc .L813
	move.l 20(%sp),%a0
	moveq #63,%d2
	subq.l #1,%a0
	cmp.l %a0,%d2
	jcs .L813
	move.l 20(%sp),16(%sp)
	move.l %d1,12(%sp)
	move.l %d0,8(%sp)
	move.l (%sp)+,%d2
	jra (sg_read_phrase.part.0)
.L813:
	move.l (%sp)+,%d2
	clr.l %d0
	rts
	.size	sg_read_phrase, .-sg_read_phrase
	.align	2
	.globl	sg_rotate_record
	.type	sg_rotate_record, @function
sg_rotate_record:
	lea (-96,%sp),%sp
	move.l 100(%sp),%a0
	movem.l #31996,(%sp)
	tst.l %a0
	jeq .L821
	mvz.w #2329,%d0
	cmp.l 104(%sp),%d0
	jcc .L821
	move.l 108(%sp),%d0
	moveq #62,%d1
	subq.l #2,%d0
	cmp.l %d0,%d1
	jcs .L821
	mov3q.l #1,%d2
	cmp.l 112(%sp),%d2
	jeq .L824
	mov3q.l #-1,%d3
	cmp.l 112(%sp),%d3
	jne .L821
	mvz.w #2203,%d2
	mvz.w #2202,%d3
	move.w #89,%a2
	mov3q.l #7,%a3
	clr.l %d4
	moveq #10,%d0
	sub.l %a1,%a1
	add.l %a0,%a3
.L826:
	mvz.w %a1,%d1
	mov3q.l #1,%d5
	subq.l #1,%d0
	lsl.l #3,%d1
	mvz.b (%a3,%d1.l),%d1
	asr.l %d4,%d1
	and.l %d5,%d1
	move.b %d1,52(%sp,%a1.l)
	addq.l #1,%a1
	tst.l %d0
	jne .L826
	moveq #32,%d1
.L827:
	lea (%a0,%d0.l),%a1
	subq.l #1,%d1
	add.l %a2,%a1
	move.b (%a1),62(%sp,%d0.l)
	addq.l #1,%d0
	tst.l %d1
	jne .L827
	move.b (%a0,%d3.l),%d3
	move.b (%a0,%d2.l),%d2
	mov3q.l #1,%a5
	sub.l %a4,%a4
	mov3q.l #1,%d0
	move.b %d3,50(%sp)
	move.b %d2,51(%sp)
	cmp.l 112(%sp),%d0
	jeq .L861
.L841:
	mov3q.l #7,%d1
	move.l %a4,%d3
	move.l %a4,%d4
	lsr.l #3,%d4
	and.l %d1,%d3
	move.l %a5,%d5
	mov3q.l #7,%d2
	and.l %d5,%d2
	mov3q.l #7,%a3
	sub.l %d4,%a3
	move.l %d5,%d4
	lsr.l #3,%d4
	mov3q.l #7,%a2
	mov3q.l #1,%d6
	clr.l %d1
	sub.l %d4,%a2
	mov3q.l #1,%d4
	lsl.l %d3,%d4
	lsl.l %d2,%d6
	moveq #10,%d0
	move.l %d5,46(%sp)
	move.l %d4,%d7
	move.l %d4,%d3
	not.l %d7
.L832:
	mvz.w %d1,%d2
	moveq #8,%d5
	cmp.l %d1,%d5
	jeq .L829
	lsl.l #3,%d2
	lea (%a0,%d2.l),%a1
	mvz.b (%a1,%a2.l),%d5
	lea (%a3,%d2.l),%a1
	add.l %a0,%a1
	move.b (%a1),%d4
	and.l %d6,%d5
	move.l %d7,%d2
	and.l %d4,%d2
	tst.l %d5
	jeq .L831
	move.l %d3,%d2
	or.l %d4,%d2
.L831:
	move.b %d2,(%a1)
.L829:
	addq.l #1,%d1
	subq.l #1,%d0
	tst.l %d0
	jne .L832
	move.l 46(%sp),%d5
	move.l %d5,%d2
	lsl.l #5,%d2
	move.l %a4,%d1
	lsl.l #5,%d1
	move.l %d2,%a2
	lea (89,%a2),%a2
	move.l %d1,%a3
	moveq #32,%d1
.L833:
	lea (%a0,%d0.l),%a1
	subq.l #1,%d1
	lea (%a1,%a2.l),%a6
	addq.l #1,%d0
	move.b (%a6),89(%a3,%a1.l)
	tst.l %d1
	jne .L833
	add.l #1101,%d5
	mvz.w %d5,%d5
	move.l %a4,%d0
	add.l #1101,%d0
	mvz.w %d0,%d0
	lea (1,%a5),%a1
	add.l %d5,%d5
	move.l %a5,%a4
	lea (%a0,%d5.l),%a2
	move.b (%a2),(%a0,%d0.l*2)
	lea 1(%a0,%d5.l),%a3
	move.b (%a3),1(%a0,%d0.l*2)
	cmp.l 108(%sp),%a1
	jcc .L862
	move.l %a1,%a5
	mov3q.l #1,%d0
	cmp.l 112(%sp),%d0
	jne .L841
.L861:
	move.l 108(%sp),%d5
	sub.l %a4,%d5
	move.l %d5,%a4
	subq.l #1,%a4
	mov3q.l #7,%d1
	move.l %a4,%d3
	move.l %a4,%d4
	lsr.l #3,%d4
	and.l %d1,%d3
	mov3q.l #7,%a3
	subq.l #2,%d5
	sub.l %d4,%a3
	move.l %d5,%d4
	lsr.l #3,%d4
	mov3q.l #7,%a2
	mov3q.l #7,%d2
	and.l %d5,%d2
	sub.l %d4,%a2
	mov3q.l #1,%d4
	lsl.l %d3,%d4
	mov3q.l #1,%d6
	clr.l %d1
	moveq #10,%d0
	move.l %d5,46(%sp)
	lsl.l %d2,%d6
	move.l %d4,%d7
	move.l %d4,%d3
	not.l %d7
	jra .L832
.L821:
	movem.l (%sp),#31996
	clr.l %d0
	lea (96,%sp),%sp
	rts
.L824:
	move.l 108(%sp),%d4
	subq.l #1,%d4
	mvz.w %d4,%d0
	move.l %d4,%d1
	lsr.l #3,%d1
	move.l 108(%sp),%d3
	add.l #1100,%d3
	mvz.w %d3,%d3
	move.l %d0,%d2
	mov3q.l #7,%a3
	lsl.l #5,%d0
	add.l %d2,%d2
	mov3q.l #7,%d5
	sub.l %d1,%a3
	and.l %d5,%d4
	add.l %d3,%d3
	sub.l %a1,%a1
	add.l %a0,%a3
	move.l %d0,%a2
	moveq #10,%d0
	add.l #2203,%d2
	lea (89,%a2),%a2
	jra .L826
.L862:
	mov3q.l #1,%d0
	cmp.l 112(%sp),%d0
	jeq .L843
	move.l 108(%sp),%d0
	mov3q.l #7,%d7
	subq.l #1,%d0
	and.l %d0,%d7
	mvz.w %d0,%d2
	move.l 108(%sp),%d3
	add.l #1100,%d3
	mvz.w %d3,%d3
	mov3q.l #1,%d6
	move.l %d2,%d5
	mov3q.l #7,%d4
	lsl.l #5,%d2
	add.l %d5,%d5
	add.l %d3,%d3
	lsl.l %d7,%d6
	move.l %d2,%a2
	move.l %d0,%d2
	lsr.l #3,%d2
	add.l #2203,%d5
	lea (89,%a2),%a2
	moveq #10,%d0
	move.l %d6,%d7
	move.l %d3,%a3
	sub.l %d2,%d4
	not.l %d7
.L839:
	mvz.w %d1,%d2
	moveq #8,%d3
	cmp.l %d1,%d3
	jeq .L836
	lsl.l #3,%d2
	move.l %d4,%a1
	add.l %d2,%a1
	add.l %a0,%a1
	move.b (%a1),%d2
	tst.b 52(%sp,%d1.l)
	jeq .L837
	or.l %d6,%d2
	move.b %d2,(%a1)
.L836:
	addq.l #1,%d1
	subq.l #1,%d0
	tst.l %d0
	jne .L839
	move.l %a3,%d3
	moveq #32,%d1
.L840:
	lea 62(%sp,%d0.l),%a3
	lea (%a0,%d0.l),%a1
	subq.l #1,%d1
	addq.l #1,%d0
	move.b (%a3),(%a1,%a2.l)
	tst.l %d1
	jne .L840
	move.b 50(%sp),%d0
	move.b 51(%sp),%d1
	move.b %d0,(%a0,%d3.l)
	move.b %d1,(%a0,%d5.l)
	mov3q.l #1,%d0
	movem.l (%sp),#31996
	lea (96,%sp),%sp
	rts
.L837:
	and.l %d7,%d2
	move.b %d2,(%a1)
	jra .L836
.L843:
	clr.l %d0
	mov3q.l #7,%d7
	and.l %d0,%d7
	mov3q.l #1,%d6
	move.l %d0,%d2
	lsr.l #3,%d2
	mvz.w #2202,%d3
	mov3q.l #7,%d4
	mvz.w #2203,%d5
	move.w #89,%a2
	moveq #10,%d0
	sub.l %d2,%d4
	move.l %d3,%a3
	lsl.l %d7,%d6
	move.l %d6,%d7
	not.l %d7
	jra .L839
	.size	sg_rotate_record, .-sg_rotate_record
	.align	2
	.globl	sg_fit_record
	.type	sg_fit_record, @function
sg_fit_record:
	move.l 4(%sp),%d0
	tst.l %d0
	jeq .L865
	mvz.w #2329,%d1
	cmp.l 8(%sp),%d1
	jcc .L865
	tst.l 12(%sp)
	jeq .L865
	move.l 12(%sp),8(%sp)
	move.l %d0,4(%sp)
	jra (sg_fit_record.part.0)
.L865:
	clr.l %d0
	rts
	.size	sg_fit_record, .-sg_fit_record
	.align	2
	.globl	sg_chance_code
	.type	sg_chance_code, @function
sg_chance_code:
	lea (-16,%sp),%sp
	moveq #98,%d1
	movem.l #1052,(%sp)
	move.l 20(%sp),%d2
	move.l %d2,%d0
	subq.l #1,%d0
	cmp.l %d0,%d1
	jcs .L878
	mvz.w #1000,%d3
	move.w #21,%a0
	clr.l %d4
	clr.l %d1
	lea stock_pct,%a2
.L877:
	mvz.b (%a2,%d1.l),%d0
	cmp.l %d2,%d0
	jls .L874
	move.l %d0,%a1
	sub.l %d2,%a1
.L875:
	subq.l #1,%a0
	cmp.l %d3,%a1
	jcc .L876
	move.l %d1,%d4
	move.l %a1,%d3
.L876:
	addq.l #1,%d1
	tst.l %a0
	jne .L877
	move.l %d4,%d0
	add.l #9,%d0
	movem.l (%sp),#1052
	lea (16,%sp),%sp
	rts
.L874:
	move.l %d2,%a1
	sub.l %d0,%a1
	jra .L875
.L878:
	movem.l (%sp),#1052
	clr.l %d0
	lea (16,%sp),%sp
	rts
	.size	sg_chance_code, .-sg_chance_code
	.align	2
	.globl	sg_trig_word
	.type	sg_trig_word, @function
sg_trig_word:
	lea (-20,%sp),%sp
	moveq #23,%d1
	move.l 28(%sp),%d0
	movem.l #1084,(%sp)
	move.l 24(%sp),%d2
	cmp.l %d0,%d1
	jge .L883
	moveq #23,%d0
.L884:
	moveq #63,%d1
	moveq #98,%d3
	and.l %d1,%d0
	move.l %d2,%d1
	subq.l #1,%d1
	move.l %d0,%d5
	lsl.l #7,%d5
	move.w %d5,%d0
	cmp.l %d1,%d3
	jcs .L882
	mvz.w #1000,%d3
	move.w #21,%a0
	clr.l %d4
	clr.l %d1
	lea stock_pct,%a2
.L889:
	mvz.b (%a2,%d1.l),%d0
	cmp.l %d0,%d2
	jcc .L886
	move.l %d0,%a1
	sub.l %d2,%a1
.L887:
	subq.l #1,%a0
	cmp.l %d3,%a1
	jcc .L888
	move.l %d1,%d4
	move.l %a1,%d3
.L888:
	addq.l #1,%d1
	tst.l %a0
	jne .L889
	move.l %d4,%d0
	add.l #9,%d0
	or.l %d5,%d0
.L882:
	movem.l (%sp),#1084
	lea (20,%sp),%sp
	rts
.L886:
	move.l %d2,%a1
	sub.l %d0,%a1
	jra .L887
.L883:
	moveq #-23,%d3
	cmp.l %d0,%d3
	jle .L884
	moveq #-23,%d0
	jra .L884
	.size	sg_trig_word, .-sg_trig_word
	.align	2
	.globl	sg_write_phrase
	.type	sg_write_phrase, @function
sg_write_phrase:
	lea (-48,%sp),%sp
	movem.l #15372,(%sp)
	move.l 60(%sp),%a2
	tst.l 52(%sp)
	jeq .L894
	mvz.w #2329,%d0
	cmp.l 56(%sp),%d0
	jcc .L894
	tst.l %a2
	jeq .L894
	move.b 512(%a2),%d2
	moveq #63,%d1
	move.l %d2,%d0
	subq.l #1,%d0
	mvz.b %d0,%d0
	cmp.l %d0,%d1
	jcs .L894
	mvz.b %d2,%d2
	clr.l %d1
.L898:
	mvz.w %d1,%d0
	move.l %d1,%d3
	addq.l #1,%d1
	lsl.l #3,%d3
	lsl.l #3,%d0
	lea (%a2,%d3.l),%a3
	mov3q.l #1,%d3
	lea (%a2,%d0.l),%a1
	mvz.b (%a1),%d0
	cmp.l %d0,%d3
	jcs .L894
	mvz.b 1(%a1),%d0
	cmp.l %d0,%d3
	jcs .L894
	mvz.b 7(%a3),%d0
	mov3q.l #4,%d3
	cmp.l %d0,%d3
	jcs .L894
	mvz.b 5(%a3),%d0
	moveq #100,%d3
	cmp.l %d0,%d3
	jcs .L894
	move.b 6(%a3),%d0
	moveq #46,%d3
	add.l #23,%d0
	mvz.b %d0,%d0
	cmp.l %d0,%d3
	jcs .L894
	move.b 4(%a3),%d0
	move.l %d0,%a0
	lea (12,%a0),%a0
	move.w %a0,%d3
	mvs.b %d0,%d0
	mvz.b %d3,%d3
	move.l %d3,%a0
	moveq #-128,%d3
	cmp.l %d0,%d3
	jeq .L897
	moveq #24,%d0
	cmp.l %a0,%d0
	jcs .L894
.L897:
	move.b 2(%a3),%d0
	moveq #126,%d3
	add.l #-128,%d0
	mvz.b %d0,%d0
	cmp.l %d0,%d3
	jcc .L894
	move.b 3(%a3),%d0
	add.l #-128,%d0
	mvz.b %d0,%d0
	cmp.l %d0,%d3
	jcc .L894
	cmp.l %d1,%d2
	jhi .L898
	clr.l 32(%sp)
.L915:
	move.l 32(%sp),%d1
	lsr.l #3,%d1
	mvz.w 34(%sp),%d2
	mov3q.l #7,%d0
	mov3q.l #7,%a0
	and.l 32(%sp),%d0
	move.l %d1,44(%sp)
	sub.l 44(%sp),%a0
	move.l %d2,%d3
	move.l %d2,%d1
	lsl.l #5,%d3
	add.l 52(%sp),%a0
	lsl.l #3,%d1
	move.l 52(%sp),%a3
	move.l %d0,36(%sp)
	mvz.b (%a0),%d0
	move.l %d3,%a1
	move.l 36(%sp),%d3
	asr.l %d3,%d0
	lea 89(%a3,%a1.l),%a1
	lea (%a2,%d1.l),%a3
	mov3q.l #1,%d1
	and.l %d1,%d0
	tst.b (%a3)
	jeq .L899
	move.l 32(%sp),%d1
	lsl.l #3,%d1
	move.b 4(%a2,%d1.l),%d1
	mvs.b %d1,%d3
	move.l %d3,40(%sp)
	moveq #-128,%d3
	cmp.l 40(%sp),%d3
	jeq .L899
	muls.w #5,%d1
	add.l #64,%d1
.L901:
	move.b %d1,(%a1)
	tst.b (%a3)
	jeq .L916
	move.l 32(%sp),%d1
	lsl.l #3,%d1
	move.b 2(%a2,%d1.l),%d1
.L902:
	move.b %d1,13(%a1)
	tst.b (%a3)
	jeq .L917
	move.l 32(%sp),%d1
	lsl.l #3,%d1
	move.b 3(%a2,%d1.l),%d1
.L903:
	move.l 36(%sp),%d3
	move.b %d1,15(%a1)
	mov3q.l #1,%d1
	lsl.l %d3,%d1
	move.l %d1,40(%sp)
	tst.b (%a3)
	jeq .L904
	move.l 32(%sp),%d1
	lsl.l #3,%d1
	lea 7(%a2,%d1.l),%a4
	move.b (%a4),%d1
	move.l %a4,36(%sp)
	tst.b %d1
	jeq .L905
	subq.l #1,%d1
	move.b %d1,4(%a1)
	lea (rtim.0),%a5
	mvz.b (%a4),%d1
	lea (%a5,%d1.l),%a4
	move.b (%a4),5(%a1)
	tst.b (%a3)
	jeq .L904
.L905:
	move.b (%a0),%d1
	or.l 40(%sp),%d1
.L906:
	move.b %d1,(%a0)
	move.w #79,%a0
	sub.l 44(%sp),%a0
	add.l 52(%sp),%a0
	move.b (%a0),%d1
	tst.b (%a3)
	jeq .L907
	tst.b 1(%a3)
	jeq .L907
	or.l 40(%sp),%d1
.L908:
	move.b %d1,(%a0)
	move.b (%a3),%d1
	mvz.b %d1,%d3
	cmp.l %d3,%d0
	jeq .L909
	move.l 52(%sp),%a0
	moveq #15,%d1
	sub.l 44(%sp),%d1
	move.l 40(%sp),%d0
	not.l %d0
	lea (%a0,%d2.l*2),%a0
	clr.b %d2
	add.l 52(%sp),%d1
	move.l %d1,%a5
	move.l %a0,%a4
	move.b %d2,2203(%a4)
	move.b %d2,2202(%a4)
	move.w #31,%a0
	sub.l 44(%sp),%a0
	add.l 52(%sp),%a0
	move.b (%a5),%d2
	and.l %d0,%d2
	move.b %d2,(%a5)
	move.b (%a0),%d1
	and.l %d1,%d0
	move.b %d0,(%a0)
	move.b (%a3),%d1
.L909:
	tst.b %d1
	jeq .L910
	move.l 32(%sp),%d0
	lsl.l #3,%d0
	lea (%a2,%d0.l),%a0
	move.b 5(%a0),%d0
	move.b 6(%a0),%d1
	move.l %d0,%d2
	or.l %d1,%d2
	tst.b %d2
	jeq .L910
	move.l 32(%sp),%a0
	mvs.b %d1,%d1
	mvz.b %d0,%d0
	lea (1101,%a0),%a0
	mvz.w %a0,%d2
	move.l %d1,-(%sp)
	move.l 56(%sp),%a4
	move.l %d0,-(%sp)
	move.l %a1,32(%sp)
	lea (%a4,%d2.l*2),%a0
	move.l %a0,36(%sp)
	jsr sg_trig_word
	addq.l #8,%sp
	move.l 28(%sp),%a0
	mvz.b (%a0),%d1
	lsl.l #8,%d1
	and.l #-8192,%d1
	or.l %d1,%d0
	move.l %d0,%d1
	lsr.l #8,%d1
	move.b %d1,(%a0)
	move.b %d0,1(%a4,%d2.l*2)
	move.l 24(%sp),%a1
.L910:
	move.w #32,%a0
	clr.l %d1
	clr.l %d2
.L911:
	move.b (%a1,%d1.l),%d0
	addq.l #1,%d1
	subq.l #1,%a0
	not.l %d0
	tst.b %d0
	sne %d0
	mvs.b %d0,%d0
	neg.l %d0
	or.l %d0,%d2
	tst.l %a0
	jne .L911
	move.w #23,%a0
	sub.l 44(%sp),%a0
	add.l 52(%sp),%a0
	move.b (%a0),%d0
	tst.b (%a3)
	jne .L912
	tst.l %d2
	jeq .L912
	or.l 40(%sp),%d0
.L914:
	move.b %d0,(%a0)
	addq.l #1,32(%sp)
	mvz.b 512(%a2),%d0
	cmp.l 32(%sp),%d0
	jhi .L915
	movem.l (%sp),#15372
	mov3q.l #1,%d0
	lea (48,%sp),%sp
	rts
.L894:
	movem.l (%sp),#15372
	clr.l %d0
	lea (48,%sp),%sp
	rts
.L912:
	move.l 40(%sp),%d1
	not.l %d1
	and.l %d1,%d0
	jra .L914
.L907:
	move.l 40(%sp),%d3
	not.l %d3
	and.l %d3,%d1
	jra .L908
.L899:
	st %d1
	jra .L901
.L916:
	st %d1
	jra .L902
.L904:
	move.b (%a0),39(%sp)
	move.l 40(%sp),%d1
	not.l %d1
	move.b 39(%sp),%d3
	and.l %d3,%d1
	jra .L906
.L917:
	st %d1
	jra .L903
	.size	sg_write_phrase, .-sg_write_phrase
	.align	2
	.type	commit.part.0, @function
commit.part.0:
	lea (-64,%sp),%sp
	moveq #15,%d0
	movem.l #3324,(%sp)
	move.b 269161680,%d2
	mvz.b %d2,%d3
	cmp.l %d3,%d0
	jcs .L963
	move.l 1187521622,%d1
	ext.w %d2
	clr.l %d0
	lea staging,%a1
	move.l %d1,48(%sp)
	move.b 269161679,%d4
	mulu.w #36568,%d2
	mvz.w #2330,%d1
	move.l 48(%sp),%a0
	move.b %d4,63(%sp)
	move.w 70(%sp),%d4
	mulu.w #2330,%d4
	add.l %d2,%d4
	add.l 48(%sp),%d2
	move.l %d4,52(%sp)
	add.l %d4,%a0
.L943:
	lea (%a0,%d0.l),%a2
	subq.l #1,%d1
	move.b (%a2),(%a1,%d0.l)
	addq.l #1,%d0
	tst.l %d1
	jne .L943
	mvz.w #36437,%d0
	move.l %d2,%a3
	tst.b (%a3,%d0.l)
	jeq .L944
	move.b staging+80,%d2
.L945:
	move.l 1187521622,%d5
	mov3q.l #3,%d6
	move.b 269161679,%d0
	move.w 70(%sp),%d4
	mvz.w #6322,%d7
	mvz.b %d2,%d2
	add.l #585088,%d5
	move.l %d2,%a3
	subq.l #1,%a3
	and.l %d6,%d0
	mulu.w #24,%d4
	add.l #291,%d4
	muls.l %d7,%d0
	add.l %d5,%d0
	move.l %d0,%a2
	move.b (%a2,%d4.l),%d0
	moveq #63,%d4
	cmp.l %a3,%d4
	jcs .L941
	mvz.b %d0,%d5
	tst.b %d0
	jlt .L941
	mov3q.l #2,%d6
	cmp.l 72(%sp),%d6
	jeq .L948
	mvz.w 70(%sp),%d4
	mov3q.l #3,%d7
	lsl.l #4,%d4
	add.l #params,%d4
	cmp.l 72(%sp),%d7
	jeq .L949
	tst.l 72(%sp)
	jne .L950
	move.l %d5,-(%sp)
	move.l %d2,-(%sp)
	move.l %d4,-(%sp)
	pea phrase
	move.l %d1,52(%sp)
	move.l %a0,56(%sp)
	move.l %a1,48(%sp)
	jsr (sg_generate.part.0)
	pea phrase
	pea 2330.w
	pea staging
	jsr sg_write_phrase
	lea (28,%sp),%sp
	move.l 36(%sp),%d1
	move.l 40(%sp),%a0
	move.l 32(%sp),%a1
	tst.l %d0
	jeq .L963
.L951:
	move.l 48(%sp),%d2
	cmp.l 1187521622.l,%d2
	jne .L941
	mvz.b 269161680,%d0
	cmp.l %d3,%d0
	jne .L941
	mvz.b 63(%sp),%d4
	mvz.b 269161679,%d0
	cmp.l %d4,%d0
	jne .L941
	mvz.w #2330,%d2
	clr.l %d0
.L959:
	mvz.b (%a0,%d0.l),%d5
	mvz.b (%a1,%d0.l),%d3
	subq.l #1,%d2
	addq.l #1,%d0
	cmp.l %d5,%d3
	jne .L958
	tst.l %d2
	jne .L959
	mov3q.l #2,%d1
.L941:
	movem.l (%sp),#3324
	move.l %d1,%d0
	lea (64,%sp),%sp
	rts
.L944:
	mvz.w #36435,%d0
	move.b (%a3,%d0.l),%d2
	jra .L945
.L963:
	movem.l (%sp),#3324
	clr.l %d1
	move.l %d1,%d0
	lea (64,%sp),%sp
	rts
.L949:
	move.l %d4,-(%sp)
	pea staging
	move.l %d1,44(%sp)
	move.l %a0,48(%sp)
	move.l %a1,40(%sp)
	jsr (sg_fit_record.part.0)
	addq.l #8,%sp
	move.l 36(%sp),%d1
	move.l 40(%sp),%a0
	move.l 32(%sp),%a1
	jra .L951
.L948:
	move.l 76(%sp),-(%sp)
	move.l %d2,-(%sp)
	pea 2330.w
	pea staging
	move.l %d1,52(%sp)
	move.l %a0,56(%sp)
	move.l %a1,48(%sp)
	jsr sg_rotate_record
	lea (16,%sp),%sp
	move.l 36(%sp),%d1
	move.l 40(%sp),%a0
	move.l 32(%sp),%a1
	tst.l %d0
	jne .L951
	movem.l (%sp),#3324
	move.l %d1,%d0
	lea (64,%sp),%sp
	rts
.L950:
	move.l %d2,-(%sp)
	pea staging
	pea phrase
	move.l %d1,48(%sp)
	move.l %a0,52(%sp)
	move.l %a1,44(%sp)
	jsr (sg_read_phrase.part.0)
	lea (12,%sp),%sp
	mov3q.l #1,%d0
	move.l 36(%sp),%d1
	move.l 40(%sp),%a0
	move.l 32(%sp),%a1
	cmp.l 72(%sp),%d0
	jeq .L983
	mov3q.l #4,%d0
	cmp.l 72(%sp),%d0
	jeq .L954
	mov3q.l #5,%d2
	cmp.l 72(%sp),%d2
	jeq .L984
	mvz.b phrase+512,%d2
	move.l %d2,%d0
	lsr.l #1,%d0
	jeq .L953
	mvz.b %d0,%d5
	cmp.l %d2,%d0
	jcc .L953
	move.l %d5,%d0
.L957:
	move.l %d0,%d6
	move.l %d0,%d4
	lsl.l #3,%d6
	sub.l %d5,%d4
	lsl.l #3,%d4
	lea phrase,%a2
	addq.l #1,%d0
	move.l %d6,44(%sp)
	move.l 44(%sp),%a3
	move.l (%a2,%d4.l),%d6
	move.l 4(%a2,%d4.l),%d7
	move.l %d6,(%a2,%a3.l)
	move.l %d7,4(%a2,%a3.l)
	cmp.l %d2,%d0
	jcs .L957
.L953:
	pea phrase
	pea 2330.w
	pea staging
	move.l %d1,48(%sp)
	move.l %a0,52(%sp)
	move.l %a1,44(%sp)
	jsr sg_write_phrase
	lea (12,%sp),%sp
	move.l 36(%sp),%d1
	move.l 40(%sp),%a0
	move.l 32(%sp),%a1
	tst.l %d0
	jne .L951
.L982:
	movem.l (%sp),#3324
	move.l %d1,%d0
	lea (64,%sp),%sp
	rts
.L954:
	move.l 76(%sp),-(%sp)
	move.l %d4,-(%sp)
	pea phrase
	move.l %d1,48(%sp)
	move.l %a0,52(%sp)
	move.l %a1,44(%sp)
	jsr sg_transpose
	lea (12,%sp),%sp
	move.l 36(%sp),%d1
	move.l 40(%sp),%a0
	move.l 32(%sp),%a1
	pea phrase
	pea 2330.w
	pea staging
	move.l %d1,48(%sp)
	move.l %a0,52(%sp)
	move.l %a1,44(%sp)
	jsr sg_write_phrase
	lea (12,%sp),%sp
	move.l 36(%sp),%d1
	move.l 40(%sp),%a0
	move.l 32(%sp),%a1
	tst.l %d0
	jne .L951
	jra .L982
.L958:
	mvz.w #2330,%d0
.L960:
	lea (%a0,%d1.l),%a3
	subq.l #1,%d0
	lea undo_rec,%a2
	move.b (%a3),(%a2,%d1.l)
	addq.l #1,%d1
	tst.l %d0
	jne .L960
	move.l 48(%sp),%a3
	move.l 52(%sp),%d2
	move.l 68(%sp),%d6
	mvz.w #2330,%d1
	move.l 52(%sp),%a2
	add.l #268525902,%a2
	move.l %a2,44(%sp)
	mov3q.l #1,undo_valid
	move.l %a3,undo_bank
	move.l %d2,undo_off
	move.l %d6,undo_track
	move.l %d4,undo_part
.L962:
	move.l %a0,%d2
	add.l %d0,%d2
	move.l %d2,%a2
	subq.l #1,%d1
	move.b (%a1,%d0.l),%d3
	mvz.b (%a2),%d5
	mvz.b %d3,%d4
	cmp.l %d5,%d4
	jeq .L961
	move.b %d3,(%a2)
	move.l 44(%sp),%a3
	lea (%a1,%d0.l),%a2
	move.b (%a2),(%a3,%d0.l)
.L961:
	addq.l #1,%d0
	tst.l %d1
	jne .L962
	move.b 63(%sp),%d2
	mov3q.l #3,%d0
	move.l 1187521622,%a0
	add.l #610376,%a0
	move.b (%a0),%d1
	and.l %d0,%d2
	mov3q.l #1,%d0
	lsl.l %d2,%d0
	or.l %d0,%d1
	move.b %d1,(%a0)
	move.b 269161566,%d1
	or.l %d1,%d0
	move.b %d0,269161566
	move.l 1187521622,%a0
	add.l #635698,%a0
	mov3q.l #1,(%a0)
	mov3q.l #1,269452696
	jsr 1073905152
	jsr 1073953240
	move.l 68(%sp),-(%sp)
	jsr 1074387488
	addq.l #4,%sp
	movem.l (%sp),#3324
	mov3q.l #1,1187497772
	mov3q.l #1,%d1
	move.l %d1,%d0
	lea (64,%sp),%sp
	rts
.L984:
	move.l %d4,-(%sp)
	pea phrase
	move.l %d1,44(%sp)
	move.l %a0,48(%sp)
	move.l %a1,40(%sp)
	jsr sg_invert
	addq.l #8,%sp
	move.l 36(%sp),%d1
	move.l 40(%sp),%a0
	move.l 32(%sp),%a1
	pea phrase
	pea 2330.w
	pea staging
	move.l %d1,48(%sp)
	move.l %a0,52(%sp)
	move.l %a1,44(%sp)
	jsr sg_write_phrase
	lea (12,%sp),%sp
	move.l 36(%sp),%d1
	move.l 40(%sp),%a0
	move.l 32(%sp),%a1
	tst.l %d0
	jne .L951
	jra .L982
.L983:
	move.l 68(%sp),%a3
	moveq #127,%d6
	lea evo_seed,%a2
	moveq #63,%d7
	move.l 76(%sp),%d0
	addq.l #1,%d0
	add.l (%a2,%a3.l*4),%d0
	move.b phrase+512,%d2
	and.l %d6,%d0
	subq.l #1,%d2
	mvz.b %d2,%d2
	move.l %d0,(%a2,%a3.l*4)
	cmp.l %d2,%d7
	jcs .L941
	move.l %d0,-(%sp)
	move.l %d5,-(%sp)
	move.l %d4,-(%sp)
	pea phrase
	move.l %d1,52(%sp)
	move.l %a0,56(%sp)
	move.l %a1,48(%sp)
	jsr (sg_evolve.part.0)
	lea (16,%sp),%sp
	move.l 36(%sp),%d1
	move.l 40(%sp),%a0
	move.l 32(%sp),%a1
	pea phrase
	pea 2330.w
	pea staging
	move.l %d1,48(%sp)
	move.l %a0,52(%sp)
	move.l %a1,44(%sp)
	jsr sg_write_phrase
	lea (12,%sp),%sp
	move.l 36(%sp),%d1
	move.l 40(%sp),%a0
	move.l 32(%sp),%a1
	tst.l %d0
	jne .L951
	jra .L982
	.size	commit.part.0, .-commit.part.0
	.section	.rodata.str1.1
.LC8:
	.string	"SEQGEN: AUDIO TRACKS ONLY"
	.text
	.align	2
	.globl	seqgen_open
	.type	seqgen_open, @function
seqgen_open:
	subq.l #4,%sp
	move.l %d2,-(%sp)
	tst.l win
	jne .L985
	move.l -2147483630,%d1
	tst.l %d1
	jne .L987
	mvz.b 269161676,%d0
	mov3q.l #7,%d2
	cmp.l %d0,%d2
	jcs .L987
	tst.l params_ready
	jne .L988
	move.l %d1,4(%sp)
	jsr (ensure_params.part.0)
	move.l 4(%sp),%d1
.L988:
	pea seqgen_close
	mov3q.l #2,-(%sp)
	clr.l -(%sp)
	mov3q.l #-1,-(%sp)
	pea 64.w
	pea 118.w
	move.l %d1,28(%sp)
	jsr 1074102940
	lea (24,%sp),%sp
	move.l %d0,win
	move.l 4(%sp),%d1
	tst.l %d0
	jeq .L985
	pea seqgen_layer
	move.l %d1,8(%sp)
	clr.l seqgen_layer
	jsr 1073943700
	addq.l #4,%sp
	clr.l page
	clr.l status
	clr.l close_pending
	move.l 4(%sp),%d1
	lea mine,%a0
.L990:
	clr.l (%a0)+
	moveq #16,%d0
	addq.l #1,%d1
	cmp.l %d1,%d0
	jne .L990
	tst.l win
	jeq .L985
	move.l (%sp)+,%d2
	addq.l #4,%sp
	jra (draw.part.0)
.L987:
	pea 48.w
	pea .LC8
	jsr 1074111160
	addq.l #8,%sp
.L985:
	move.l (%sp)+,%d2
	addq.l #4,%sp
	rts
	.size	seqgen_open, .-seqgen_open
	.section	.rodata.str1.1
.LC9:
	.string	"ROTATED >"
.LC10:
	.string	"ROTATED <"
.LC11:
	.string	"NO CHANGE"
.LC12:
	.string	"NOT POSSIBLE"
.LC13:
	.string	"GENERATED"
.LC14:
	.string	"EVOLVED"
.LC15:
	.string	"UNDONE"
.LC16:
	.string	"NOTHING TO UNDO"
	.text
	.align	2
	.globl	seqgen_key
	.type	seqgen_key, @function
seqgen_key:
	lea (-36,%sp),%sp
	move.l 40(%sp),%d0
	movem.l #1036,(%sp)
	move.l 44(%sp),%d1
	moveq #63,%d2
	cmp.l %d0,%d2
	jcs .L998
	mov3q.l #1,%d3
	cmp.l %d1,%d3
	jne .L1048
	moveq #1,%d3
	lea mine,%a0
	move.b %d3,(%a0,%d0.l)
	tst.l win
	jeq .L998
	move.b 269161676,%d2
	move.b %d2,24(%sp)
	mov3q.l #1,%d2
	mvz.b 1175456541,%d3
	asr.l #5,%d3
	and.l %d2,%d3
	move.l %d3,%a0
	moveq #50,%d3
	cmp.l %d0,%d3
	jeq .L1049
	tst.l -2147483630
	jne .L998
	mvz.b 269161676,%d3
	mov3q.l #7,%d2
	cmp.l %d3,%d2
	jcs .L998
	mvz.b 24(%sp),%d3
	move.l %d3,24(%sp)
	tst.l params_ready
	jne .L1007
	move.l %d0,16(%sp)
	move.l %d1,12(%sp)
	move.l %a0,20(%sp)
	jsr (ensure_params.part.0)
	move.l 20(%sp),%a0
	move.l 12(%sp),%d1
	move.l 16(%sp),%d0
.L1007:
	moveq #52,%d2
	cmp.l %d0,%d2
	jeq .L1050
	moveq #33,%d3
	cmp.l %d0,%d3
	jeq .L1051
	moveq #49,%d3
	cmp.l %d0,%d3
	jeq .L1052
.L1015:
	tst.l win
	jeq .L998
.L1023:
	movem.l (%sp),#1036
	lea (36,%sp),%sp
	jra (draw.part.0)
.L1048:
	tst.l %d1
	jeq .L1053
.L998:
	movem.l (%sp),#1036
	lea (36,%sp),%sp
	rts
.L1053:
	lea mine,%a0
	tst.b (%a0,%d0.l)
	jeq .L998
	move.b %d1,(%a0,%d0.l)
	moveq #50,%d2
	cmp.l %d0,%d2
	jne .L998
	tst.l close_pending
	jeq .L998
	tst.l win
	jeq .L998
	pea win
	jsr 1074093492
	pea seqgen_layer
	jsr 1073943660
	addq.l #8,%sp
	movem.l (%sp),#1036
	clr.l close_pending
	mov3q.l #1,1187497772
	lea (36,%sp),%sp
	rts
.L1049:
	tst.l %a0
	jne .L1054
	movem.l (%sp),#1036
	mov3q.l #1,close_pending
	lea (36,%sp),%sp
	rts
.L1052:
	move.l page,%d0
	tst.l %d0
	jeq .L1055
	subq.l #1,%d0
	tst.l %d0
	jne .L1015
	move.l 1187521622,%d0
	add.l #-1073741824,%d0
	cmp.l #133169151,%d0
	jhi .L1044
	mov3q.l #7,%d3
	cmp.l 24(%sp),%d3
	jcs .L1044
	clr.l -(%sp)
	mov3q.l #1,-(%sp)
	move.l 32(%sp),-(%sp)
	jsr (commit.part.0)
	lea (12,%sp),%sp
	mov3q.l #1,%d1
	cmp.l %d0,%d1
	jne .L1056
	move.l #.LC14,%d0
	move.l %d0,status
.L1058:
	tst.l win
	jne .L1023
	jra .L998
.L1054:
	tst.l undo_valid
	jeq .L1003
	move.l 1187521622,%a1
	cmp.l undo_bank.l,%a1
	jne .L1003
	mvz.b 269161679,%d0
	move.l undo_part,%d1
	move.l %d1,32(%sp)
	cmp.l %d0,%d1
	jne .L1003
	mvz.b 269161680,%d0
	mvz.w #2330,%d2
	move.l undo_track,%d1
	mulu.w #36568,%d0
	muls.l %d2,%d1
	add.l %d0,%d1
	cmp.l undo_off.l,%d1
	jne .L1003
	move.l %d1,%a0
	add.l #268525902,%a0
	move.l %a0,28(%sp)
	add.l %d1,%a1
	move.l %d2,%d0
	clr.l %d1
	lea staging,%a0
.L1004:
	lea (%a1,%d1.l),%a2
	subq.l #1,%d0
	move.b (%a2),(%a0,%d1.l)
	addq.l #1,%d1
	tst.l %d0
	jne .L1004
	mvz.w #2330,%d1
	lea undo_rec,%a0
.L1005:
	move.b (%a0,%d0.l),%d2
	move.l 28(%sp),%a2
	subq.l #1,%d1
	move.b %d2,(%a1,%d0.l)
	move.b %d2,(%a2,%d0.l)
	addq.l #1,%d0
	tst.l %d1
	jne .L1005
	lea undo_rec,%a1
	lea staging,%a0
.L1006:
	move.l (%a0)+,(%a1)+
	addq.l #1,%d1
	cmp.l #582,%d1
	jne .L1006
	lea staging+2328,%a0
	mov3q.l #3,%d1
	move.w (%a0),undo_rec+2328
	move.l 1187521622,%a1
	add.l #610376,%a1
	and.l 32(%sp),%d1
	move.l #.LC15,%d2
	move.b (%a1),%d0
	move.w %d0,%a0
	mov3q.l #1,%d0
	lsl.l %d1,%d0
	move.l %a0,%d1
	or.l %d0,%d1
	move.b %d1,(%a1)
	move.b 269161566,%d1
	or.l %d1,%d0
	move.b %d0,269161566
	move.l 1187521622,%a0
	add.l #635698,%a0
	mov3q.l #1,(%a0)
	mov3q.l #1,269452696
	jsr 1073905152
	move.l undo_track,%d1
	move.l %d1,24(%sp)
	jsr 1073953240
	move.l 24(%sp),-(%sp)
	jsr 1074387488
	mov3q.l #1,1187497772
	move.l %d2,status
	addq.l #4,%sp
	tst.l win
	jne .L1023
	movem.l (%sp),#1036
	lea (36,%sp),%sp
	rts
.L1050:
	tst.l %a0
	jne .L1024
	mov3q.l #2,%d1
.L1010:
	add.l page,%d1
	mov3q.l #3,%d2
	clr.l status
	remu.l %d2,%d0:%d1
	move.l %d0,page
	tst.l win
	jne .L1023
	jra .L998
.L1003:
	move.l #.LC16,%d3
	move.l %d3,status
	movem.l (%sp),#1036
	lea (36,%sp),%sp
	jra (draw.part.0)
.L1051:
	tst.l %a0
	jeq .L1010
	move.l #.LC9,%d1
.L1009:
	move.l 1187521622,%d0
	add.l #-1073741824,%d0
	cmp.l #133169151,%d0
	jhi .L1042
	mov3q.l #7,%d0
	cmp.l 24(%sp),%d0
	jcs .L1042
	move.l %a0,-(%sp)
	mov3q.l #2,-(%sp)
	move.l 32(%sp),-(%sp)
	move.l %d1,24(%sp)
	jsr (commit.part.0)
	lea (12,%sp),%sp
	mov3q.l #1,%d2
	move.l 12(%sp),%d1
	cmp.l %d0,%d2
	jeq .L1013
	subq.l #2,%d0
	tst.l %d0
	jne .L1042
	move.l #.LC11,%d1
.L1013:
	move.l %d1,status
.L1057:
	tst.l win
	jne .L1023
	jra .L998
.L1042:
	move.l #.LC12,%d1
	move.l %d1,status
	jra .L1057
.L1024:
	mov3q.l #-1,%a0
	move.l #.LC10,%d1
	jra .L1009
.L1055:
	move.l 24(%sp),%d0
	moveq #127,%d1
	lsl.l #4,%d0
	move.l %d0,%a0
	add.l #params+5,%a0
	mvz.b (%a0),%d0
	addq.l #1,%d0
	and.l %d0,%d1
	move.l %d1,-(%sp)
	mov3q.l #5,-(%sp)
	move.l 32(%sp),%d0
	lsl.l #4,%d0
	add.l #params,%d0
	move.l %d0,-(%sp)
	jsr sg_set
	lea (12,%sp),%sp
	move.l 1187521622,%d0
	add.l #-1073741824,%d0
	cmp.l #133169151,%d0
	jhi .L1044
	mov3q.l #7,%d2
	cmp.l 24(%sp),%d2
	jcs .L1044
	clr.l -(%sp)
	clr.l -(%sp)
	move.l 32(%sp),-(%sp)
	jsr (commit.part.0)
	lea (12,%sp),%sp
	mov3q.l #1,%d3
	cmp.l %d0,%d3
	jeq .L1026
	subq.l #2,%d0
	tst.l %d0
	jne .L1044
.L1029:
	move.l #.LC11,%d0
	move.l %d0,status
	jra .L1058
.L1056:
	subq.l #2,%d0
	tst.l %d0
	jeq .L1029
.L1044:
	move.l #.LC12,%d0
	move.l %d0,status
	jra .L1058
.L1026:
	move.l #.LC13,%d0
	move.l %d0,status
	jra .L1058
	.size	seqgen_key, .-seqgen_key
	.section	.rodata.str1.1
.LC17:
	.string	"INVERTED"
.LC18:
	.string	"DOUBLED"
.LC19:
	.string	"FITTED"
.LC20:
	.string	"TRANSPOSED"
	.text
	.align	2
	.globl	seqgen_knob
	.type	seqgen_knob, @function
seqgen_knob:
	lea (-32,%sp),%sp
	move.l %a2,-(%sp)
	move.l %d2,-(%sp)
	move.l 44(%sp),%d0
	move.l 48(%sp),%a0
	tst.l win
	jeq .L1059
	mov3q.l #5,%d1
	cmp.l %d0,%d1
	jcs .L1059
	move.l -2147483630,%a1
	tst.l %a1
	jne .L1059
	mvz.b 269161676,%d1
	mov3q.l #7,%d2
	cmp.l %d1,%d2
	jcs .L1059
	tst.l %a0
	jeq .L1059
	tst.l params_ready
	jne .L1061
	move.l %d0,20(%sp)
	move.l %a0,12(%sp)
	move.l %a1,8(%sp)
	jsr (ensure_params.part.0)
	move.l 8(%sp),%a1
	move.l 12(%sp),%a0
	move.l 20(%sp),%d0
.L1061:
	move.l page,%d1
	move.l %d1,32(%sp)
	mvz.b 269161676,%d2
	move.l %d2,28(%sp)
	mov3q.l #6,%d2
	muls.l %d2,%d1
	add.l %d0,%d1
	moveq #15,%d0
	cmp.l %d1,%d0
	jcs .L1115
	move.l %d1,-(%sp)
	move.l 32(%sp),%d0
	lsl.l #4,%d0
	add.l #params,%d0
	move.l %d0,40(%sp)
	move.l %d0,-(%sp)
	move.l %d1,24(%sp)
	move.l %a0,20(%sp)
	move.l %a1,16(%sp)
	jsr sg_get
	addq.l #8,%sp
	mvz.b %d0,%d0
	move.l 12(%sp),%a0
	move.l 16(%sp),%d1
	move.l 8(%sp),%a1
	move.l %d0,24(%sp)
	add.l %d0,%a0
	tst.l %a0
	jlt .L1086
	lea sg_control_max,%a2
	mvz.b (%a2,%d1.l),%d0
	cmp.l %d0,%a0
	jge .L1067
	move.l %a0,%d0
.L1067:
	cmp.l 24(%sp),%d0
	jeq .L1059
	move.l %d0,-(%sp)
	move.l %d1,-(%sp)
	move.l 44(%sp),-(%sp)
	move.l %d0,32(%sp)
	move.l %d1,28(%sp)
	move.l %a1,20(%sp)
	jsr sg_set
	lea (12,%sp),%sp
	clr.l status
	move.l 20(%sp),%d0
	move.l 8(%sp),%a1
	tst.l 32(%sp)
	jeq .L1116
	move.l 16(%sp),%a0
	mov3q.l #1,%d2
	lea (-12,%a0),%a0
	cmp.l %a0,%d2
	jcc .L1117
	moveq #15,%d2
	cmp.l 16(%sp),%d2
	jeq .L1118
.L1106:
	tst.l win
	jeq .L1059
	move.l (%sp)+,%d2
	move.l (%sp)+,%a2
	lea (32,%sp),%sp
	jra (draw.part.0)
.L1059:
	move.l (%sp)+,%d2
	move.l (%sp)+,%a2
	lea (32,%sp),%sp
	rts
.L1115:
	moveq #16,%d2
	cmp.l %d1,%d2
	jeq .L1119
	move.l #.LC18,%d1
	mov3q.l #6,%a0
.L1063:
	move.l 1187521622,%d0
	add.l #-1073741824,%d0
	cmp.l #133169151,%d0
	jhi .L1109
	mov3q.l #7,%d0
	cmp.l 28(%sp),%d0
	jcs .L1109
	clr.l -(%sp)
	move.l %a0,-(%sp)
.L1111:
	move.l 36(%sp),-(%sp)
	move.l %d1,28(%sp)
	jsr (commit.part.0)
	lea (12,%sp),%sp
	mov3q.l #1,%d2
	move.l 16(%sp),%d1
	cmp.l %d0,%d2
	jeq .L1065
	subq.l #2,%d0
	tst.l %d0
	jne .L1109
	move.l #.LC11,%d1
.L1065:
	move.l %d1,status
	jra .L1106
.L1118:
	move.l 28(%sp),%d1
	lsl.l #4,%d1
	move.l %d1,%a0
	add.l #params+14,%a0
	tst.b (%a0)
	jne .L1091
	move.l #.LC13,%d1
.L1079:
	move.l 1187521622,%a0
	add.l #-1073741824,%a0
	cmp.l #133169151,%a0
	jhi .L1109
	mov3q.l #7,%d2
	cmp.l 28(%sp),%d2
	jcs .L1109
	sub.l 24(%sp),%d0
	move.l %d0,-(%sp)
	move.l %a1,-(%sp)
	jra .L1111
.L1109:
	move.l #.LC12,%d1
	move.l %d1,status
	jra .L1106
.L1086:
	clr.l %d0
	jra .L1067
.L1116:
	move.l 1187521622,%d0
	add.l #-1073741824,%d0
	cmp.l #133169151,%d0
	jhi .L1107
	mov3q.l #7,%d0
	cmp.l 28(%sp),%d0
	jcs .L1107
	clr.l -(%sp)
	clr.l -(%sp)
	move.l 36(%sp),-(%sp)
	jsr (commit.part.0)
	lea (12,%sp),%sp
	mov3q.l #1,%d1
	cmp.l %d0,%d1
	jeq .L1087
	subq.l #2,%d0
	tst.l %d0
	jne .L1107
	move.l #.LC11,%d0
	move.l %d0,status
	jra .L1106
.L1117:
	move.l 28(%sp),%d0
	lsl.l #4,%d0
	move.l %d0,%a0
	add.l #params+14,%a0
	tst.b (%a0)
	jeq .L1089
	move.l #.LC19,%d1
	mov3q.l #3,%a1
.L1075:
	move.l 1187521622,%d0
	add.l #-1073741824,%d0
	cmp.l #133169151,%d0
	jhi .L1109
	mov3q.l #7,%d0
	cmp.l 28(%sp),%d0
	jcs .L1109
	clr.l -(%sp)
	move.l %a1,-(%sp)
	jra .L1111
.L1119:
	move.l #.LC17,%d1
	mov3q.l #5,%a0
	jra .L1063
.L1107:
	move.l #.LC12,%d0
	move.l %d0,status
	jra .L1106
.L1089:
	move.l #.LC13,%d1
	jra .L1075
.L1091:
	move.l #.LC20,%d1
	mov3q.l #4,%a1
	jra .L1079
.L1087:
	move.l #.LC13,%d0
	move.l %d0,status
	jra .L1106
	.size	seqgen_knob, .-seqgen_knob
	.section	.rodata.str1.1
.LC21:
	.string	"AUTO EVOLVED"
	.text
	.align	2
	.globl	seqgen_tick
	.type	seqgen_tick, @function
seqgen_tick:
	lea (-32,%sp),%sp
	movem.l #15420,(%sp)
	tst.l win
	jeq .L1121
	mvz.b 269161676,%d0
	cmp.l shown_track.l,%d0
	jne .L1122
	move.l shown_midi,%d0
	cmp.l -2147483630.l,%d0
	jeq .L1121
.L1122:
	jsr (draw.part.0)
.L1121:
	tst.l params_ready
	jeq .L1120
	move.l -2147457608,%a1
	moveq #8,%d0
	clr.l %d2
	clr.l %d3
	lea params,%a0
.L1124:
	move.l %d2,%d1
	subq.l #1,%d0
	lsl.l #4,%d1
	addq.l #1,%d2
	mvz.b 8(%a0,%d1.l),%d1
	or.l %d1,%d3
	tst.l %d0
	jne .L1124
	mov3q.l #1,%d1
	cmp.l %a1,%d1
	jne .L1125
	tst.l %d3
	jeq .L1125
	mov3q.l #1,%d2
	cmp.l last_transport.l,%d2
	jeq .L1143
	move.w #8,%a1
	clr.l %d1
	lea last_step,%a2
	lea loops,%a5
	lea auto_due,%a3
.L1128:
	clr.b %d4
	move.l %d1,%a4
	add.l #-2147457840,%a4
	move.b (%a4),(%a2,%d1.l)
	subq.l #1,%a1
	move.b %d4,(%a5,%d1.l)
	move.b %d4,(%a3,%d1.l)
	addq.l #1,%d1
	tst.l %a1
	jne .L1128
	mov3q.l #1,last_transport
	moveq #8,%d3
	lea sg_autoloop_values,%a4
	lea loops,%a5
.L1132:
	move.l %d0,%d1
	moveq #18,%d5
	move.l %d0,%a1
	add.l #-2147457840,%a1
	lsl.l #4,%d1
	move.b (%a1),%d4
	mvz.b 8(%a0,%d1.l),%d1
	move.w %d1,%d2
	mulu.w #43691,%d2
	lsr.l %d5,%d2
	mvz.b %d4,%d5
	muls.w #6,%d2
	sub.l %d2,%d1
	mvz.b %d1,%d1
	move.b (%a4,%d1.l),%d1
	jeq .L1129
	mvz.b (%a2,%d0.l),%d2
	mvz.b %d1,%d1
	cmp.l %d5,%d2
	jls .L1130
	move.b (%a5,%d0.l),%d2
	addq.l #1,%d2
	mvz.b %d2,%d5
	cmp.l %d1,%d5
	jcc .L1131
	move.b %d2,(%a5,%d0.l)
.L1130:
	move.b %d4,(%a2,%d0.l)
	addq.l #1,%d0
	subq.l #1,%d3
	tst.l %d3
	jne .L1132
	move.l auto_next,%d1
	moveq #8,%d0
.L1134:
	move.l %d1,%d2
	mov3q.l #7,%d4
	add.l %d3,%d2
	and.l %d4,%d2
	subq.l #1,%d0
	addq.l #1,%d3
	tst.b (%a3,%d2.l)
	jne .L1133
	tst.l %d0
	jne .L1134
.L1120:
	movem.l (%sp),#15420
	lea (32,%sp),%sp
	rts
.L1125:
	movem.l (%sp),#15420
	move.l %a1,last_transport
	lea (32,%sp),%sp
	rts
.L1143:
	lea last_step,%a2
	moveq #8,%d3
	lea auto_due,%a3
	mov3q.l #1,last_transport
	lea sg_autoloop_values,%a4
	lea loops,%a5
	jra .L1132
.L1129:
	clr.b %d5
	move.b %d5,(%a5,%d0.l)
	move.b %d5,(%a3,%d0.l)
	jra .L1130
.L1131:
	clr.b %d1
	moveq #1,%d2
	move.b %d1,(%a5,%d0.l)
	move.b %d2,(%a3,%d0.l)
	jra .L1130
.L1133:
	clr.b %d5
	move.l %d2,%d0
	addq.l #1,%d0
	move.l %d0,auto_next
	move.b %d5,(%a3,%d2.l)
	move.l 1187521622,%d0
	add.l #-1073741824,%d0
	cmp.l #133169151,%d0
	jhi .L1120
	clr.l -(%sp)
	mov3q.l #1,-(%sp)
	move.l %d2,-(%sp)
	jsr (commit.part.0)
	lea (12,%sp),%sp
	subq.l #1,%d0
	tst.l %d0
	jne .L1120
	tst.l win
	jeq .L1120
	mvz.b 269161676,%d0
	cmp.l %d0,%d2
	jne .L1120
	move.l #.LC21,%d2
	move.l %d2,status
	movem.l (%sp),#15420
	lea (32,%sp),%sp
	jra (draw.part.0)
	.size	seqgen_tick, .-seqgen_tick
	.section	.rodata
	.type	rtim.0, @object
	.size	rtim.0, 5
rtim.0:
	.base64	"AABPSEM="
	.type	pcts.1, @object
	.size	pcts.1, 5
pcts.1:
	.ascii	"2;CKW"
	.type	sizes.2, @object
	.size	sizes.2, 3
sizes.2:
	.base64	"AgQI"
	.type	n.3, @object
	.size	n.3, 3
n.3:
	.base64	"AwUH"
	.data
	.align	2
	.type	auto_next, @object
	.size	auto_next, 4
auto_next:
	.zero	4
	.align	2
	.type	last_transport, @object
	.size	last_transport, 4
last_transport:
	.zero	4
	.type	auto_due, @object
	.size	auto_due, 8
auto_due:
	.zero	8
	.type	loops, @object
	.size	loops, 8
loops:
	.zero	8
	.type	last_step, @object
	.size	last_step, 8
last_step:
	.zero	8
	.type	phrase, @object
	.size	phrase, 513
phrase:
	.zero	513
	.align	2
	.type	undo_part, @object
	.size	undo_part, 4
undo_part:
	.zero	4
	.align	2
	.type	undo_track, @object
	.size	undo_track, 4
undo_track:
	.zero	4
	.align	2
	.type	undo_off, @object
	.size	undo_off, 4
undo_off:
	.zero	4
	.align	2
	.type	undo_bank, @object
	.size	undo_bank, 4
undo_bank:
	.zero	4
	.align	2
	.type	undo_valid, @object
	.size	undo_valid, 4
undo_valid:
	.zero	4
	.align	4
	.type	undo_rec, @object
	.size	undo_rec, 2330
undo_rec:
	.zero	2330
	.align	4
	.type	staging, @object
	.size	staging, 2330
staging:
	.zero	2330
	.align	2
	.type	status, @object
	.size	status, 4
status:
	.zero	4
	.align	4
	.type	mine, @object
	.size	mine, 64
mine:
	.zero	64
	.align	2
	.type	close_pending, @object
	.size	close_pending, 4
close_pending:
	.zero	4
	.align	2
	.type	shown_midi, @object
	.size	shown_midi, 4
shown_midi:
	.zero	4
	.align	2
	.type	shown_track, @object
	.size	shown_track, 4
shown_track:
	.long	255
	.align	2
	.type	page, @object
	.size	page, 4
page:
	.zero	4
	.align	2
	.type	win, @object
	.size	win, 4
win:
	.zero	4
	.align	2
	.type	evo_seed, @object
	.size	evo_seed, 32
evo_seed:
	.zero	32
	.align	2
	.type	params_ready, @object
	.size	params_ready, 4
params_ready:
	.zero	4
	.align	4
	.type	params, @object
	.size	params, 128
params:
	.zero	128
	.section	.rodata.str1.1
.LC22:
	.string	"1"
.LC23:
	.string	"2"
.LC24:
	.string	"4"
.LC25:
	.string	"8"
.LC26:
	.string	"16"
	.section	.rodata
	.align	2
	.type	auto_names, @object
	.size	auto_names, 24
auto_names:
	.long	.LC5
	.long	.LC22
	.long	.LC23
	.long	.LC24
	.long	.LC25
	.long	.LC26
	.section	.rodata.str1.1
.LC27:
	.string	"C"
.LC28:
	.string	"C#"
.LC29:
	.string	"D"
.LC30:
	.string	"D#"
.LC31:
	.string	"E"
.LC32:
	.string	"F"
.LC33:
	.string	"F#"
.LC34:
	.string	"G"
.LC35:
	.string	"G#"
.LC36:
	.string	"A"
.LC37:
	.string	"A#"
.LC38:
	.string	"B"
	.section	.rodata
	.align	2
	.type	root_names, @object
	.size	root_names, 48
root_names:
	.long	.LC27
	.long	.LC28
	.long	.LC29
	.long	.LC30
	.long	.LC31
	.long	.LC32
	.long	.LC33
	.long	.LC34
	.long	.LC35
	.long	.LC36
	.long	.LC37
	.long	.LC38
	.section	.rodata.str1.1
.LC39:
	.string	"GEN"
.LC40:
	.string	"EVO"
.LC41:
	.string	"KEY"
	.section	.rodata
	.align	2
	.type	page_names, @object
	.size	page_names, 12
page_names:
	.long	.LC39
	.long	.LC40
	.long	.LC41
	.type	stock_pct, @object
	.size	stock_pct, 21
stock_pct:
	.base64	"AQIEBgkNExkhKTI7Q0tRV1teYGJj"
	.globl	sg_autoloop_values
	.type	sg_autoloop_values, @object
	.size	sg_autoloop_values, 6
sg_autoloop_values:
	.base64	"AAECBAgQ"
	.globl	sg_scale_masks
	.align	2
	.type	sg_scale_masks, @object
	.size	sg_scale_masks, 36
sg_scale_masks:
	.word	4095
	.word	2741
	.word	1453
	.word	1709
	.word	1451
	.word	2773
	.word	1717
	.word	1387
	.word	2477
	.word	2733
	.word	1365
	.word	2925
	.word	1755
	.word	661
	.word	1193
	.word	1257
	.word	2193
	.word	1169
	.globl	sg_scale_names
	.section	.rodata.str1.1
.LC42:
	.string	"CHR"
.LC43:
	.string	"MAJ"
.LC44:
	.string	"MIN"
.LC45:
	.string	"DOR"
.LC46:
	.string	"PHR"
.LC47:
	.string	"LYD"
.LC48:
	.string	"MIX"
.LC49:
	.string	"LOC"
.LC50:
	.string	"HMIN"
.LC51:
	.string	"MMIN"
.LC52:
	.string	"WHL"
.LC53:
	.string	"OCT1"
.LC54:
	.string	"OCT2"
.LC55:
	.string	"PMAJ"
.LC56:
	.string	"PMIN"
.LC57:
	.string	"BLUS"
.LC58:
	.string	"MAJ7"
.LC59:
	.string	"DOM7"
	.section	.rodata
	.align	2
	.type	sg_scale_names, @object
	.size	sg_scale_names, 72
sg_scale_names:
	.long	.LC42
	.long	.LC43
	.long	.LC44
	.long	.LC45
	.long	.LC46
	.long	.LC47
	.long	.LC48
	.long	.LC49
	.long	.LC50
	.long	.LC51
	.long	.LC52
	.long	.LC53
	.long	.LC54
	.long	.LC55
	.long	.LC56
	.long	.LC57
	.long	.LC58
	.long	.LC59
	.globl	sg_evo_names
	.section	.rodata.str1.1
.LC60:
	.string	"LOW"
.LC61:
	.string	"MED"
.LC62:
	.string	"HIGH"
.LC63:
	.string	"SWIZ"
.LC64:
	.string	"SW-P"
.LC65:
	.string	"SW-G"
.LC66:
	.string	"SW-V"
	.section	.rodata
	.align	2
	.type	sg_evo_names, @object
	.size	sg_evo_names, 28
sg_evo_names:
	.long	.LC60
	.long	.LC61
	.long	.LC62
	.long	.LC63
	.long	.LC64
	.long	.LC65
	.long	.LC66
	.globl	sg_algo_names
	.section	.rodata.str1.1
.LC67:
	.string	"ACID"
.LC68:
	.string	"BARL"
.LC69:
	.string	"CELL"
.LC70:
	.string	"OBLQ"
.LC71:
	.string	"RAND"
.LC72:
	.string	"EUCL"
.LC73:
	.string	"TEKN"
.LC74:
	.string	"MIRR"
.LC75:
	.string	"DRUM"
	.section	.rodata
	.align	2
	.type	sg_algo_names, @object
	.size	sg_algo_names, 36
sg_algo_names:
	.long	.LC67
	.long	.LC68
	.long	.LC69
	.long	.LC70
	.long	.LC71
	.long	.LC72
	.long	.LC73
	.long	.LC74
	.long	.LC75
	.globl	sg_control_max
	.type	sg_control_max, @object
	.size	sg_control_max, 16
sg_control_max:
	.base64	"CBAMf39/BmQFZGQXCxEBGA=="
	.globl	sg_control_names
	.section	.rodata.str1.1
.LC76:
	.string	"ALGO"
.LC77:
	.string	"DENS"
.LC78:
	.string	"SPAN"
.LC79:
	.string	"GATE"
.LC80:
	.string	"ACNT"
.LC81:
	.string	"SEED"
.LC82:
	.string	"AMNT"
.LC83:
	.string	"AUTO"
.LC84:
	.string	"PROB"
.LC85:
	.string	"RTCH"
.LC86:
	.string	"GRV"
.LC87:
	.string	"ROOT"
.LC88:
	.string	"SCAL"
.LC89:
	.string	"FIT"
.LC90:
	.string	"TRNS"
	.section	.rodata
	.align	2
	.type	sg_control_names, @object
	.size	sg_control_names, 64
sg_control_names:
	.long	.LC76
	.long	.LC77
	.long	.LC78
	.long	.LC79
	.long	.LC80
	.long	.LC81
	.long	.LC40
	.long	.LC82
	.long	.LC83
	.long	.LC84
	.long	.LC85
	.long	.LC86
	.long	.LC87
	.long	.LC88
	.long	.LC89
	.long	.LC90
	.globl	sg_defaults
	.type	sg_defaults, @object
	.size	sg_defaults, 16
sg_defaults:
	.byte	0
	.byte	10
	.byte	12
	.byte	32
	.byte	48
	.byte	1
	.byte	0
	.byte	25
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	1
	.byte	0
	.byte	12

#APP
| SEQGEN hooks, data and the PROJECT > CONTROL row. GNU as, ColdFire.
| Copyright (c) 2026 yes0have0some. MIT. Original.
        .text
        .global seqgen_tick_hook
| 0x40052232, the UI tick's `jsr 0x4003fed8` (six bytes, replayed here),
| one call after the sites other modules use; returns to 0x40052238.
seqgen_tick_hook:
        jsr     0x4003fed8
        jsr     seqgen_tick
        jmp     0x40052238

        .data
        .balign 4
| The CONTROL rows: the six stock 24-byte nodes are copied here at build time
| from the user's own OS (StockCopy; zeros in source), then the SEQGEN node
| {label, window, action, 0, children, page id}. Page id 0 makes the stock
| menu call the action on YES instead of opening a settings page.
        .global seqgen_control_rows
seqgen_control_rows:
        .space  144
        .long   seqgen_label, 0, seqgen_open, 0, 0, 0
seqgen_label:
        .asciz  "SEQGEN"
        .balign 4
| Our input layer: {link, keys, encoders, 0, 0, -1, -1}. Each key record is
| {code, 0, press, release, repeat, held layer, 0, 0, 0}. The key cache takes
| a held-layer pointer from a lower layer when ours is zero (measured under
| the port: FUNC pushed the stock FUNC layer over this one), so FUNC names
| seqgen_func_layer, which the stock dispatcher pushes while FUNC is held and
| pops on release. It shares the key table; encoders fall through to ours.
        .global seqgen_layer
seqgen_layer:
        .long   0, seqgen_keys, seqgen_encs, 0, 0, -1, -1
seqgen_func_layer:
        .long   0, seqgen_keys, 0, 0, 0, -1, -1
seqgen_keys:
        .irp    k, 0x31, 0x32, 0x34, 0x21, 0x33, 0x20
        .byte   \k, 0
        .long   seqgen_key, seqgen_key, seqgen_key, 0, 0
        .word   0, 0
        .endr
        .byte   0x2d, 0
        .long   seqgen_key, seqgen_key, seqgen_key, seqgen_func_layer, 0
        .word   0, 0
        .byte   0xff, 0
        .long   0, 0, 0, 0, 0
        .word   0, 0
seqgen_encs:
        .irp    k, 0, 1, 2, 3, 4, 5, 6
        .byte   \k, 0
        .long   seqgen_knob, 0, 0, 0, 0
        .endr
        .byte   0xff, 0
        .long   0, 0, 0, 0, 0
