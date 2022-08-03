	.arch armv5
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
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
	str	r4, [sp, #-4]!
	mov	r4, r0
	mov	r0, #0
.L2:
	mov	r3, r0, asl #2
	add	ip, r4, r3
	mov	r2, #0
.L3:
	ldr	r3, [ip], #32
	str	r3, [r1, r2]
	add	r2, r2, #4
	cmp	r2, #32
	bne	.L3
	add	r0, r0, #1
	cmp	r0, #8
	add	r1, r1, #32
	bne	.L2
	ldmfd	sp!, {r4}
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
	ldr	r7, .L14
	ldr	r6, .L14+4
	mov	r5, r0
	mov	r4, r1
	mov	r0, #0
.L9:
	add	r3, r0, r4
	mov	r2, r3, asl #8
	mov	r3, r3, asl #6
	add	r3, r3, r2
	add	r3, r3, r5
	mov	r2, r0, asl #5
	mov	r3, r3, asl #2
	add	ip, r6, r2
	add	r1, r7, r3
	mov	r2, #0
.L10:
	add	r2, r2, #1
	ldr	r3, [r1], #4
	cmp	r2, #8
	str	r3, [ip], #4
	bne	.L10
	add	r0, r0, #1
	cmp	r0, #8
	bne	.L9
	ldmfd	sp!, {r4, r5, r6, r7}
	bx	lr
.L15:
	.align	2
.L14:
	.word	g_pixel_matrix
	.word	g_current_group
	.size	get_next_group, .-get_next_group
	.align	2
	.global	loefflers
	.type	loefflers, %function
loefflers:
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	ldr	r1, [r0, #12]
	ldr	r2, [r0, #16]
	ldr	r8, [r0, #8]
	rsb	sl, r2, r1
	ldr	r1, [r0, #20]
	sub	sp, sp, #48
	ldr	r3, [r0, #0]
	ldr	r4, [r0, #28]
	rsb	r8, r1, r8
	str	r8, [sp, #40]
	ldr	fp, [r0, #24]
	ldr	r2, [r0, #4]
	rsb	r9, r4, r3
	ldr	r4, [sp, #40]
	rsb	r8, fp, r2
	add	r3, r9, sl
	add	r4, r8, r4
	str	r4, [sp, #8]
	str	r3, [sp, #12]
	mov	r2, sl, asl #4
	mov	r4, sl, asl #2
	add	r4, r4, r2
	ldr	r2, [sp, #12]
	mov	r5, r3, asl #4
	mov	r1, r8, asl #2
	mov	r3, r8, asl #5
	add	r1, r1, r3
	sub	r5, r5, r2, asl #2
	ldr	r3, [sp, #8]
	ldr	r2, [sp, #40]
	mov	ip, r3, asl #8
	mov	r7, r2, asl #2
	mov	r3, r2, asl #4
	add	r7, r7, r3
	ldr	r3, [sp, #12]
	ldr	r2, [sp, #8]
	add	r5, r5, r3
	mov	r3, r4, asl #2
	add	r4, r4, r3
	ldr	r3, [sp, #8]
	sub	ip, ip, r2, asl #2
	mov	r2, r1, asl #4
	add	r1, r1, r2
	rsb	ip, r3, ip
	mov	r3, r9, asl #7
	add	r4, r4, sl
	add	r1, r1, r8
	sub	r3, r3, r9, asl #4
	ldr	r8, [sp, #12]
	add	r3, r3, r9
	mov	r5, r5, asl #2
	mov	r9, r4, asl #4
	add	r5, r5, r8
	ldr	sl, [sp, #8]
	ldr	r8, [r0, #0]
	rsb	r9, r4, r9
	ldr	r4, [r0, #28]
	ldr	r2, [sp, #40]
	mov	r6, r7, asl #4
	mov	ip, ip, asl #4
	add	r4, r4, r8
	rsb	r6, r7, r6
	add	ip, ip, sl
	ldr	sl, [r0, #4]
	str	r4, [sp, #24]
	ldr	r8, [r0, #12]
	add	r6, r6, r2
	mov	r7, r1, asl #2
	mov	r2, r5, asl #8
	ldr	r4, [r0, #16]
	add	fp, fp, sl
	add	r5, r5, r2
	rsb	r7, r1, r7
	ldr	r2, [r0, #8]
	ldr	r1, [r0, #20]
	ldr	sl, [sp, #24]
	add	r4, r4, r8
	rsb	sl, r4, sl
	add	r1, r1, r2
	str	fp, [sp, #28]
	str	r1, [sp, #32]
	rsb	fp, r1, fp
	str	r4, [sp, #36]
	str	sl, [sp, #44]
	ldr	r1, [sp, #12]
	ldr	r4, [sp, #8]
	ldr	r8, [sp, #40]
	mov	r2, r3, asl #2
	mov	ip, ip, asl #2
	mov	r6, r6, asl #5
	add	r5, r5, r1
	add	ip, ip, r4
	add	r3, r3, r2
	add	r6, r6, r8
	sub	r9, r9, r9, asl #4
	add	r9, r5, r9
	sub	r6, ip, r6, asl #1
	sub	r5, r5, r3, asl #3
	ldr	r3, [sp, #44]
	add	r8, fp, sl
	mov	r1, sl, asl #9
	rsb	sl, r6, r5
	sub	r1, r1, r3, asl #6
	mov	r2, fp, asl #6
	mov	r3, r8, asl #7
	mov	r4, r8, asl #4
	mov	sl, sl, asr #7
	str	sl, [sp, #20]
	sub	r2, r2, fp, asl #2
	add	r4, r4, r3
	mov	r3, r1, asl #3
	sub	r7, r7, r7, asl #3
	rsb	r2, fp, r2
	rsb	r3, r1, r3
	ldr	r1, [sp, #20]
	add	ip, ip, r7
	mov	r2, r2, asl #3
	mov	sl, sl, asl #4
	sub	sl, sl, r1, asl #2
	rsb	r7, ip, r9
	ldr	r1, [sp, #44]
	add	r2, r2, fp
	mov	r7, r7, asr #7
	mov	r2, r2, asl #6
	rsb	r4, r8, r4
	rsb	r3, r1, r3
	mov	r8, r7, asl #4
	str	r2, [sp, #0]
	ldr	r2, [sp, #44]
	sub	r8, r8, r7, asl #2
	mov	r1, r4, asl #5
	mov	r3, r3, asl #2
	rsb	r3, r2, r3
	str	r7, [sp, #16]
	rsb	r1, r4, r1
	mov	r7, sl, asl #4
	mov	r4, r8, asl #4
	str	r3, [sp, #4]
	rsb	r4, r8, r4
	ldr	r3, [sp, #0]
	rsb	r7, sl, r7
	ldr	r8, [sp, #36]
	ldr	sl, [sp, #24]
	add	r2, r3, fp
	add	fp, r8, sl
	ldr	r3, [sp, #32]
	ldr	r8, [sp, #28]
	add	ip, ip, r9
	add	sl, r3, r8
	ldr	r3, [sp, #16]
	mov	r1, r1, asl #1
	add	r4, r4, r3
	ldr	r3, [sp, #20]
	add	r6, r6, r5
	add	r7, r7, r3
	ldr	r3, [sp, #4]
	rsb	r2, r2, r1
	add	r5, ip, r6
	rsb	r8, sl, fp
	add	r1, r1, r3
	add	r9, sl, fp
	rsb	ip, r6, ip
	mov	r9, r9, asl #7
	mov	r8, r8, asl #7
	mov	r1, r1, asr #7
	mov	r2, r2, asr #7
	mov	ip, ip, asr #7
	mov	r4, r4, asr #7
	mov	r7, r7, asr #7
	mov	r5, r5, asr #7
	str	r5, [r0, #4]
	str	r9, [r0, #0]
	str	r8, [r0, #16]
	str	r1, [r0, #8]
	str	r2, [r0, #24]
	str	ip, [r0, #28]
	str	r4, [r0, #12]
	str	r7, [r0, #20]
	add	sp, sp, #48
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp}
	bx	lr
	.size	loefflers, .-loefflers
	.align	2
	.global	get_image
	.type	get_image, %function
get_image:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	ldr	r3, .L30
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	mov	r4, r0
	ldr	r0, [r3, #0]
	bl	fflush
	mov	r0, r4
	ldr	r1, .L30+4
	bl	fopen
	subs	r6, r0, #0
	beq	.L28
.L19:
	mov	r0, r6
	mov	r1, #54
	mov	r2, #0
	bl	fseek
	cmp	r0, #0
	beq	.L20
	ldr	r0, .L30+8
	bl	perror
.L20:
	mov	r0, r6
	mov	r1, #1024
	mov	r2, #1
	bl	fseek
	cmp	r0, #0
	beq	.L21
	ldr	r0, .L30+12
	bl	perror
.L21:
	ldr	r8, .L30+16
	mov	r7, #0
.L22:
	mov	r3, r7, asl #8
	mov	r2, r7, asl #10
	add	r3, r3, r2
	add	r5, r8, r3
	mov	r4, #0
	b	.L24
.L29:
	cmp	r4, #320
	str	r0, [r5], #4
	beq	.L23
.L24:
	mov	r0, r6
	bl	fgetc
	cmn	r0, #1
	add	r4, r4, #1
	bne	.L29
.L23:
	add	r7, r7, #1
	cmp	r7, #240
	bne	.L22
	ldmfd	sp!, {r4, r5, r6, r7, r8, pc}
.L28:
	ldr	r0, .L30+20
	bl	perror
	b	.L19
.L31:
	.align	2
.L30:
	.word	stdout
	.word	.LC0
	.word	.LC2
	.word	.LC3
	.word	g_pixel_matrix
	.word	.LC1
	.size	get_image, .-get_image
	.global	__aeabi_i2d
	.global	__aeabi_dmul
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 256
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	cmp	r0, #2
	sub	sp, sp, #260
	mov	r4, r1
	beq	.L33
	sub	r1, r0, #1
	ldr	r0, .L68
	bl	printf
	mov	r0, #1
.L34:
	add	sp, sp, #260
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
.L33:
	ldr	r1, [r1, #4]
	ldr	r0, .L68+4
	bl	printf
	ldr	r0, .L68+8
	bl	puts
	ldr	r0, [r4, #4]
	bl	get_image
	ldr	r8, .L68+12
	ldr	fp, .L68+16
	mov	r7, #0
	mov	sl, sp
	mov	r9, r8
.L35:
	mov	r6, #0
.L48:
	mov	ip, #0
.L36:
	add	r3, ip, r6
	mov	r2, r3, asl #8
	mov	r3, r3, asl #6
	add	r3, r3, r2
	ldr	r1, .L68+20
	add	r3, r3, r7
	mov	r2, ip, asl #5
	mov	r3, r3, asl #2
	add	r0, r1, r3
	add	r1, r8, r2
	mov	r2, #0
.L37:
	add	r2, r2, #1
	ldr	r3, [r0], #4
	cmp	r2, #8
	str	r3, [r1], #4
	bne	.L37
	add	ip, ip, #1
	cmp	ip, #8
	bne	.L36
	ldr	r8, .L68+12
	mov	r5, r8
	mov	r4, r8
.L39:
	mov	r0, r4
	bl	loefflers
	ldr	r3, .L68+24
	add	r4, r4, #32
	cmp	r4, r3
	bne	.L39
	mov	r4, sl
	mov	r0, sl
	mov	ip, #0
.L40:
	mov	r3, ip, asl #2
	add	r1, r9, r3
	mov	r2, #0
.L41:
	ldr	r3, [r1], #32
	str	r3, [r0, r2]
	add	r2, r2, #4
	cmp	r2, #32
	bne	.L41
	add	ip, ip, #1
	cmp	ip, #8
	add	r0, r0, #32
	bne	.L40
.L57:
	mov	r0, r4
	bl	loefflers
	add	r4, r4, #32
	add	r1, sp, #256
	cmp	r4, r1
	bne	.L57
	mov	r0, #0
.L43:
	mov	r3, r0, asl #2
	add	r1, sl, r3
	mov	r2, #0
.L44:
	ldr	r3, [r1], #32
	str	r3, [r5, r2]
	add	r2, r2, #4
	cmp	r2, #32
	bne	.L44
	add	r0, r0, #1
	cmp	r0, #8
	add	r5, r5, #32
	bne	.L43
	mov	ip, #0
.L45:
	add	r3, ip, r7
	mov	r2, r3, asl #8
	mov	r3, r3, asl #6
	add	r3, r3, r2
	add	r3, r3, r6
	mov	r2, ip, asl #5
	mov	r3, r3, asl #2
	add	r0, r9, r2
	add	r1, fp, r3
	mov	r2, #0
.L46:
	add	r2, r2, #1
	ldr	r3, [r0], #4
	cmp	r2, #8
	str	r3, [r1], #4
	bne	.L46
	add	ip, ip, #1
	cmp	ip, #8
	bne	.L45
	add	r6, r6, #8
	cmp	r6, #240
	bne	.L48
	add	r7, r7, #8
	cmp	r7, #320
	bne	.L35
	ldr	r0, .L68+28
	bl	puts
	mov	r5, #0
.L50:
	mov	r3, r5, asl #8
	mov	r2, r5, asl #10
	add	r3, r3, r2
	add	r6, fp, r3
	mov	r4, #0
.L51:
	ldr	r0, [r6], #4
	bl	__aeabi_i2d
	mov	r2, #0
	ldr	r3, .L68+32
	bl	__aeabi_dmul
	add	r4, r4, #1
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L68+36
	bl	printf
	cmp	r4, #8
	bne	.L51
	add	r5, r5, #1
	mov	r0, #10
	bl	putchar
	cmp	r5, #8
	bne	.L50
	ldr	r0, .L68+40
	bl	puts
	mov	r6, #120
.L53:
	mov	r3, r6, asl #8
	mov	r2, r6, asl #10
	add	r3, r3, r2
	add	r4, fp, r3
	mov	r5, #0
.L54:
	ldr	r0, [r4, #640]
	bl	__aeabi_i2d
	mov	r2, #0
	ldr	r3, .L68+32
	bl	__aeabi_dmul
	add	r5, r5, #1
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L68+36
	bl	printf
	cmp	r5, #8
	add	r4, r4, #4
	bne	.L54
	add	r6, r6, #1
	mov	r0, #10
	bl	putchar
	cmp	r6, #128
	bne	.L53
	mov	r0, #0
	b	.L34
.L69:
	.align	2
.L68:
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	g_current_group
	.word	g_output_matrix
	.word	g_pixel_matrix
	.word	g_current_group+256
	.word	.LC7
	.word	1058013184
	.word	.LC8
	.word	.LC9
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
	.type	ROTATE_CONST, %object
	.size	ROTATE_CONST, 12
ROTATE_CONST:
	.word	16069
	.word	13622
	.word	8866
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
