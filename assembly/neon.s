	.arch armv5
	.eabi_attribute 27, 3
	.fpu neon
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 1
	.eabi_attribute 18, 4
	.file	"neon.c"
	.text
	.align	2
	.global	scale_up
	.type	scale_up, %function
scale_up:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	vmov	d17, r0, r1  @ v2si
	vshr.s32	d16, d17, #7
	vmov.i32	d7, #0  @ v2si
	mov	r3, #181
	vmov.32	d7[0], r3
	vmul.i32	d17, d16, d7[0]
	vmov	r0, r1, d17  @ v2si
	bx	lr
	.size	scale_up, .-scale_up
	.align	2
	.global	rotator
	.type	rotator, %function
rotator:
	@ args = 12, pretend = 0, frame = 16
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #16
	vmov	d17, r0, r1  @ v2si
	vmov	d16, r2, r3  @ v2si
	ldr	ip, .L5
	add	r3, sp, #4
	ldmia	ip, {r0, r1, r2}
	stmia	r3, {r0, r1, r2}
	ldr	r3, [sp, #16]
	mov	r3, r3, asl #2
	add	ip, ip, r3
	ldr	r2, [ip, #12]
	vmov.i32	d6, #0  @ v2si
	vmov.32	d6[0], r2
	vmul.i32	d6, d16, d6[0]
	vadd.i32	d16, d17, d16
	add	r2, sp, #16
	add	r3, r2, r3
	ldr	r2, [r3, #-12]
	vmov.i32	d7, #0  @ v2si
	vmov.32	d7[0], r2
	vmul.i32	d7, d16, d7[0]
	vadd.i32	d6, d6, d7
	ldr	r3, [sp, #20]
	fstd	d6, [r3, #0]
	ldr	r3, [ip, #24]
	vmov.i32	d7, #0  @ v2si
	vmov.32	d7[0], r3
	vmul.i32	d17, d17, d7[0]
	vmov.i32	d7, #0  @ v2si
	vmov.32	d7[0], r2
	vmul.i32	d16, d16, d7[0]
	vadd.i32	d17, d17, d16
	ldr	r3, [sp, #24]
	fstd	d17, [r3, #0]
	add	sp, sp, #16
	bx	lr
.L6:
	.align	2
.L5:
	.word	.LANCHOR0
	.size	rotator, .-rotator
	.align	2
	.global	reflector
	.type	reflector, %function
reflector:
	@ args = 8, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	vmov	d16, r0, r1  @ v2si
	vmov	d18, r2, r3  @ v2si
	vadd.i32	d17, d16, d18
	ldr	r3, [sp, #0]
	fstd	d17, [r3, #0]
	vsub.i32	d16, d16, d18
	ldr	r3, [sp, #4]
	fstd	d16, [r3, #0]
	bx	lr
	.size	reflector, .-reflector
	.align	2
	.global	loefflers
	.type	loefflers, %function
loefflers:
	@ args = 0, pretend = 0, frame = 88
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #108
	mov	r4, r0
	add	r3, r0, #56
	str	r3, [sp, #16]
	mov	fp, r0
	fldmiad	fp!, {d16}
	fldd	d17, [r3, #0]
	add	r8, sp, #40
	str	r8, [sp, #0]
	add	r3, sp, #96
	str	r3, [sp, #4]
	vmov	r0, r1, d16  @ v2si
	vmov	r2, r3, d17  @ v2si
	bl	reflector
	add	r3, r4, #48
	str	r3, [sp, #20]
	fldd	d16, [fp, #0]
	fldd	d17, [r3, #0]
	add	r7, sp, #48
	str	r7, [sp, #0]
	add	r3, sp, #88
	str	r3, [sp, #4]
	vmov	r0, r1, d16  @ v2si
	vmov	r2, r3, d17  @ v2si
	bl	reflector
	add	r3, r4, #16
	str	r3, [sp, #24]
	add	r3, r4, #40
	str	r3, [sp, #28]
	ldr	r3, [sp, #24]
	fldd	d16, [r3, #0]
	ldr	r3, [sp, #28]
	fldd	d17, [r3, #0]
	add	r6, sp, #56
	str	r6, [sp, #0]
	add	r9, sp, #80
	str	r9, [sp, #4]
	vmov	r0, r1, d16  @ v2si
	vmov	r2, r3, d17  @ v2si
	bl	reflector
	add	r3, r4, #24
	str	r3, [sp, #32]
	add	r3, r4, #32
	str	r3, [sp, #36]
	ldr	r3, [sp, #32]
	fldd	d16, [r3, #0]
	ldr	r3, [sp, #36]
	fldd	d17, [r3, #0]
	add	r5, sp, #64
	str	r5, [sp, #0]
	add	sl, sp, #72
	str	sl, [sp, #4]
	vmov	r0, r1, d16  @ v2si
	vmov	r2, r3, d17  @ v2si
	bl	reflector
	str	r8, [sp, #0]
	str	r5, [sp, #4]
	fldd	d16, [sp, #40]
	vmov	r0, r1, d16  @ v2si
	fldd	d17, [sp, #64]
	vmov	r2, r3, d17  @ v2si
	bl	reflector
	str	r7, [sp, #0]
	str	r6, [sp, #4]
	fldd	d16, [sp, #48]
	vmov	r0, r1, d16  @ v2si
	fldd	d17, [sp, #56]
	vmov	r2, r3, d17  @ v2si
	bl	reflector
	str	r8, [sp, #0]
	str	r7, [sp, #4]
	fldd	d16, [sp, #40]
	vmov	r0, r1, d16  @ v2si
	fldd	d17, [sp, #48]
	vmov	r2, r3, d17  @ v2si
	bl	reflector
	mov	r3, #2
	stmia	sp, {r3, r6}	@ phole stm
	str	r5, [sp, #8]
	fldd	d16, [sp, #56]
	vmov	r0, r1, d16  @ v2si
	fldd	d17, [sp, #64]
	vmov	r2, r3, d17  @ v2si
	bl	rotator
	fldd	d16, [sp, #40]
	vshl.i32	d16, d16, #5
	fstd	d16, [r4, #0]
	fldd	d16, [sp, #48]
	vshl.i32	d16, d16, #5
	ldr	r3, [sp, #36]
	fstd	d16, [r3, #0]
	fldd	d16, [sp, #56]
	vshr.s32	d16, d16, #9
	ldr	r3, [sp, #24]
	fstd	d16, [r3, #0]
	fldd	d16, [sp, #64]
	vshr.s32	d16, d16, #9
	ldr	r3, [sp, #20]
	fstd	d16, [r3, #0]
	mov	r3, #1
	stmia	sp, {r3, sl}	@ phole stm
	add	r3, sp, #96
	str	r3, [sp, #8]
	fldd	d16, [sp, #72]
	vmov	r0, r1, d16  @ v2si
	fldd	d17, [sp, #96]
	vmov	r2, r3, d17  @ v2si
	bl	rotator
	mov	r3, #0
	stmia	sp, {r3, r9}	@ phole stm
	add	r3, sp, #88
	str	r3, [sp, #8]
	fldd	d16, [sp, #80]
	vmov	r0, r1, d16  @ v2si
	fldd	d17, [sp, #88]
	vmov	r2, r3, d17  @ v2si
	bl	rotator
	str	sl, [sp, #0]
	add	r3, sp, #88
	str	r3, [sp, #4]
	fldd	d16, [sp, #72]
	vmov	r0, r1, d16  @ v2si
	fldd	d17, [sp, #88]
	vmov	r2, r3, d17  @ v2si
	bl	reflector
	add	r3, sp, #96
	stmia	sp, {r3, r9}	@ phole stm
	fldd	d16, [sp, #96]
	vmov	r0, r1, d16  @ v2si
	fldd	d17, [sp, #80]
	vmov	r2, r3, d17  @ v2si
	bl	reflector
	add	r3, sp, #96
	stmia	sp, {r3, sl}	@ phole stm
	fldd	d16, [sp, #96]
	vmov	r0, r1, d16  @ v2si
	fldd	d17, [sp, #72]
	vmov	r2, r3, d17  @ v2si
	bl	reflector
	fldd	d16, [sp, #80]
	vmov	r0, r1, d16  @ v2si
	bl	scale_up
	vmov	d17, r0, r1  @ v2si
	fstd	d17, [sp, #80]
	fldd	d16, [sp, #88]
	vmov	r0, r1, d16  @ v2si
	bl	scale_up
	fldd	d16, [sp, #72]
	vshr.s32	d16, d16, #9
	ldr	r3, [sp, #16]
	fstd	d16, [r3, #0]
	fldd	d16, [sp, #80]
	vshr.s32	d16, d16, #9
	ldr	r3, [sp, #32]
	fstd	d16, [r3, #0]
	vmov	d17, r0, r1  @ v2si
	vshr.s32	d16, d17, #9
	ldr	r3, [sp, #28]
	fstd	d16, [r3, #0]
	fldd	d16, [sp, #96]
	vshr.s32	d16, d16, #9
	fstd	d16, [fp, #0]
	add	sp, sp, #108
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
	.size	loefflers, .-loefflers
	.align	2
	.global	get_next_group
	.type	get_next_group, %function
get_next_group:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, sl}
	sub	sp, sp, #8
	mov	r6, r0
	mov	r5, r1
	mov	r0, #0
	ldr	r8, .L18
	ldr	sl, .L18+4
	mov	r7, r0
	mov	r4, sp
	b	.L12
.L13:
	ldr	r3, [r2, #0]
	str	r3, [sp, #0]
	ldr	r3, [r2, #1280]
	str	r3, [sp, #4]
	vld1.32	{d16}, [r4]
	fstmiad	r1!, {d16}
	add	ip, ip, #1
	add	r2, r2, #4
	cmp	ip, #8
	bne	.L13
	add	r0, r0, #2
	cmp	r0, #8
	beq	.L17
.L12:
	add	r3, r0, r5
	mov	r2, r3, asl #6
	mov	r3, r3, asl #8
	add	r2, r2, r3
	add	r2, r2, r6
	mov	r2, r2, asl #2
	add	r2, r8, r2
	mov	r3, r0, asr #1
	mov	r3, r3, asl #6
	add	r1, sl, r3
	mov	ip, r7
	b	.L13
.L17:
	add	sp, sp, #8
	ldmfd	sp!, {r4, r5, r6, r7, r8, sl}
	bx	lr
.L19:
	.align	2
.L18:
	.word	g_pixel_matrix
	.word	g_current_group
	.size	get_next_group, .-get_next_group
	.align	2
	.global	transpose
	.type	transpose, %function
transpose:
	@ args = 0, pretend = 0, frame = 520
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7}
	sub	sp, sp, #520
	mov	r4, r0
	mov	r7, r1
	mov	r0, #0
	add	r6, sp, #8
	mov	r5, r0
	b	.L21
.L22:
	add	r3, r1, r2
	fldd	d16, [r3, #0]
	vst1.32	{d16}, [ip]
	add	r2, r2, #8
	add	ip, ip, #8
	cmp	r2, #64
	bne	.L22
	add	r0, r0, #1
	cmp	r0, #8
	bne	.L21
	b	.L39
.L24:
	mov	r3, r0, lsr #31
	add	r2, r0, r3
	and	r2, r2, #1
	rsb	r2, r3, r2
	mov	r3, r0, asr #1
	mov	r3, r3, asl #3
	add	r3, r3, ip
	mov	r3, r3, asl #1
	add	r3, r3, r2
	add	r2, sp, #520
	add	r3, r2, r3, asl #2
	ldr	r3, [r3, #-512]
	str	r3, [r1], #4
	add	r0, r0, #1
	cmp	r0, #8
	bne	.L24
	add	ip, ip, #1
	cmp	ip, #8
	bne	.L25
	b	.L40
.L27:
	ldr	r3, [r2, #0]
	str	r3, [sp, #0]
	ldr	r3, [r2, #32]
	str	r3, [sp, #4]
	vld1.32	{d16}, [r4]
	fstmiad	r0!, {d16}
	add	r2, r2, #4
	cmp	r2, ip
	bne	.L27
	add	r1, r1, #2
	add	ip, ip, #64
	cmp	r1, #8
	bne	.L28
	b	.L41
.L40:
	add	ip, sp, #296
	mov	r1, #0
	add	r5, sp, #264
	mov	r4, sp
.L28:
	mov	r3, r1, asl #5
	add	r2, r5, r3
	mov	r3, r1, asr #1
	mov	r3, r3, asl #6
	add	r0, r7, r3
	b	.L27
.L39:
	mov	ip, #0
	add	r5, sp, #264
	mov	r4, ip
.L25:
	mov	r3, ip, asl #5
	add	r1, r5, r3
	mov	r0, r4
	b	.L24
.L21:
	mov	r3, r0, asr #1
	mov	r3, r3, asl #6
	add	r1, r4, r3
	add	ip, r6, r3
	mov	r2, r5
	b	.L22
.L41:
	add	sp, sp, #520
	ldmfd	sp!, {r4, r5, r6, r7}
	bx	lr
	.size	transpose, .-transpose
	.align	2
	.global	get_image
	.type	get_image, %function
get_image:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	mov	r4, r0
	ldr	r3, .L52
	ldr	r0, [r3, #0]
	bl	fflush
	mov	r0, r4
	ldr	r1, .L52+4
	bl	fopen
	subs	r6, r0, #0
	bne	.L43
	ldr	r0, .L52+8
	bl	perror
.L43:
	mov	r0, r6
	mov	r1, #54
	mov	r2, #0
	bl	fseek
	cmp	r0, #0
	beq	.L44
	ldr	r0, .L52+12
	bl	perror
.L44:
	mov	r0, r6
	mov	r1, #1024
	mov	r2, #1
	bl	fseek
	cmp	r0, #0
	beq	.L45
	ldr	r0, .L52+16
	bl	perror
	b	.L45
.L47:
	mov	r0, r6
	bl	fgetc
	cmn	r0, #1
	beq	.L46
	str	r0, [r5], #4
	add	r4, r4, #1
	cmp	r4, #320
	bne	.L47
.L46:
	add	r7, r7, #1
	cmp	r7, #240
	bne	.L48
	mov	r0, r6
	bl	fclose
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
.L48:
	mov	r3, r7, asl #8
	mov	r2, r7, asl #10
	add	r3, r3, r2
	add	r5, r8, r3
	mov	r4, sl
	b	.L47
.L45:
	mov	r7, #0
	ldr	r8, .L52+20
	mov	sl, r7
	b	.L48
.L53:
	.align	2
.L52:
	.word	stdout
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	g_pixel_matrix
	.size	get_image, .-get_image
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 328
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	fstmfdd	sp!, {d8}
	sub	sp, sp, #332
	mov	r3, r0
	cmp	r0, #2
	beq	.L55
	ldr	r0, .L80+8
	sub	r1, r3, #1
	bl	printf
	mov	r0, #1
	b	.L56
.L55:
	mov	r4, r1
	ldr	r0, .L80+12
	ldr	r1, [r4, #4]!
	bl	printf
	ldr	r0, .L80+16
	bl	puts
	ldr	r0, [r4, #0]
	bl	get_image
	mov	r3, #0
	str	r3, [sp, #4]
	add	r5, sp, #72
	add	r2, sp, #8
	mov	r9, r5
	mov	r7, r2
	b	.L57
.L63:
	mov	sl, r6, asl #3
	mov	r0, sl
	mov	r1, fp
	bl	get_next_group
	mov	r4, r8
.L58:
	mov	r0, r4
	bl	loefflers
	add	r4, r4, #64
	ldr	lr, .L80+20
	cmp	r4, lr
	bne	.L58
	mov	r0, r8
	mov	r1, r9
	bl	transpose
	mov	r4, r9
.L59:
	mov	r0, r4
	bl	loefflers
	add	r4, r4, #64
	add	r3, sp, #328
	cmp	r4, r3
	bne	.L59
	mov	r0, r9
	mov	r1, r8
	bl	transpose
	mov	ip, #0
	b	.L60
.L61:
	fldmiad	r3!, {d16}
	vst1.32	{d16}, [r0]
	add	r0, r0, #8
	cmp	r0, r5
	bne	.L61
	mov	r1, r7
	add	r2, ip, fp
	mov	r3, r2, asl #6
	mov	r2, r2, asl #8
	add	r3, r3, r2
	add	r3, r3, sl
	mov	r3, r3, asl #2
	ldr	lr, .L80+24
	add	r2, lr, r3
.L62:
	ldr	r3, [r1, #0]
	str	r3, [r2, #0]
	ldr	r3, [r1, #4]
	str	r3, [r2, #1280]
	add	r1, r1, #8
	add	r2, r2, #4
	cmp	r0, r1
	bne	.L62
	add	ip, ip, #2
	cmp	ip, #8
	bne	.L60
	add	r6, r6, #1
	cmp	r6, #40
	bne	.L63
	ldr	r3, [sp, #4]
	add	r3, r3, #1
	str	r3, [sp, #4]
	cmp	r3, #30
	bne	.L57
	ldr	r0, .L80+28
	bl	puts
	mov	r5, #0
	ldr	r7, .L80+24
	mov	r8, r5
	fldd	d8, .L80
	ldr	sl, .L80+32
	mov	r9, #10
	b	.L64
.L65:
	ldr	r3, [r6], #4
	fmsr	s15, r3	@ int
	fsitod	d16, s15
	mov	r0, sl
	fmuld	d17, d16, d8
	fmrrd	r2, r3, d17
	bl	printf
	add	r4, r4, #1
	cmp	r4, #8
	bne	.L65
	mov	r0, r9
	bl	putchar
	add	r5, r5, #1
	cmp	r5, #8
	bne	.L64
	ldr	r0, .L80+36
	bl	puts
	ldr	r6, .L80+40
	add	r5, r5, #112
	ldr	r7, .L80+24
	fldd	d8, .L80
	ldr	r8, .L80+32
	mov	sl, #10
	b	.L66
.L67:
	ldr	r3, [r4], #4
	fmsr	s15, r3	@ int
	fsitod	d16, s15
	mov	r0, r8
	fmuld	d17, d16, d8
	fmrrd	r2, r3, d17
	bl	printf
	cmp	r4, r6
	bne	.L67
	mov	r0, sl
	bl	putchar
	add	r5, r5, #1
	add	r6, r6, #1280
	cmp	r5, #128
	bne	.L66
	mov	r0, #0
.L56:
	add	sp, sp, #332
	fldmfdd	sp!, {d8}
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
.L66:
	mov	r3, r5, asl #8
	mov	r2, r5, asl #10
	add	r3, r3, r2
	add	r3, r3, #640
	add	r4, r7, r3
	b	.L67
.L64:
	mov	r3, r5, asl #8
	mov	r2, r5, asl #10
	add	r3, r3, r2
	add	r6, r7, r3
	mov	r4, r8
	b	.L65
.L60:
	mov	r3, ip, asr #1
	mov	r3, r3, asl #6
	add	r3, r8, r3
	mov	r0, r7
	b	.L61
.L57:
	ldr	r3, [sp, #4]
	mov	fp, r3, asl #3
	mov	r6, #0
	ldr	r8, .L80+44
	b	.L63
.L81:
	.align	3
.L80:
	.word	0
	.word	1062207488
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	g_current_group+256
	.word	g_output_matrix
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	g_output_matrix+154272
	.word	g_current_group
	.size	main, .-main
	.global	IMAGE_SIZE
	.global	IMAGE_HEIGHT
	.global	IMAGE_WIDTH
	.global	SQRT2
	.global	ROTATE_CONST_p_output_1
	.global	ROTATE_CONST_p_output_2
	.global	END_SCALE
	.comm	g_pixel_matrix,307200,4
	.comm	g_output_matrix,307200,4
	.comm	g_current_group,256,8
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	C.258.17064, %object
	.size	C.258.17064, 12
C.258.17064:
	.word	16069
	.word	13622
	.word	8866
	.type	ROTATE_CONST_p_output_1, %object
	.size	ROTATE_CONST_p_output_1, 12
ROTATE_CONST_p_output_1:
	.word	-12873
	.word	-4520
	.word	12539
	.type	ROTATE_CONST_p_output_2, %object
	.size	ROTATE_CONST_p_output_2, 12
ROTATE_CONST_p_output_2:
	.word	-19266
	.word	-22725
	.word	-30273
	.type	IMAGE_SIZE, %object
	.size	IMAGE_SIZE, 4
IMAGE_SIZE:
	.word	76800
	.type	IMAGE_HEIGHT, %object
	.size	IMAGE_HEIGHT, 4
IMAGE_HEIGHT:
	.word	240
	.type	IMAGE_WIDTH, %object
	.size	IMAGE_WIDTH, 4
IMAGE_WIDTH:
	.word	320
	.type	SQRT2, %object
	.size	SQRT2, 4
SQRT2:
	.word	181
	.type	END_SCALE, %object
	.size	END_SCALE, 4
END_SCALE:
	.word	1024
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"rb\000"
	.space	1
.LC1:
	.ascii	"Error: Could not open file\000"
	.space	1
.LC2:
	.ascii	"Error: Could not seek past header of file\000"
	.space	2
.LC3:
	.ascii	"Error: Could not seek past colour table of file\000"
.LC4:
	.ascii	"Error: 1 arg expected {filename}, received: %d\012\000"
.LC5:
	.ascii	"Filename: %s\012\000"
	.space	2
.LC6:
	.ascii	"\012----TESTING AREA----\000"
	.space	2
.LC7:
	.ascii	"\012Corner 8x8:\000"
	.space	3
.LC8:
	.ascii	"%f, \000"
	.space	3
.LC9:
	.ascii	"\012Center 8x8:\000"
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
