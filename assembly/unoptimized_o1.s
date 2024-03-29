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
	.file	"unoptimized.c"
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
	.global	loefflers
	.type	loefflers, %function
loefflers:
	@ args = 0, pretend = 0, frame = 56
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #68
	mov	r5, r0
	str	r0, [sp, #12]
	ldr	r0, [r0, #0]
	mov	r2, r5
	ldr	r1, [r2, #28]!
	str	r2, [sp, #12]
	add	r2, sp, #32
	add	r3, sp, #60
	bl	reflector
	str	r5, [sp, #16]
	str	r5, [sp, #20]
	add	r8, sp, #36
	mov	r3, r5
	ldr	r0, [r3, #4]!
	str	r3, [sp, #16]
	mov	r2, r5
	ldr	r1, [r2, #24]!
	str	r2, [sp, #20]
	mov	r2, r8
	add	r3, sp, #56
	bl	reflector
	str	r5, [sp, #24]
	str	r5, [sp, #28]
	add	r7, sp, #40
	add	r9, sp, #52
	mov	r3, r5
	ldr	r0, [r3, #8]!
	str	r3, [sp, #24]
	mov	r2, r5
	ldr	r1, [r2, #20]!
	str	r2, [sp, #28]
	mov	r2, r7
	mov	r3, r9
	bl	reflector
	mov	fp, r5
	mov	sl, r5
	add	r4, sp, #44
	add	r6, sp, #48
	ldr	r0, [fp, #12]!
	ldr	r1, [sl, #16]!
	mov	r2, r4
	mov	r3, r6
	bl	reflector
	ldr	r0, [sp, #32]
	ldr	r1, [sp, #44]
	add	r2, sp, #32
	mov	r3, r4
	bl	reflector
	ldr	r0, [sp, #36]
	ldr	r1, [sp, #40]
	mov	r2, r8
	mov	r3, r7
	bl	reflector
	add	r3, sp, #60
	str	r3, [sp, #0]
	ldr	r0, [sp, #48]
	ldr	r1, [sp, #60]
	mov	r2, #1
	mov	r3, r6
	bl	rotator
	add	r2, sp, #56
	str	r2, [sp, #0]
	ldr	r0, [sp, #52]
	ldr	r1, [sp, #56]
	mov	r2, #0
	mov	r3, r9
	bl	rotator
	ldr	r0, [sp, #32]
	ldr	r1, [sp, #36]
	add	r2, sp, #32
	mov	r3, r8
	bl	reflector
	str	r4, [sp, #0]
	ldr	r0, [sp, #40]
	ldr	r1, [sp, #44]
	mov	r2, #2
	mov	r3, r7
	bl	rotator
	ldr	r0, [sp, #48]
	ldr	r1, [sp, #56]
	mov	r2, r6
	add	r3, sp, #56
	bl	reflector
	ldr	r0, [sp, #60]
	ldr	r1, [sp, #52]
	add	r2, sp, #60
	mov	r3, r9
	bl	reflector
	ldr	r0, [sp, #60]
	ldr	r1, [sp, #48]
	add	r2, sp, #60
	mov	r3, r6
	bl	reflector
	ldr	r0, [sp, #52]
	bl	scale_up
	mov	r4, r0
	ldr	r0, [sp, #56]
	bl	scale_up
	ldr	r3, [sp, #32]
	mov	r3, r3, asl #5
	str	r3, [r5, #0]
	ldr	r3, [sp, #36]
	mov	r3, r3, asl #5
	str	r3, [sl, #0]
	ldr	r3, [sp, #40]
	mov	r3, r3, asr #9
	ldr	r2, [sp, #24]
	str	r3, [r2, #0]
	ldr	r3, [sp, #44]
	mov	r3, r3, asr #9
	ldr	r2, [sp, #20]
	str	r3, [r2, #0]
	ldr	r3, [sp, #48]
	mov	r3, r3, asr #9
	ldr	r2, [sp, #12]
	str	r3, [r2, #0]
	mov	r4, r4, asr #9
	str	r4, [fp, #0]
	mov	r0, r0, asr #9
	ldr	r3, [sp, #28]
	str	r0, [r3, #0]
	ldr	r3, [sp, #60]
	mov	r3, r3, asr #9
	ldr	r2, [sp, #16]
	str	r3, [r2, #0]
	add	sp, sp, #68
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
	ldr	r3, .L37
	ldr	r0, [r3, #0]
	bl	fflush
	mov	r0, r4
	ldr	r1, .L37+4
	bl	fopen
	subs	r6, r0, #0
	bne	.L28
	ldr	r0, .L37+8
	bl	perror
.L28:
	mov	r0, r6
	mov	r1, #54
	mov	r2, #0
	bl	fseek
	cmp	r0, #0
	beq	.L29
	ldr	r0, .L37+12
	bl	perror
.L29:
	mov	r0, r6
	mov	r1, #1024
	mov	r2, #1
	bl	fseek
	cmp	r0, #0
	beq	.L30
	ldr	r0, .L37+16
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
	bne	.L33
	mov	r0, r6
	bl	fclose
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
.L33:
	mov	r3, r7, asl #8
	mov	r2, r7, asl #10
	add	r3, r3, r2
	add	r5, r8, r3
	mov	r4, sl
	b	.L32
.L30:
	mov	r7, #0
	ldr	r8, .L37+20
	mov	sl, r7
	b	.L33
.L38:
	.align	2
.L37:
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
	@ args = 0, pretend = 0, frame = 272
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #276
	mov	r3, r0
	cmp	r0, #2
	beq	.L40
	ldr	r0, .L63
	sub	r1, r3, #1
	bl	printf
	mov	r0, #1
	b	.L41
.L40:
	mov	r4, r1
	ldr	r0, .L63+4
	ldr	r1, [r4, #4]!
	bl	printf
	ldr	r0, .L63+8
	bl	puts
	ldr	r0, [r4, #0]
	bl	get_image
	mov	r5, #0
	ldr	r8, .L63+12
	ldr	r9, .L63+16
	add	r3, r8, #32
	ldr	fp, .L63+20
	add	sl, sp, #16
	str	r3, [sp, #8]
	str	r5, [sp, #4]
	b	.L42
.L47:
	mov	r6, r7
	mov	r0, r7
	ldr	r1, [sp, #12]
	bl	get_next_group
	mov	r4, r8
.L43:
	mov	r0, r4
	bl	loefflers
	add	r4, r4, #32
	cmp	r4, r9
	bne	.L43
	mov	r0, r8
	mov	r1, sl
	bl	transpose
	mov	r4, sl
.L44:
	mov	r0, r4
	bl	loefflers
	add	r4, r4, #32
	add	r3, sp, #272
	cmp	r4, r3
	bne	.L44
	mov	r0, sl
	mov	r1, r8
	bl	transpose
	ldr	r0, [sp, #8]
	ldr	ip, [sp, #4]
	b	.L45
.L46:
	ldr	r3, [r1], #4
	str	r3, [r2], #4
	cmp	r1, r0
	bne	.L46
	add	ip, ip, #1
	add	r0, r0, #32
	cmp	ip, #8
	bne	.L45
	add	r7, r7, #8
	cmp	r7, #320
	bne	.L47
	add	r5, r5, #8
	cmp	r5, #240
	bne	.L42
	ldr	r0, .L63+24
	bl	puts
	sub	r5, r5, #240
	ldr	sl, .L63+20
	mov	r9, r5
	ldr	fp, .L63+28
	mov	r7, #0
	ldr	r8, .L63+32
	b	.L48
.L49:
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
	bne	.L49
	mov	r0, #10
	bl	putchar
	add	r5, r5, #1
	cmp	r5, #8
	bne	.L48
	ldr	r0, .L63+36
	bl	puts
	ldr	r6, .L63+40
	add	r5, r5, #112
	ldr	sl, .L63+20
	ldr	r9, .L63+28
	mov	r7, #0
	ldr	r8, .L63+32
	mov	fp, #10
	b	.L50
.L51:
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
	bne	.L51
	mov	r0, fp
	bl	putchar
	add	r5, r5, #1
	add	r6, r6, #1280
	cmp	r5, #128
	bne	.L50
	mov	r0, #0
.L41:
	add	sp, sp, #276
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
.L50:
	mov	r3, r5, asl #8
	mov	r2, r5, asl #10
	add	r3, r3, r2
	add	r3, r3, #640
	add	r4, sl, r3
	b	.L51
.L48:
	mov	r3, r5, asl #8
	mov	r2, r5, asl #10
	add	r3, r3, r2
	add	r6, sl, r3
	mov	r4, r9
	b	.L49
.L45:
	mov	r3, ip, asl #5
	add	r1, r8, r3
	add	r2, ip, r5
	mov	r3, r2, asl #6
	mov	r2, r2, asl #8
	add	r3, r3, r2
	add	r3, r3, r6
	mov	r3, r3, asl #2
	add	r2, fp, r3
	b	.L46
.L42:
	str	r5, [sp, #12]
	mov	r7, #0
	b	.L47
.L64:
	.align	2
.L63:
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	g_current_group
	.word	g_current_group+256
	.word	g_output_matrix
	.word	.LC7
	.word	.LC8
	.word	1062207488
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
