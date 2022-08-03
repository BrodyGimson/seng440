	.arch armv5
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 1
	.eabi_attribute 18, 4
	.file	"optimized.c"
	.text
	.align	2
	.global	transpose
	.type	transpose, %function
transpose:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6}
	mov	r5, r0
	mov	r4, r1
	mov	r0, #0
	mov	r6, r0
	b	.L2
.L3:
	ldr	r3, [ip], #32
	str	r3, [r1, r2]
	add	r2, r2, #4
	cmp	r2, #32
	bne	.L3
	add	r0, r0, #1
	add	r4, r4, #32
	cmp	r0, #8
	beq	.L7
.L2:
	mov	r1, r4
	mov	r3, r0, asl #2
	add	ip, r5, r3
	mov	r2, r6
	b	.L3
.L7:
	ldmfd	sp!, {r4, r5, r6}
	bx	lr
	.size	transpose, .-transpose
	.align	2
	.global	get_next_group
	.type	get_next_group, %function
get_next_group:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8}
	mov	r6, r0
	mov	r5, r1
	mov	r4, r2
	mov	r0, #0
	ldr	r8, .L15
	mov	r7, r0
	b	.L9
.L10:
	ldr	r3, [ip], #4
	str	r3, [r1, r2]
	add	r2, r2, #4
	cmp	r2, #32
	bne	.L10
	add	r0, r0, #1
	add	r4, r4, #32
	cmp	r0, #8
	beq	.L14
.L9:
	mov	r1, r4
	add	r2, r0, r5
	mov	r3, r2, asl #6
	mov	r2, r2, asl #8
	add	r3, r3, r2
	add	r3, r3, r6
	mov	r3, r3, asl #2
	add	ip, r8, r3
	mov	r2, r7
	b	.L10
.L14:
	ldmfd	sp!, {r4, r5, r6, r7, r8}
	bx	lr
.L16:
	.align	2
.L15:
	.word	g_pixel_matrix
	.size	get_next_group, .-get_next_group
	.align	2
	.global	reflector
	.type	reflector, %function
