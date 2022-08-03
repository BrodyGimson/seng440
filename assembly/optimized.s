	.arch armv5
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 18, 4
	.file	"optimized.c"
	.global	IMAGE_SIZE
	.section	.rodata
	.align	2
	.type	IMAGE_SIZE, %object
	.size	IMAGE_SIZE, 4
IMAGE_SIZE:
	.word	76800
	.global	IMAGE_HEIGHT
	.align	2
	.type	IMAGE_HEIGHT, %object
	.size	IMAGE_HEIGHT, 4
IMAGE_HEIGHT:
	.word	240
	.global	IMAGE_WIDTH
	.align	2
	.type	IMAGE_WIDTH, %object
	.size	IMAGE_WIDTH, 4
IMAGE_WIDTH:
	.word	320
	.global	SQRT2
	.align	2
	.type	SQRT2, %object
	.size	SQRT2, 4
SQRT2:
	.word	181
	.global	ROTATE_CONST_O1
	.align	2
	.type	ROTATE_CONST_O1, %object
	.size	ROTATE_CONST_O1, 12
ROTATE_CONST_O1:
	.word	-12873
	.word	-4520
	.word	12539
	.global	ROTATE_CONST_O2
	.align	2
	.type	ROTATE_CONST_O2, %object
	.size	ROTATE_CONST_O2, 12
ROTATE_CONST_O2:
	.word	-19266
	.word	-22725
	.word	-30273
	.global	ROTATE_CONST
	.align	2
	.type	ROTATE_CONST, %object
	.size	ROTATE_CONST, 12
ROTATE_CONST:
	.word	16069
	.word	13622
	.word	8866
	.global	END_SCALE
	.align	2
	.type	END_SCALE, %object
	.size	END_SCALE, 4
END_SCALE:
	.word	16384
	.align	2
.LC0:
	.ascii	"rb\000"
	.align	2
.LC1:
	.ascii	"Error: Could not open file\000"
	.align	2
.LC2:
	.ascii	"Error: Could not seek past header of file\000"
	.align	2
.LC3:
	.ascii	"Error: Could not seek past colour table of file\000"
	.text
	.align	2
	.global	get_image
	.type	get_image, %function
