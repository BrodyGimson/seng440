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
	.file	"optimized_pack.c"
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
	mov	r3, r1, asl #4
	mov	r1, r1, asl #6
	add	r3, r3, r1
	add	r3, r3, r0
	mov	r3, r3, asl #2
	ldr	r1, .L12
	add	r1, r1, r3
	mov	r0, r2
	mov	ip, #0
.L9:
	ldr	r2, [r1, #0]
	and	r3, r2, #255
	str	r3, [r0, #0]
	and	r3, r2, #65280
	mov	r3, r3, lsr #8
	str	r3, [r0, #4]
	and	r3, r2, #16711680
	mov	r3, r3, lsr #16
	str	r3, [r0, #8]
	mov	r2, r2, lsr #24
	str	r2, [r0, #12]
	ldr	r2, [r1, #4]
	and	r3, r2, #255
	str	r3, [r0, #16]
	and	r3, r2, #65280
	mov	r3, r3, lsr #8
	str	r3, [r0, #20]
	and	r3, r2, #16711680
	mov	r3, r3, lsr #16
	str	r3, [r0, #24]
	mov	r2, r2, lsr #24
	str	r2, [r0, #28]
	add	ip, ip, #1
	add	r1, r1, #320
	add	r0, r0, #32
	cmp	ip, #8
	bne	.L9
	bx	lr
.L13:
	.align	2
.L12:
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
	ldr	r4, .L18
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
.L19:
	.align	2
.L18:
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
	@ args = 0, pretend = 0, frame = 72
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #84
	mov	r4, r0
	mov	fp, r0
	ldr	r0, [r0, #0]
	ldr	r1, [fp, #28]!
	add	r2, sp, #48
	add	r3, sp, #76
	bl	reflector
	str	r4, [sp, #12]
	mov	r7, r4
	mov	r2, r4
	ldr	r0, [r2, #4]!
	str	r2, [sp, #12]
	ldr	r1, [r7, #24]!
	add	r2, sp, #52
	add	r3, sp, #72
	bl	reflector
	mov	r6, r4
	mov	r9, r4
	ldr	r0, [r6, #8]!
	ldr	r1, [r9, #20]!
	add	r2, sp, #56
	add	r3, sp, #68
	bl	reflector
	mov	sl, r4
	mov	r5, r4
	add	r8, sp, #60
	ldr	r0, [sl, #12]!
	ldr	r1, [r5, #16]!
	mov	r2, r8
	add	r3, sp, #64
	bl	reflector
	ldr	r0, [sp, #48]
	ldr	r1, [sp, #60]
	add	r2, sp, #16
	add	r3, sp, #28
	bl	reflector
	ldr	r0, [sp, #52]
	ldr	r1, [sp, #56]
	add	r2, sp, #20
	add	r3, sp, #24
	bl	reflector
	ldr	r0, [sp, #16]
	ldr	r1, [sp, #20]
	add	r2, sp, #48
	add	r3, sp, #52
	bl	reflector
	str	r8, [sp, #0]
	ldr	r0, [sp, #24]
	ldr	r1, [sp, #28]
	mov	r2, #2
	add	r3, sp, #56
	bl	rotator
	ldr	r3, [sp, #48]
	mov	r3, r3, asl #5
	str	r3, [r4, #0]
	ldr	r3, [sp, #52]
	mov	r3, r3, asl #5
	str	r3, [r5, #0]
	ldr	r3, [sp, #56]
	mov	r3, r3, asr #9
	str	r3, [r6, #0]
	ldr	r3, [sp, #60]
	mov	r3, r3, asr #9
	str	r3, [r7, #0]
	add	r5, sp, #32
	add	r4, sp, #44
	str	r4, [sp, #0]
	ldr	r0, [sp, #64]
	ldr	r1, [sp, #76]
	mov	r2, #1
	mov	r3, r5
	bl	rotator
	add	r3, sp, #40
	str	r3, [sp, #0]
	ldr	r0, [sp, #68]
	ldr	r1, [sp, #72]
	mov	r2, #0
	add	r3, sp, #36
	bl	rotator
	ldr	r0, [sp, #32]
	ldr	r1, [sp, #40]
	add	r2, sp, #64
	add	r3, sp, #72
	bl	reflector
	ldr	r0, [sp, #44]
	ldr	r1, [sp, #36]
	add	r2, sp, #76
	add	r3, sp, #68
	bl	reflector
	ldr	r0, [sp, #76]
	ldr	r1, [sp, #64]
	mov	r2, r4
	mov	r3, r5
	bl	reflector
	ldr	r0, [sp, #68]
	bl	scale_up
	mov	r4, r0
	ldr	r0, [sp, #72]
	bl	scale_up
	ldr	r3, [sp, #32]
	mov	r3, r3, asr #9
	str	r3, [fp, #0]
	mov	r4, r4, asr #9
	str	r4, [sl, #0]
	mov	r0, r0, asr #9
	str	r0, [r9, #0]
	ldr	r3, [sp, #44]
	mov	r3, r3, asr #9
	ldr	r2, [sp, #12]
	str	r3, [r2, #0]
	add	sp, sp, #84
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
	.size	loefflers, .-loefflers
	.align	2
	.global	get_image
	.type	get_image, %function
get_image:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, lr}
	mov	r4, r0
	ldr	r3, .L34
	ldr	r0, [r3, #0]
	bl	fflush
	mov	r0, r4
	ldr	r1, .L34+4
	bl	fopen
	subs	r6, r0, #0
	bne	.L25
	ldr	r0, .L34+8
	bl	perror
.L25:
	mov	r0, r6
	mov	r1, #54
	mov	r2, #0
	bl	fseek
	cmp	r0, #0
	beq	.L26
	ldr	r0, .L34+12
	bl	perror
.L26:
	mov	r0, r6
	mov	r1, #1024
	mov	r2, #1
	bl	fseek
	cmp	r0, #0
	beq	.L27
	ldr	r0, .L34+16
	bl	perror
	b	.L27
.L29:
	mov	r0, #0
	mov	r1, r8
	mov	r2, r7
	mov	r3, r6
	bl	fread
	cmp	r0, #0
	ble	.L28
	mov	r3, #0
	ldr	r3, [r3, #0]
	str	r3, [r5], #4
	add	r4, r4, #1
	cmp	r4, #80
	bne	.L29
.L28:
	add	sl, sl, #1
	cmp	sl, #240
	bne	.L30
	mov	r0, r6
	bl	fclose
	ldmfd	sp!, {r3, r4, r5, r6, r7, r8, r9, sl, fp, pc}
.L30:
	mov	r3, sl, asl #6
	mov	r2, sl, asl #8
	add	r3, r3, r2
	add	r5, r9, r3
	mov	r4, fp
	b	.L29
.L27:
	mov	sl, #0
	ldr	r9, .L34+20
	mov	fp, sl
	mov	r8, #4
	mov	r7, #1
	b	.L30
.L35:
	.align	2
.L34:
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
	@ args = 0, pretend = 0, frame = 528
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	sub	sp, sp, #532
	mov	r3, r0
	cmp	r0, #2
	beq	.L37
	ldr	r0, .L60
	sub	r1, r3, #1
	bl	printf
	mov	r0, #1
	b	.L38
.L37:
	mov	r4, r1
	ldr	r0, .L60+4
	ldr	r1, [r4, #4]!
	bl	printf
	ldr	r0, .L60+8
	bl	puts
	ldr	r0, [r4, #0]
	bl	get_image
	mov	r3, #0
	str	r3, [sp, #12]
	add	sl, sp, #272
	add	r9, sp, #16
	mov	r7, sl
	ldr	r8, .L60+12
	mov	fp, r9
	str	sl, [sp, #8]
	mov	r3, #0
	str	r3, [sp, #4]
	b	.L39
.L44:
	mov	r0, r5, asl #1
	mov	r1, r6
	mov	r2, r7
	bl	get_next_group
	mov	r4, r7
.L40:
	mov	r0, r4
	bl	loefflers
	add	r4, r4, #32
	add	r3, sp, #528
	cmp	r4, r3
	bne	.L40
	mov	r0, r7
	mov	r1, fp
	bl	transpose
	mov	r4, fp
.L41:
	mov	r0, r4
	bl	loefflers
	add	r4, r4, #32
	cmp	sl, r4
	bne	.L41
	mov	lr, r5, asl #3
	ldr	r0, [sp, #8]
	ldr	ip, [sp, #4]
	b	.L42
.L43:
	ldr	r3, [r1], #32
	str	r3, [r2], #4
	cmp	r1, r0
	bne	.L43
	add	ip, ip, #1
	add	r0, r0, #4
	cmp	ip, #8
	bne	.L42
	add	r5, r5, #1
	cmp	r5, #40
	bne	.L44
	ldr	r3, [sp, #12]
	add	r3, r3, #1
	str	r3, [sp, #12]
	cmp	r3, #30
	bne	.L39
	ldr	r0, .L60+16
	bl	puts
	sub	r5, r5, #40
	ldr	sl, .L60+12
	mov	r9, r5
	ldr	fp, .L60+20
	mov	r7, #0
	ldr	r8, .L60+24
	b	.L45
.L46:
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
	bne	.L46
	mov	r0, #10
	bl	putchar
	add	r5, r5, #1
	cmp	r5, #8
	bne	.L45
	ldr	r0, .L60+28
	bl	puts
	ldr	r6, .L60+32
	add	r5, r5, #112
	ldr	sl, .L60+12
	ldr	r9, .L60+20
	mov	r7, #0
	ldr	r8, .L60+24
	mov	fp, #10
	b	.L47
.L48:
	ldr	r0, [r4], #4
	bl	__aeabi_i2d
	mov	r2, r7
	mov	r3, r8
	bl	__aeabi_dmul
	mov	r2, r0
	mov	r3, r1
	mov	r0, r9
	bl	printf
	cmp	r6, r4
	bne	.L48
	mov	r0, fp
	bl	putchar
	add	r5, r5, #1
	add	r6, r6, #1280
	cmp	r5, #128
	bne	.L47
	mov	r0, #0
.L38:
	add	sp, sp, #532
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
.L47:
	mov	r3, r5, asl #8
	mov	r2, r5, asl #10
	add	r3, r3, r2
	add	r3, r3, #640
	add	r4, sl, r3
	b	.L48
.L45:
	mov	r3, r5, asl #8
	mov	r2, r5, asl #10
	add	r3, r3, r2
	add	r6, sl, r3
	mov	r4, r9
	b	.L46
.L42:
	mov	r3, ip, asl #2
	add	r1, r9, r3
	add	r2, ip, r6
	mov	r3, r2, asl #6
	mov	r2, r2, asl #8
	add	r3, r3, r2
	add	r3, r3, lr
	mov	r3, r3, asl #2
	add	r2, r8, r3
	b	.L43
.L39:
	ldr	r3, [sp, #12]
	mov	r6, r3, asl #3
	mov	r5, #0
	b	.L44
.L61:
	.align	2
.L60:
	.word	.LC4
	.word	.LC5
	.word	.LC6
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
	.comm	g_pixel_matrix,76800,4
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
	.word	80
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