reflector:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	add	ip, r1, r0
	str	ip, [r2, #0]
	rsb	r0, r1, r0
	str	r0, [r3, #0]
	bx	lr
	.size	reflector, .-reflector
	.align	2
	.global	rotator
	.type	rotator, %function
rotator:
	@ args = 4, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5}
	ldr	r4, .L21
	add	r5, r1, r0
	ldr	ip, [r4, r2, asl #2]
	mul	ip, r5, ip
	mov	r2, r2, asl #2
	add	r4, r4, r2
	ldr	r2, [r4, #12]
	mla	r2, r1, r2, ip
	str	r2, [r3, #0]
	ldr	r3, [r4, #24]
	mla	r2, r3, r0, ip
	ldr	r3, [sp, #8]
	str	r2, [r3, #0]
	ldmfd	sp!, {r4, r5}
	bx	lr
.L22:
	.align	2
.L21:
	.word	.LANCHOR0
	.size	rotator, .-rotator
	.align	2
	.global	scale_up
	.type	scale_up, %function
scale_up:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r0, r0, asr #7
	mov	r2, r0, asl #4
	sub	r2, r2, r0, asl #2
	mov	r3, r2, asl #4
	rsb	r3, r2, r3
	add	r0, r3, r0
	bx	lr
	.size	scale_up, .-scale_up
	.align	2
	.global	loefflers
	.type	loefflers, %function
loefflers:
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #60
	mov	r4, r0
	str	r0, [sp, #8]
	add	r9, sp, #24
	ldr	r0, [r0, #0]
	mov	r2, r4
	ldr	r1, [r2, #28]!
	str	r2, [sp, #8]
	mov	r2, r9
	add	r3, sp, #52
	bl	reflector
	str	r4, [sp, #12]
	mov	fp, r4
	add	sl, sp, #28
	mov	r3, r4
	ldr	r0, [r3, #4]!
	str	r3, [sp, #12]
	ldr	r1, [fp, #24]!
	mov	r2, sl
	add	r3, sp, #48
	bl	reflector
	mov	r8, r4
	str	r4, [sp, #16]
	add	r7, sp, #32
	ldr	r0, [r8, #8]!
	mov	r2, r4
	ldr	r1, [r2, #20]!
	str	r2, [sp, #16]
	mov	r2, r7
	add	r3, sp, #44
	bl	reflector
	str	r4, [sp, #20]
	mov	r6, r4
	add	r5, sp, #36
	mov	r3, r4
	ldr	r0, [r3, #12]!
	str	r3, [sp, #20]
	ldr	r1, [r6, #16]!
	mov	r2, r5
	add	r3, sp, #40
	bl	reflector
	ldr	r0, [sp, #24]
	ldr	r1, [sp, #36]
	mov	r2, r9
	mov	r3, r5
	bl	reflector
	ldr	r0, [sp, #28]
	ldr	r1, [sp, #32]
	mov	r2, sl
	mov	r3, r7
	bl	reflector
	ldr	r0, [sp, #24]
	ldr	r1, [sp, #28]
	mov	r2, r9
	mov	r3, sl
	bl	reflector
	str	r5, [sp, #0]
	ldr	r0, [sp, #32]
	ldr	r1, [sp, #36]
	mov	r2, #2
	mov	r3, r7
	bl	rotator
	ldr	r3, [sp, #24]
	mov	r3, r3, asl #7
	str	r3, [r4, #0]
	ldr	r3, [sp, #28]
	mov	r3, r3, asl #7
	str	r3, [r6, #0]
	ldr	r3, [sp, #32]
	mov	r3, r3, asr #7
	str	r3, [r8, #0]
	ldr	r3, [sp, #36]
	mov	r3, r3, asr #7
	str	r3, [fp, #0]
	add	r2, sp, #52
	str	r2, [sp, #0]
	ldr	r0, [sp, #40]
	ldr	r1, [sp, #52]
	mov	r2, #1
	add	r3, sp, #40
	bl	rotator
	add	r3, sp, #48
	str	r3, [sp, #0]
	ldr	r0, [sp, #44]
	ldr	r1, [sp, #48]
	mov	r2, #0
	add	r3, sp, #44
	bl	rotator
	ldr	r0, [sp, #40]
	ldr	r1, [sp, #48]
	add	r2, sp, #40
	add	r3, sp, #48
	bl	reflector
	ldr	r0, [sp, #52]
	ldr	r1, [sp, #44]
	add	r2, sp, #52
	add	r3, sp, #44
	bl	reflector
	ldr	r0, [sp, #52]
	ldr	r1, [sp, #40]
	add	r2, sp, #52
	add	r3, sp, #40
	bl	reflector
	ldr	r0, [sp, #44]
	bl	scale_up
	mov	r4, r0
	ldr	r0, [sp, #48]
	bl	scale_up
	ldr	r3, [sp, #40]
	mov	r3, r3, asr #7
	ldr	r2, [sp, #8]
	str	r3, [r2, #0]
	mov	r4, r4, asr #7
	ldr	r3, [sp, #20]
	str	r4, [r3, #0]
	mov	r0, r0, asr #7
	ldr	r2, [sp, #16]
	str	r0, [r2, #0]
	ldr	r3, [sp, #52]
	mov	r3, r3, asr #7
	ldr	r2, [sp, #12]
	str	r3, [r2, #0]
	add	sp, sp, #60
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
	.size	loefflers, .-loefflers
	.align	2
	.global	get_image
	.type	get_image, %function
get_image:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	mov	r4, r0
	ldr	r3, .L38
	ldr	r0, [r3, #0]
	bl	fflush
	mov	r0, r4
	ldr	r1, .L38+4
	bl	fopen
	subs	r6, r0, #0
	bne	.L28
	ldr	r0, .L38+8
	bl	perror
.L28:
	mov	r0, r6
	mov	r1, #54
	mov	r2, #0
	bl	fseek
	cmp	r0, #0
	beq	.L29
	ldr	r0, .L38+12
	bl	perror
.L29:
	mov	r0, r6
	mov	r1, #1024
	mov	r2, #1
	bl	fseek
	cmp	r0, #0
	beq	.L30
	ldr	r0, .L38+16
	bl	perror
	b	.L30
.L32:
	mov	r0, r6
	bl	fgetc
	cmn	r0, #1
	beq	.L31
	str	r0, [r5], #4
	add	r4, r4, #1
	cmp	r4, #320
	bne	.L32
.L31:
	add	r7, r7, #1
	cmp	r7, #240
	ldmeqfd	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
.L33:
	mov	r3, r7, asl #8
	mov	r2, r7, asl #10
	add	r3, r3, r2
	add	r5, r8, r3
	mov	r4, sl
	b	.L32
.L30:
	mov	r7, #0
	ldr	r8, .L38+20
	mov	sl, r7
	b	.L33
.L39:
	.align	2
.L38:
	.word	stdout
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	g_pixel_matrix
	.size	get_image, .-get_image
	.global	__aeabi_i2d
	.global	__aeabi_dmul
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 536
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #540
	mov	r3, r0
	cmp	r0, #2
	beq	.L41
	ldr	r0, .L69
	sub	r1, r3, #1
	bl	printf
	mov	r0, #1
	b	.L42
.L41:
	mov	r4, r1
	ldr	r0, .L69+4
	ldr	r1, [r4, #4]!
	bl	printf
	ldr	r0, .L69+8
	bl	puts
	ldr	r0, [r4, #0]
	bl	get_image
	mov	r2, #0
	str	r2, [sp, #20]
	add	r7, sp, #280
	add	r6, sp, #24
	str	r6, [sp, #16]
	str	r2, [sp, #12]
	str	r7, [sp, #8]
	mov	fp, r2
	str	r7, [sp, #4]
	b	.L43
.L50:
	mov	r8, r9, asl #3
	mov	r0, sl
	mov	r1, r8
	ldr	r2, [sp, #8]
	bl	get_next_group
	ldr	r5, [sp, #8]
	ldr	r4, [sp, #12]
.L45:
	mov	r0, r5
	bl	loefflers
	mov	r3, r4, asl #2
	add	r1, r7, r3
	mov	r3, r4, asl #5
	add	r0, r6, r3
	mov	r2, fp
.L44:
	ldr	r3, [r1], #32
	str	r3, [r0], #4
	add	r2, r2, #1
	cmp	r2, #8
	bne	.L44
	add	r4, r4, #1
	add	r5, r5, #32
	cmp	r4, #8
	bne	.L45
	ldr	r4, [sp, #16]
.L46:
	mov	r0, r4
	bl	loefflers
	add	r4, r4, #32
	cmp	r7, r4
	bne	.L46
	b	.L68
.L48:
	ldr	r3, [r1], #32
	str	r3, [r2], #4
	cmp	r1, r0
	bne	.L48
	add	ip, ip, #1
	add	r0, r0, #4
	cmp	ip, #8
	bne	.L49
	add	r9, r9, #1
	cmp	r9, #30
	bne	.L50
	ldr	r3, [sp, #20]
	add	r3, r3, #1
	str	r3, [sp, #20]
	cmp	r3, #40
	bne	.L43
	ldr	r0, .L69+12
	bl	puts
	mov	r5, #0
	ldr	sl, .L69+16
	mov	r9, r5
	ldr	fp, .L69+20
	mov	r7, #0
	ldr	r8, .L69+24
	b	.L51
.L52:
	ldr	r0, [r6], #4
	bl	__aeabi_i2d
	mov	r2, r7
	mov	r3, r8
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, fp
	bl	printf
	add	r4, r4, #1
	cmp	r4, #8
	bne	.L52
	mov	r0, #10
	bl	putchar
	add	r5, r5, #1
	cmp	r5, #8
	bne	.L51
	ldr	r0, .L69+28
	bl	puts
	ldr	r6, .L69+32
	add	r5, r5, #112
	ldr	sl, .L69+16
	ldr	r9, .L69+20
	mov	r7, #0
	ldr	r8, .L69+24
	mov	fp, #10
	b	.L53
.L54:
	ldr	r0, [r4], #4
	bl	__aeabi_i2d
	mov	r2, r7
	mov	r3, r8
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, r9
	bl	printf
	cmp	r4, r6
	bne	.L54
	mov	r0, fp
	bl	putchar
	add	r5, r5, #1
	add	r6, r6, #1280
	cmp	r5, #128
	bne	.L53
	mov	r0, #0
.L42:
	add	sp, sp, #540
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
.L53:
	mov	r3, r5, asl #8
	mov	r2, r5, asl #10
	add	r3, r3, r2
	add	r3, r3, #640
	add	r4, sl, r3
	b	.L54
.L51:
	mov	r3, r5, asl #8
	mov	r2, r5, asl #10
	add	r3, r3, r2
	add	r6, sl, r3
	mov	r4, r9
	b	.L52
.L68:
	ldr	r0, [sp, #4]
	ldr	ip, [sp, #12]
.L49:
	mov	r3, ip, asl #2
	add	r1, r6, r3
	add	r2, ip, sl
	mov	r3, r2, asl #6
	mov	r2, r2, asl #8
	add	r3, r3, r2
	add	r3, r3, r8
	mov	r3, r3, asl #2
	ldr	lr, .L69+16
	add	r2, lr, r3
	b	.L48
.L43:
	ldr	r2, [sp, #20]
	mov	sl, r2, asl #3
	mov	r9, #0
	b	.L50
.L70:
	.align	2
.L69:
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	g_output_matrix
	.word	.LC8
	.word	1058013184
	.word	.LC9
	.word	g_output_matrix+154272
	.size	main, .-main
	.global	IMAGE_SIZE
	.global	IMAGE_HEIGHT
	.global	IMAGE_WIDTH
	.global	SQRT2
	.global	ROTATE_CONST_O1
	.global	ROTATE_CONST_O2
	.global	ROTATE_CONST
	.global	END_SCALE
	.comm	g_pixel_matrix,307200,4
	.comm	g_output_matrix,307200,4
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	ROTATE_CONST, %object
	.size	ROTATE_CONST, 12
ROTATE_CONST:
	.word	16069
	.word	13622
	.word	8866
	.type	ROTATE_CONST_O1, %object
	.size	ROTATE_CONST_O1, 12
ROTATE_CONST_O1:
	.word	-12873
	.word	-4520
	.word	12539
	.type	ROTATE_CONST_O2, %object
	.size	ROTATE_CONST_O2, 12
ROTATE_CONST_O2:
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
	.word	16384
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