get_image:
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #32
	str	r0, [fp, #-32]
	ldr	r3, .L11
	ldr	r3, [r3, #0]
	mov	r0, r3
	bl	fflush
	ldr	r0, [fp, #-32]
	ldr	r1, .L11+4
	bl	fopen
	mov	r3, r0
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-24]
	cmp	r3, #0
	bne	.L2
	ldr	r0, .L11+8
	bl	perror
.L2:
	ldr	r0, [fp, #-24]
	mov	r1, #54
	mov	r2, #0
	bl	fseek
	mov	r3, r0
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	beq	.L3
	ldr	r0, .L11+12
	bl	perror
.L3:
	ldr	r0, [fp, #-24]
	mov	r1, #1024
	mov	r2, #1
	bl	fseek
	mov	r3, r0
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	beq	.L4
	ldr	r0, .L11+16
	bl	perror
.L4:
	mov	r3, #0
	str	r3, [fp, #-12]
	b	.L5
.L9:
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L6
.L8:
	ldr	r0, [fp, #-24]
	bl	fgetc
	mov	r3, r0
	str	r3, [fp, #-20]
	ldr	r3, [fp, #-20]
	cmn	r3, #1
	beq	.L7
	ldr	r3, [fp, #-12]
	ldr	r1, [fp, #-8]
	ldr	r0, .L11+20
	mov	r3, r3, asl #6
	mov	r2, r3, asl #2
	add	r3, r3, r2
	add	r2, r3, r1
	ldr	r3, [fp, #-20]
	str	r3, [r0, r2, asl #2]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L6:
	ldr	r3, .L11+24
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-8]
	cmp	r3, r2
	blt	.L8
.L7:
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L5:
	ldr	r3, .L11+28
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-12]
	cmp	r3, r2
	blt	.L9
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
.L12:
	.align	2
.L11:
	.word	stdout
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	g_pixel_matrix
	.word	IMAGE_WIDTH
	.word	IMAGE_HEIGHT
	.size	get_image, .-get_image
	.align	2
	.global	transpose
	.type	transpose, %function
transpose:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	mov	r3, #0
	str	r3, [fp, #-12]
	b	.L14
.L17:
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L15
.L16:
	ldr	r3, [fp, #-12]
	mov	r2, r3, asl #5
	ldr	r3, [fp, #-20]
	add	r1, r3, r2
	ldr	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	mov	r2, r3, asl #5
	ldr	r3, [fp, #-16]
	add	r2, r3, r2
	ldr	r3, [fp, #-12]
	ldr	r3, [r2, r3, asl #2]
	str	r3, [r1, r0, asl #2]
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L15:
	ldr	r3, [fp, #-8]
	cmp	r3, #7
	ble	.L16
	ldr	r3, [fp, #-12]
	add	r3, r3, #1
	str	r3, [fp, #-12]
.L14:
	ldr	r3, [fp, #-12]
	cmp	r3, #7
	ble	.L17
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	transpose, .-transpose
	.align	2
	.global	get_next_group
	.type	get_next_group, %function
get_next_group:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, fp}
	add	fp, sp, #8
	sub	sp, sp, #20
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	mov	r3, #0
	str	r3, [fp, #-20]
	b	.L20
.L23:
	mov	r3, #0
	str	r3, [fp, #-16]
	b	.L21
.L22:
	ldr	r4, [fp, #-20]
	ldr	r5, [fp, #-16]
	ldr	r2, [fp, #-28]
	ldr	r3, [fp, #-20]
	add	r1, r2, r3
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-16]
	add	r0, r2, r3
	ldr	ip, .L25
	mov	r3, r1
	mov	r3, r3, asl #6
	mov	r2, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r0
	ldr	r1, [ip, r3, asl #2]
	ldr	r2, .L25+4
	mov	r3, r4, asl #3
	add	r3, r3, r5
	str	r1, [r2, r3, asl #2]
	ldr	r3, [fp, #-16]
	add	r3, r3, #1
	str	r3, [fp, #-16]
.L21:
	ldr	r3, [fp, #-16]
	cmp	r3, #7
	ble	.L22
	ldr	r3, [fp, #-20]
	add	r3, r3, #1
	str	r3, [fp, #-20]
.L20:
	ldr	r3, [fp, #-20]
	cmp	r3, #7
	ble	.L23
	sub	sp, fp, #8
	ldmfd	sp!, {r4, r5, fp}
	bx	lr
.L26:
	.align	2
.L25:
	.word	g_pixel_matrix
	.word	g_current_group
	.size	get_next_group, .-get_next_group
	.align	2
	.global	scale_up
	.type	scale_up, %function
scale_up:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #20
	str	r0, [fp, #-16]
	ldr	r3, [fp, #-16]
	mov	r3, r3, asr #7
	str	r3, [fp, #-16]
	ldr	r3, .L29
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	mul	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
.L30:
	.align	2
.L29:
	.word	SQRT2
	.size	scale_up, .-scale_up
	.align	2
	.global	loefflers
	.type	loefflers, %function
loefflers:
	@ args = 0, pretend = 0, frame = 72
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #72
	str	r0, [fp, #-72]
	ldr	r3, [fp, #-72]
	ldr	r3, [r3, #0]
	str	r3, [fp, #-68]
	ldr	r3, [fp, #-72]
	add	r3, r3, #4
	ldr	r3, [r3, #0]
	str	r3, [fp, #-64]
	ldr	r3, [fp, #-72]
	add	r3, r3, #8
	ldr	r3, [r3, #0]
	str	r3, [fp, #-60]
	ldr	r3, [fp, #-72]
	add	r3, r3, #12
	ldr	r3, [r3, #0]
	str	r3, [fp, #-56]
	ldr	r3, [fp, #-72]
	add	r3, r3, #16
	ldr	r3, [r3, #0]
	str	r3, [fp, #-52]
	ldr	r3, [fp, #-72]
	add	r3, r3, #20
	ldr	r3, [r3, #0]
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-72]
	add	r3, r3, #24
	ldr	r3, [r3, #0]
	str	r3, [fp, #-44]
	ldr	r3, [fp, #-72]
	add	r3, r3, #28
	ldr	r3, [r3, #0]
	str	r3, [fp, #-40]
	ldr	r2, [fp, #-68]
	ldr	r3, [fp, #-40]
	add	r3, r2, r3
	str	r3, [fp, #-36]
	ldr	r2, [fp, #-64]
	ldr	r3, [fp, #-44]
	add	r3, r2, r3
	str	r3, [fp, #-32]
	ldr	r2, [fp, #-60]
	ldr	r3, [fp, #-48]
	add	r3, r2, r3
	str	r3, [fp, #-28]
	ldr	r2, [fp, #-56]
	ldr	r3, [fp, #-52]
	add	r3, r2, r3
	str	r3, [fp, #-24]
	ldr	r2, [fp, #-56]
	ldr	r3, [fp, #-52]
	rsb	r3, r3, r2
	str	r3, [fp, #-20]
	ldr	r2, [fp, #-60]
	ldr	r3, [fp, #-48]
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r2, [fp, #-64]
	ldr	r3, [fp, #-44]
	rsb	r3, r3, r2
	str	r3, [fp, #-12]
	ldr	r2, [fp, #-68]
	ldr	r3, [fp, #-40]
	rsb	r3, r3, r2
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-36]
	str	r3, [fp, #-68]
	ldr	r3, [fp, #-32]
	str	r3, [fp, #-64]
	ldr	r3, [fp, #-28]
	str	r3, [fp, #-60]
	ldr	r3, [fp, #-24]
	str	r3, [fp, #-56]
	ldr	r2, [fp, #-68]
	ldr	r3, [fp, #-56]
	add	r3, r2, r3
	str	r3, [fp, #-36]
	ldr	r2, [fp, #-68]
	ldr	r3, [fp, #-56]
	rsb	r3, r3, r2
	str	r3, [fp, #-24]
	ldr	r2, [fp, #-64]
	ldr	r3, [fp, #-60]
	add	r3, r2, r3
	str	r3, [fp, #-32]
	ldr	r2, [fp, #-64]
	ldr	r3, [fp, #-60]
	rsb	r3, r3, r2
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-36]
	str	r3, [fp, #-68]
	ldr	r3, [fp, #-32]
	str	r3, [fp, #-64]
	ldr	r3, [fp, #-28]
	str	r3, [fp, #-60]
	ldr	r3, [fp, #-24]
	str	r3, [fp, #-56]
	ldr	r2, [fp, #-68]
	ldr	r3, [fp, #-64]
	add	r3, r2, r3
	str	r3, [fp, #-36]
	ldr	r2, [fp, #-68]
	ldr	r3, [fp, #-64]
	rsb	r3, r3, r2
	str	r3, [fp, #-32]
	ldr	r3, .L33
	ldr	r2, [r3, #8]
	ldr	r3, [fp, #-56]
	mul	r0, r3, r2
	ldr	r3, .L33+4
	ldr	r1, [r3, #8]
	ldr	r2, [fp, #-60]
	ldr	r3, [fp, #-56]
	add	r3, r2, r3
	mul	r3, r1, r3
	add	r3, r0, r3
	str	r3, [fp, #-28]
	ldr	r3, .L33+8
	ldr	r2, [r3, #8]
	ldr	r3, [fp, #-60]
	mul	r0, r3, r2
	ldr	r3, .L33+4
	ldr	r1, [r3, #8]
	ldr	r2, [fp, #-60]
	ldr	r3, [fp, #-56]
	add	r3, r2, r3
	mul	r3, r1, r3
	add	r3, r0, r3
	str	r3, [fp, #-24]
	ldr	r3, [fp, #-36]
	mov	r2, r3, asl #7
	ldr	r3, [fp, #-72]
	str	r2, [r3, #0]
	ldr	r3, [fp, #-72]
	add	r2, r3, #16
	ldr	r3, [fp, #-32]
	mov	r3, r3, asl #7
	str	r3, [r2, #0]
	ldr	r3, [fp, #-72]
	add	r2, r3, #8
	ldr	r3, [fp, #-28]
	mov	r3, r3, asr #7
	str	r3, [r2, #0]
	ldr	r3, [fp, #-72]
	add	r2, r3, #24
	ldr	r3, [fp, #-24]
	mov	r3, r3, asr #7
	str	r3, [r2, #0]
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-52]
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-12]
	str	r3, [fp, #-44]
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-40]
	ldr	r3, .L33
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-40]
	mul	r0, r3, r2
	ldr	r3, .L33+4
	ldr	r1, [r3, #4]
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-52]
	add	r3, r2, r3
	mul	r3, r1, r3
	add	r3, r0, r3
	str	r3, [fp, #-20]
	ldr	r3, .L33+8
	ldr	r2, [r3, #4]
	ldr	r3, [fp, #-52]
	mul	r0, r3, r2
	ldr	r3, .L33+4
	ldr	r1, [r3, #4]
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-52]
	add	r3, r2, r3
	mul	r3, r1, r3
	add	r3, r0, r3
	str	r3, [fp, #-8]
	ldr	r3, .L33
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-44]
	mul	r0, r3, r2
	ldr	r3, .L33+4
	ldr	r1, [r3, #0]
	ldr	r2, [fp, #-48]
	ldr	r3, [fp, #-44]
	add	r3, r2, r3
	mul	r3, r1, r3
	add	r3, r0, r3
	str	r3, [fp, #-16]
	ldr	r3, .L33+8
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-48]
	mul	r0, r3, r2
	ldr	r3, .L33+4
	ldr	r1, [r3, #0]
	ldr	r2, [fp, #-48]
	ldr	r3, [fp, #-44]
	add	r3, r2, r3
	mul	r3, r1, r3
	add	r3, r0, r3
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-52]
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-12]
	str	r3, [fp, #-44]
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-40]
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-44]
	add	r3, r2, r3
	str	r3, [fp, #-20]
	ldr	r2, [fp, #-52]
	ldr	r3, [fp, #-44]
	rsb	r3, r3, r2
	str	r3, [fp, #-12]
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-48]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-48]
	rsb	r3, r3, r2
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-20]
	str	r3, [fp, #-52]
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-12]
	str	r3, [fp, #-44]
	ldr	r3, [fp, #-8]
	str	r3, [fp, #-40]
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-52]
	add	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r2, [fp, #-40]
	ldr	r3, [fp, #-52]
	rsb	r3, r3, r2
	str	r3, [fp, #-20]
	ldr	r0, [fp, #-48]
	bl	scale_up
	mov	r3, r0
	str	r3, [fp, #-16]
	ldr	r0, [fp, #-44]
	bl	scale_up
	mov	r3, r0
	str	r3, [fp, #-12]
	ldr	r3, [fp, #-72]
	add	r2, r3, #28
	ldr	r3, [fp, #-20]
	mov	r3, r3, asr #7
	str	r3, [r2, #0]
	ldr	r3, [fp, #-72]
	add	r2, r3, #12
	ldr	r3, [fp, #-16]
	mov	r3, r3, asr #7
	str	r3, [r2, #0]
	ldr	r3, [fp, #-72]
	add	r2, r3, #20
	ldr	r3, [fp, #-12]
	mov	r3, r3, asr #7
	str	r3, [r2, #0]
	ldr	r3, [fp, #-72]
	add	r2, r3, #4
	ldr	r3, [fp, #-8]
	mov	r3, r3, asr #7
	str	r3, [r2, #0]
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
.L34:
	.align	2
.L33:
	.word	ROTATE_CONST_O1
	.word	ROTATE_CONST
	.word	ROTATE_CONST_O2
	.size	loefflers, .-loefflers
	.section	.rodata
	.align	2
.LC4:
	.ascii	"Error: 1 arg expected {filename}, received: %d\012\000"
	.align	2
.LC5:
	.ascii	"Filename: %s\012\000"
	.align	2
.LC6:
	.ascii	"\012----TESTING AREA----\000"
	.align	2
.LC7:
	.ascii	"\012Corner 8x8:\000"
	.global	__aeabi_i2d
	.global	__aeabi_ddiv
	.align	2
.LC8:
	.ascii	"%f, \000"
	.align	2
.LC9:
	.ascii	"\012Center 8x8:\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 312
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, fp, lr}
	add	fp, sp, #16
	sub	sp, sp, #316
	str	r0, [fp, #-320]
	str	r1, [fp, #-324]
	ldr	r3, [fp, #-320]
	cmp	r3, #2
	beq	.L36
	ldr	r3, [fp, #-320]
	sub	r3, r3, #1
	ldr	r0, .L59
	mov	r1, r3
	bl	printf
	mov	r3, #1
	str	r3, [fp, #-328]
	b	.L37
.L36:
	ldr	r3, [fp, #-324]
	add	r3, r3, #4
	ldr	r3, [r3, #0]
	ldr	r0, .L59+4
	mov	r1, r3
	bl	printf
	ldr	r0, .L59+8
	bl	puts
	ldr	r3, [fp, #-324]
	add	r3, r3, #4
	ldr	r3, [r3, #0]
	mov	r0, r3
	bl	get_image
	mov	r3, #0
	str	r3, [fp, #-60]
	b	.L38
.L49:
	mov	r3, #0
	str	r3, [fp, #-56]
	b	.L39
.L48:
	ldr	r3, [fp, #-60]
	mov	r2, r3, asl #3
	ldr	r3, [fp, #-56]
	mov	r3, r3, asl #3
	mov	r0, r2
	mov	r1, r3
	bl	get_next_group
	mov	r3, #0
	str	r3, [fp, #-52]
	b	.L40
.L41:
	ldr	r2, .L59+12
	ldr	r3, [fp, #-52]
	mov	r3, r3, asl #5
	add	r3, r2, r3
	mov	r0, r3
	bl	loefflers
	ldr	r3, [fp, #-52]
	add	r3, r3, #1
	str	r3, [fp, #-52]
.L40:
	ldr	r3, [fp, #-52]
	cmp	r3, #7
	ble	.L41
	sub	r3, fp, #316
	ldr	r0, .L59+12
	mov	r1, r3
	bl	transpose
	mov	r3, #0
	str	r3, [fp, #-48]
	b	.L42
.L43:
	sub	r2, fp, #316
	ldr	r3, [fp, #-48]
	mov	r3, r3, asl #5
	add	r3, r2, r3
	mov	r0, r3
	bl	loefflers
	ldr	r3, [fp, #-48]
	add	r3, r3, #1
	str	r3, [fp, #-48]
.L42:
	ldr	r3, [fp, #-48]
	cmp	r3, #7
	ble	.L43
	sub	r3, fp, #316
	mov	r0, r3
	ldr	r1, .L59+12
	bl	transpose
	mov	r3, #0
	str	r3, [fp, #-44]
	b	.L44
.L47:
	mov	r3, #0
	str	r3, [fp, #-40]
	b	.L45
.L46:
	ldr	r3, [fp, #-60]
	mov	r2, r3, asl #3
	ldr	r3, [fp, #-44]
	add	ip, r2, r3
	ldr	r3, [fp, #-56]
	mov	r2, r3, asl #3
	ldr	r3, [fp, #-40]
	add	lr, r2, r3
	ldr	r3, [fp, #-44]
	ldr	r2, [fp, #-40]
	ldr	r1, .L59+12
	mov	r3, r3, asl #3
	add	r3, r3, r2
	ldr	r1, [r1, r3, asl #2]
	ldr	r0, .L59+16
	mov	r3, ip
	mov	r3, r3, asl #6
	mov	r2, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, lr
	str	r1, [r0, r3, asl #2]
	ldr	r3, [fp, #-40]
	add	r3, r3, #1
	str	r3, [fp, #-40]
.L45:
	ldr	r3, [fp, #-40]
	cmp	r3, #7
	ble	.L46
	ldr	r3, [fp, #-44]
	add	r3, r3, #1
	str	r3, [fp, #-44]
.L44:
	ldr	r3, [fp, #-44]
	cmp	r3, #7
	ble	.L47
	ldr	r3, [fp, #-56]
	add	r3, r3, #1
	str	r3, [fp, #-56]
.L39:
	ldr	r3, [fp, #-56]
	cmp	r3, #29
	ble	.L48
	ldr	r3, [fp, #-60]
	add	r3, r3, #1
	str	r3, [fp, #-60]
.L38:
	ldr	r3, [fp, #-60]
	cmp	r3, #39
	ble	.L49
	ldr	r0, .L59+20
	bl	puts
	mov	r3, #0
	str	r3, [fp, #-36]
	b	.L50
.L53:
	mov	r3, #0
	str	r3, [fp, #-32]
	b	.L51
.L52:
	ldr	r3, [fp, #-36]
	ldr	r1, [fp, #-32]
	ldr	r0, .L59+16
	mov	r3, r3, asl #6
	mov	r2, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r3, [r0, r3, asl #2]
	mov	r0, r3
	bl	__aeabi_i2d
	mov	r5, r0
	mov	r6, r1
	ldr	r3, .L59+24
	ldr	r3, [r3, #0]
	mov	r0, r3
	bl	__aeabi_i2d
	mov	r3, r0
	mov	r4, r1
	mov	r0, r5
	mov	r1, r6
	mov	r2, r3
	mov	r3, r4
	bl	__aeabi_ddiv
	mov	r3, r0
	mov	r4, r1
	ldr	r0, .L59+28
	mov	r2, r3
	mov	r3, r4
	bl	printf
	ldr	r3, [fp, #-32]
	add	r3, r3, #1
	str	r3, [fp, #-32]
.L51:
	ldr	r3, [fp, #-32]
	cmp	r3, #7
	ble	.L52
	mov	r0, #10
	bl	putchar
	ldr	r3, [fp, #-36]
	add	r3, r3, #1
	str	r3, [fp, #-36]
.L50:
	ldr	r3, [fp, #-36]
	cmp	r3, #7
	ble	.L53
	ldr	r0, .L59+32
	bl	puts
	mov	r3, #0
	str	r3, [fp, #-28]
	b	.L54
.L57:
	mov	r3, #0
	str	r3, [fp, #-24]
	b	.L55
.L56:
	ldr	r3, [fp, #-28]
	add	r2, r3, #120
	ldr	r3, [fp, #-24]
	add	r1, r3, #160
	ldr	r0, .L59+16
	mov	r3, r2
	mov	r3, r3, asl #6
	mov	r2, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r3, [r0, r3, asl #2]
	mov	r0, r3
	bl	__aeabi_i2d
	mov	r5, r0
	mov	r6, r1
	ldr	r3, .L59+24
	ldr	r3, [r3, #0]
	mov	r0, r3
	bl	__aeabi_i2d
	mov	r3, r0
	mov	r4, r1
	mov	r0, r5
	mov	r1, r6
	mov	r2, r3
	mov	r3, r4
	bl	__aeabi_ddiv
	mov	r3, r0
	mov	r4, r1
	ldr	r0, .L59+28
	mov	r2, r3
	mov	r3, r4
	bl	printf
	ldr	r3, [fp, #-24]
	add	r3, r3, #1
	str	r3, [fp, #-24]
.L55:
	ldr	r3, [fp, #-24]
	cmp	r3, #7
	ble	.L56
	mov	r0, #10
	bl	putchar
	ldr	r3, [fp, #-28]
	add	r3, r3, #1
	str	r3, [fp, #-28]
.L54:
	ldr	r3, [fp, #-28]
	cmp	r3, #7
	ble	.L57
	mov	r3, #0
	str	r3, [fp, #-328]
.L37:
	ldr	r3, [fp, #-328]
	mov	r0, r3
	sub	sp, fp, #16
	ldmfd	sp!, {r4, r5, r6, fp, pc}
.L60:
	.align	2
.L59:
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	g_current_group
	.word	g_output_matrix
	.word	.LC7
	.word	END_SCALE
	.word	.LC8
	.word	.LC9
	.size	main, .-main
	.comm	g_pixel_matrix,307200,4
	.comm	g_output_matrix,307200,4
	.comm	g_current_group,256,4
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
