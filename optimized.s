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
	stmfd	sp!, {r4, r5, r6, r7}
	mov	r5, r0
	mov	r4, r1
	ldr	r1, .L15
	mov	r0, #0
	ldr	r7, .L15+4
	ldr	r6, .L15+8
	b	.L9
.L10:
	ldr	r3, [ip], #4
	str	r3, [r2], #4
	cmp	r1, r2
	bne	.L10
	add	r0, r0, #1
	add	r1, r1, #32
	cmp	r0, #8
	beq	.L14
.L9:
	add	r3, r0, r4
	mov	r2, r3, asl #6
	mov	r3, r3, asl #8
	add	r2, r2, r3
	add	r2, r2, r5
	mov	r2, r2, asl #2
	add	ip, r7, r2
	mov	r3, r0, asl #5
	add	r2, r6, r3
	b	.L10
.L14:
	ldmfd	sp!, {r4, r5, r6, r7}
	bx	lr
.L16:
	.align	2
.L15:
	.word	g_current_group+32
	.word	g_pixel_matrix
	.word	g_current_group
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
	.global	get_image
	.type	get_image, %function
get_image:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	mov	r4, r0
	ldr	r3, .L36
	ldr	r0, [r3, #0]
	bl	fflush
	mov	r0, r4
	ldr	r1, .L36+4
	bl	fopen
	subs	r6, r0, #0
	bne	.L26
	ldr	r0, .L36+8
	bl	perror
.L26:
	mov	r0, r6
	mov	r1, #54
	mov	r2, #0
	bl	fseek
	cmp	r0, #0
	beq	.L27
	ldr	r0, .L36+12
	bl	perror
.L27:
	mov	r0, r6
	mov	r1, #1024
	mov	r2, #1
	bl	fseek
	cmp	r0, #0
	beq	.L28
	ldr	r0, .L36+16
	bl	perror
	b	.L28
.L30:
	mov	r0, r6
	bl	fgetc
	cmn	r0, #1
	beq	.L29
	str	r0, [r5], #4
	add	r4, r4, #1
	cmp	r4, #320
	bne	.L30
.L29:
	add	r7, r7, #1
	cmp	r7, #240
	ldmeqfd	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
.L31:
	mov	r3, r7, asl #8
	mov	r2, r7, asl #10
	add	r3, r3, r2
	add	r5, r8, r3
	mov	r4, sl
	b	.L30
.L28:
	mov	r7, #0
	ldr	r8, .L36+20
	mov	sl, r7
	b	.L31
.L37:
	.align	2
.L36:
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
	@ args = 0, pretend = 0, frame = 304
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #316
	mov	r3, r0
	cmp	r0, #2
	beq	.L39
	ldr	r0, .L62
	sub	r1, r3, #1
	bl	printf
	mov	r0, #1
	b	.L40
.L39:
	mov	r4, r1
	ldr	r0, .L62+4
	ldr	r1, [r4, #4]!
	bl	printf
	ldr	r0, .L62+8
	bl	puts
	ldr	r0, [r4, #0]
	bl	get_image
	mov	r2, #0
	str	r2, [sp, #20]
	add	r6, sp, #52
	b	.L41
.L46:
	ldr	r3, [sp, #16]
	str	r3, [sp, #12]
	ldr	r0, [sp, #8]
	mov	r1, r3
	bl	get_next_group
	ldr	r5, .L62+12
	add	r9, sp, #32
	add	r8, sp, #44
	add	sl, sp, #36
	add	r7, sp, #40
.L42:
	ldr	r0, [r5, #0]
	ldr	r1, [r5, #28]
	add	r2, sp, #24
	mov	r3, r6
	bl	reflector
	ldr	r0, [r5, #4]
	ldr	r1, [r5, #24]
	add	r2, sp, #28
	mov	r3, fp
	bl	reflector
	ldr	r0, [r5, #8]
	ldr	r1, [r5, #20]
	mov	r2, r9
	mov	r3, r8
	bl	reflector
	ldr	r0, [r5, #12]
	ldr	r1, [r5, #16]
	mov	r2, sl
	mov	r3, r7
	bl	reflector
	ldr	r0, [sp, #24]
	ldr	r1, [sp, #36]
	add	r2, sp, #24
	mov	r3, sl
	bl	reflector
	ldr	r0, [sp, #28]
	ldr	r1, [sp, #32]
	add	r2, sp, #28
	mov	r3, r9
	bl	reflector
	ldr	r0, [sp, #24]
	ldr	r1, [sp, #28]
	add	r2, sp, #24
	add	r3, sp, #28
	bl	reflector
	str	sl, [sp, #0]
	ldr	r0, [sp, #32]
	ldr	r1, [sp, #36]
	mov	r2, #2
	mov	r3, r9
	bl	rotator
	ldr	r3, [sp, #24]
	mov	r3, r3, asl #7
	str	r3, [r5, #0]
	ldr	r3, [sp, #28]
	mov	r3, r3, asl #7
	str	r3, [r5, #16]
	ldr	r3, [sp, #32]
	mov	r3, r3, asr #7
	str	r3, [r5, #8]
	ldr	r3, [sp, #36]
	mov	r3, r3, asr #7
	str	r3, [r5, #24]
	str	r6, [sp, #0]
	ldr	r0, [sp, #40]
	ldr	r1, [sp, #52]
	mov	r2, #1
	mov	r3, r7
	bl	rotator
	str	fp, [sp, #0]
	ldr	r0, [sp, #44]
	ldr	r1, [sp, #48]
	mov	r2, #0
	mov	r3, r8
	bl	rotator
	ldr	r0, [sp, #40]
	ldr	r1, [sp, #48]
	mov	r2, r7
	mov	r3, fp
	bl	reflector
	ldr	r0, [sp, #52]
	ldr	r1, [sp, #44]
	mov	r2, r6
	mov	r3, r8
	bl	reflector
	ldr	r0, [sp, #52]
	ldr	r1, [sp, #40]
	mov	r2, r6
	mov	r3, r7
	bl	reflector
	ldr	r0, [sp, #44]
	bl	scale_up
	mov	r4, r0
	str	r0, [sp, #44]
	ldr	r0, [sp, #48]
	bl	scale_up
	str	r0, [sp, #48]
	ldr	r3, [sp, #40]
	mov	r3, r3, asr #7
	str	r3, [r5, #28]
	mov	r4, r4, asr #7
	str	r4, [r5, #12]
	mov	r0, r0, asr #7
	str	r0, [r5, #20]
	ldr	r3, [sp, #52]
	mov	r3, r3, asr #7
	str	r3, [r5, #4]
	add	r5, r5, #32
	ldr	r2, .L62+16
	cmp	r5, r2
	bne	.L42
	add	r4, sp, #56
	ldr	r0, .L62+12
	mov	r1, r4
	bl	transpose
	add	sl, sp, #32
	add	r7, sp, #44
	add	r8, sp, #36
	add	r5, sp, #40
	mov	r9, #2
.L43:
	ldr	r0, [r4, #0]
	ldr	r1, [r4, #28]
	add	r2, sp, #24
	mov	r3, r6
	bl	reflector
	ldr	r0, [r4, #4]
	ldr	r1, [r4, #24]
	add	r2, sp, #28
	mov	r3, fp
	bl	reflector
	ldr	r0, [r4, #8]
	ldr	r1, [r4, #20]
	mov	r2, sl
	mov	r3, r7
	bl	reflector
	ldr	r0, [r4, #12]
	ldr	r1, [r4, #16]
	mov	r2, r8
	mov	r3, r5
	bl	reflector
	ldr	r0, [sp, #24]
	ldr	r1, [sp, #36]
	add	r2, sp, #24
	mov	r3, r8
	bl	reflector
	ldr	r0, [sp, #28]
	ldr	r1, [sp, #32]
	add	r2, sp, #28
	mov	r3, sl
	bl	reflector
	ldr	r0, [sp, #24]
	ldr	r1, [sp, #28]
	add	r2, sp, #24
	add	r3, sp, #28
	bl	reflector
	str	r8, [sp, #0]
	ldr	r0, [sp, #32]
	ldr	r1, [sp, #36]
	mov	r2, r9
	mov	r3, sl
	bl	rotator
	ldr	r3, [sp, #24]
	mov	r3, r3, asl #7
	str	r3, [r4, #0]
	ldr	r3, [sp, #28]
	mov	r3, r3, asl #7
	str	r3, [r4, #16]
	ldr	r3, [sp, #32]
	mov	r3, r3, asr #7
	str	r3, [r4, #8]
	ldr	r3, [sp, #36]
	mov	r3, r3, asr #7
	str	r3, [r4, #24]
	str	r6, [sp, #0]
	ldr	r0, [sp, #40]
	ldr	r1, [sp, #52]
	mov	r2, #1
	mov	r3, r5
	bl	rotator
	str	fp, [sp, #0]
	ldr	r0, [sp, #44]
	ldr	r1, [sp, #48]
	mov	r2, #0
	mov	r3, r7
	bl	rotator
	ldr	r0, [sp, #40]
	ldr	r1, [sp, #48]
	mov	r2, r5
	mov	r3, fp
	bl	reflector
	ldr	r0, [sp, #52]
	ldr	r1, [sp, #44]
	mov	r2, r6
	mov	r3, r7
	bl	reflector
	ldr	r0, [sp, #52]
	ldr	r1, [sp, #40]
	mov	r2, r6
	mov	r3, r5
	bl	reflector
	ldr	r0, [sp, #44]
	bl	scale_up
	str	r0, [sp, #44]
	ldr	r0, [sp, #48]
	bl	scale_up
	str	r0, [sp, #48]
	ldr	r3, [sp, #40]
	mov	r3, r3, asr #7
	str	r3, [r4, #28]
	ldr	r3, [sp, #44]
	mov	r3, r3, asr #7
	str	r3, [r4, #12]
	ldr	r3, [sp, #48]
	mov	r3, r3, asr #7
	str	r3, [r4, #20]
	ldr	r3, [sp, #52]
	mov	r3, r3, asr #7
	str	r3, [r4, #4]
	add	r4, r4, #32
	add	r3, sp, #312
	cmp	r4, r3
	bne	.L43
	add	r0, sp, #56
	ldr	r1, .L62+12
	bl	transpose
	ldr	r2, .L62+12
	add	r0, r2, #32
	mov	ip, #0
	ldr	lr, .L62+20
	b	.L44
.L45:
	ldr	r3, [r1], #4
	str	r3, [r2], #4
	cmp	r1, r0
	bne	.L45
	add	ip, ip, #1
	add	r0, r0, #32
	cmp	ip, #8
	bne	.L44
	ldr	r3, [sp, #16]
	add	r3, r3, #8
	str	r3, [sp, #16]
	cmp	r3, #240
	bne	.L46
	ldr	r2, [sp, #20]
	add	r2, r2, #8
	str	r2, [sp, #20]
	cmp	r2, #320
	bne	.L41
	ldr	r0, .L62+24
	bl	puts
	mov	r5, #0
	ldr	r7, .L62+20
	mov	r8, r5
	ldr	sl, .L62+28
	mov	r9, #10
	b	.L47
.L48:
	ldr	r0, [r6], #4
	bl	__aeabi_i2d
	mov	r2, #0
	ldr	r3, .L62+32
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, sl
	bl	printf
	add	r4, r4, #1
	cmp	r4, #8
	bne	.L48
	mov	r0, r9
	bl	putchar
	add	r5, r5, #1
	cmp	r5, #8
	bne	.L47
	ldr	r0, .L62+36
	bl	puts
	ldr	r6, .L62+40
	add	r5, r5, #112
	ldr	r7, .L62+20
	ldr	r8, .L62+28
	mov	sl, #0
	ldr	fp, .L62+32
	mov	r9, #10
	b	.L49
.L50:
	ldr	r0, [r4], #4
	bl	__aeabi_i2d
	mov	r2, sl
	mov	r3, fp
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, r8
	bl	printf
	cmp	r4, r6
	bne	.L50
	mov	r0, r9
	bl	putchar
	add	r5, r5, #1
	add	r6, r6, #1280
	cmp	r5, #128
	bne	.L49
	mov	r0, #0
.L40:
	add	sp, sp, #316
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
.L49:
	mov	r3, r5, asl #8
	mov	r2, r5, asl #10
	add	r3, r3, r2
	add	r3, r3, #640
	add	r4, r7, r3
	b	.L50
.L47:
	mov	r3, r5, asl #8
	mov	r2, r5, asl #10
	add	r3, r3, r2
	add	r6, r7, r3
	mov	r4, r8
	b	.L48
.L44:
	mov	r3, ip, asl #5
	ldr	r2, .L62+12
	add	r1, r2, r3
	ldr	r3, [sp, #20]
	add	r2, ip, r3
	mov	r3, r2, asl #6
	mov	r2, r2, asl #8
	add	r3, r3, r2
	ldr	r2, [sp, #12]
	add	r3, r3, r2
	mov	r3, r3, asl #2
	add	r2, lr, r3
	b	.L45
.L41:
	ldr	r3, [sp, #20]
	str	r3, [sp, #8]
	mov	r2, #0
	str	r2, [sp, #16]
	add	fp, sp, #48
	b	.L46
.L63:
	.align	2
.L62:
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	g_current_group
	.word	g_current_group+256
	.word	g_output_matrix
	.word	.LC7
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
	.comm	g_current_group,256,4
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
