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
	add	ip, r0, #32
.L2:
	ldr	r3, [r0, #0]
	str	r3, [r1, #0]
	ldr	r2, [r0, #32]
	str	r2, [r1, #4]
	ldr	r3, [r0, #64]
	str	r3, [r1, #8]
	ldr	r2, [r0, #96]
	str	r2, [r1, #12]
	ldr	r3, [r0, #128]
	str	r3, [r1, #16]
	ldr	r2, [r0, #160]
	str	r2, [r1, #20]
	ldr	r3, [r0, #192]
	str	r3, [r1, #24]
	ldr	r2, [r0, #224]
	add	r0, r0, #4
	cmp	r0, ip
	str	r2, [r1, #28]
	add	r1, r1, #32
	bne	.L2
	bx	lr
	.size	transpose, .-transpose
	.align	2
	.global	get_next_group
	.type	get_next_group, %function
get_next_group:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, r1, asl #8
	mov	r1, r1, asl #6
	add	r1, r1, r3
	stmfd	sp!, {r4, r5, r6, r7, r8, sl}
	add	r1, r1, r0
	ldr	r7, .L10
	ldr	r3, .L10+4
	mov	r1, r1, asl #2
	add	r8, r3, r1
	add	sl, r7, #256
.L7:
	ldr	r3, [r8, #0]
	ldr	r2, [r8, #4]
	ldr	r1, [r8, #8]
	ldr	r0, [r8, #12]
	ldr	ip, [r8, #16]
	add	r4, r8, #20
	ldmia	r4, {r4, r5, r6}	@ phole ldm
	str	r3, [r7, #0]
	str	r2, [r7, #4]
	str	r1, [r7, #8]
	str	r0, [r7, #12]
	str	ip, [r7, #16]
	str	r4, [r7, #20]
	str	r5, [r7, #24]
	str	r6, [r7, #28]
	add	r7, r7, #32
	cmp	r7, sl
	add	r8, r8, #1280
	bne	.L7
	ldmfd	sp!, {r4, r5, r6, r7, r8, sl}
	bx	lr
.L11:
	.align	2
.L10:
	.word	g_current_group
	.word	g_pixel_matrix
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
	ldr	r3, .L26
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	mov	r4, r0
	ldr	r0, [r3, #0]
	bl	fflush
	mov	r0, r4
	ldr	r1, .L26+4
	bl	fopen
	subs	r6, r0, #0
	beq	.L24
.L15:
	mov	r0, r6
	mov	r1, #54
	mov	r2, #0
	bl	fseek
	cmp	r0, #0
	beq	.L16
	ldr	r0, .L26+8
	bl	perror
.L16:
	mov	r0, r6
	mov	r1, #1024
	mov	r2, #1
	bl	fseek
	cmp	r0, #0
	beq	.L17
	ldr	r0, .L26+12
	bl	perror
.L17:
	ldr	r8, .L26+16
	mov	r7, #0
.L18:
	mov	r3, r7, asl #8
	mov	r2, r7, asl #10
	add	r3, r3, r2
	add	r5, r8, r3
	mov	r4, #0
	b	.L20
.L25:
	cmp	r4, #320
	str	r0, [r5], #4
	beq	.L19
.L20:
	mov	r0, r6
	bl	fgetc
	cmn	r0, #1
	add	r4, r4, #1
	bne	.L25
.L19:
	add	r7, r7, #1
	cmp	r7, #240
	bne	.L18
	ldmfd	sp!, {r4, r5, r6, r7, r8, pc}
.L24:
	ldr	r0, .L26+20
	bl	perror
	b	.L15
.L27:
	.align	2
.L26:
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
	@ args = 0, pretend = 0, frame = 368
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	cmp	r0, #2
	sub	sp, sp, #372
	mov	r4, r1
	beq	.L29
	sub	r1, r0, #1
	ldr	r0, .L60
	bl	printf
	mov	r0, #1
.L30:
	add	sp, sp, #372
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, pc}
.L29:
	ldr	r1, [r1, #4]
	ldr	r0, .L60+4
	bl	printf
	ldr	r0, .L60+8
	bl	puts
	ldr	r0, [r4, #4]
	bl	get_image
	mov	r0, #0
	add	r1, sp, #144
	str	r0, [sp, #92]
	str	r1, [sp, #12]
.L31:
	ldr	ip, [sp, #92]
	mov	lr, #0
	mov	r2, ip, asl #6
	mov	r3, ip, asl #8
	add	r3, r2, r3
	str	r3, [sp, #16]
	str	lr, [sp, #88]
.L40:
	ldr	r2, [sp, #88]
	ldr	r4, [sp, #92]
	mov	r3, r2, asl #6
	mov	r2, r2, asl #8
	add	r3, r3, r2
	ldr	r5, .L60+12
	add	r3, r3, r4
	ldr	r7, .L60+16
	mov	r3, r3, asl #2
	str	r5, [sp, #96]
	add	r6, r7, r3
	mov	r8, r5
.L32:
	ldr	r3, [r6, #0]
	ldr	r2, [r6, #4]
	ldr	r1, [r6, #8]
	add	r0, r6, #12
	ldmia	r0, {r0, ip, lr}	@ phole ldm
	ldr	r4, [r6, #24]
	ldr	r5, [r6, #28]
	ldr	sl, .L60+20
	str	r3, [r8, #0]
	str	r2, [r8, #4]
	str	r1, [r8, #8]
	str	r0, [r8, #12]
	str	ip, [r8, #16]
	str	lr, [r8, #20]
	str	r4, [r8, #24]
	str	r5, [r8, #28]
	add	r8, r8, #32
	cmp	r8, sl
	str	r8, [sp, #100]
	add	r6, r6, #1280
	bne	.L32
	sub	fp, r8, #256
.L33:
	ldr	sl, [fp, #4]
	ldr	r9, [fp, #20]
	ldr	ip, [fp, #12]
	ldr	lr, [fp, #16]
	ldr	r3, [fp, #24]
	ldr	r2, [fp, #8]
	rsb	r7, lr, ip
	rsb	r6, r3, sl
	ldr	r0, [fp, #0]
	ldr	r1, [fp, #28]
	rsb	r2, r9, r2
	str	r2, [sp, #56]
	add	r5, r6, r2
	mov	ip, r7, asl #2
	mov	r2, r7, asl #4
	rsb	r8, r1, r0
	add	ip, ip, r2
	ldr	r2, [sp, #56]
	add	r4, r8, r7
	mov	r3, r6, asl #5
	mov	r1, r6, asl #2
	str	r5, [sp, #28]
	add	r1, r1, r3
	mov	lr, r4, asl #4
	mov	r3, r2, asl #4
	mov	r0, r5, asl #8
	mov	r5, r2, asl #2
	add	r5, r5, r3
	sub	lr, lr, r4, asl #2
	ldr	r3, [sp, #28]
	str	r4, [sp, #32]
	add	lr, lr, r4
	ldr	r4, [sp, #28]
	sub	r0, r0, r3, asl #2
	rsb	r0, r4, r0
	mov	r4, r5, asl #4
	mov	r3, ip, asl #2
	mov	r2, r1, asl #4
	rsb	r4, r5, r4
	ldr	r5, [sp, #32]
	add	ip, ip, r3
	add	r1, r1, r2
	mov	r3, r8, asl #7
	mov	lr, lr, asl #2
	add	ip, ip, r7
	add	r1, r1, r6
	add	lr, lr, r5
	sub	r3, r3, r8, asl #4
	add	r3, r3, r8
	mov	r2, lr, asl #8
	mov	r8, ip, asl #4
	mov	r5, r1, asl #2
	add	lr, lr, r2
	rsb	r8, ip, r8
	ldr	r2, [fp, #24]
	ldr	ip, [fp, #28]
	rsb	r5, r1, r5
	ldr	r1, [fp, #0]
	ldr	r6, [sp, #28]
	ldr	r7, [sp, #56]
	add	ip, ip, r1
	add	sl, r2, sl
	mov	r0, r0, asl #4
	str	ip, [sp, #44]
	str	sl, [sp, #48]
	add	r0, r0, r6
	ldr	sl, [fp, #12]
	ldr	r6, [fp, #8]
	add	r4, r4, r7
	ldr	r7, [fp, #16]
	ldr	ip, [sp, #48]
	ldr	r1, [sp, #44]
	add	r7, r7, sl
	add	r9, r9, r6
	ldr	r6, [sp, #32]
	rsb	sl, r9, ip
	rsb	r1, r7, r1
	ldr	ip, [sp, #56]
	str	r7, [sp, #52]
	mov	r2, r3, asl #2
	ldr	r7, [sp, #28]
	str	r1, [sp, #104]
	add	lr, lr, r6
	add	r3, r3, r2
	mov	r0, r0, asl #2
	mov	r4, r4, asl #5
	sub	r8, r8, r8, asl #4
	add	r8, lr, r8
	add	r0, r0, r7
	sub	lr, lr, r3, asl #3
	add	r4, r4, ip
	ldr	r3, [sp, #104]
	sub	r5, r5, r5, asl #3
	mov	r2, sl, asl #6
	add	r6, sl, r1
	sub	r4, r0, r4, asl #1
	sub	r2, r2, sl, asl #2
	add	r0, r0, r5
	mov	r1, r1, asl #9
	sub	r1, r1, r3, asl #6
	rsb	r5, r0, r8
	mov	r3, r6, asl #7
	mov	ip, r6, asl #4
	rsb	r2, sl, r2
	mov	r5, r5, asr #7
	add	ip, ip, r3
	mov	r2, r2, asl #3
	mov	r3, r1, asl #3
	str	r5, [sp, #36]
	rsb	r3, r1, r3
	add	r2, r2, sl
	ldr	r1, [sp, #104]
	mov	r2, r2, asl #6
	rsb	r7, r4, lr
	rsb	r3, r1, r3
	str	r2, [sp, #8]
	ldr	r2, [sp, #104]
	mov	r7, r7, asr #7
	mov	r3, r3, asl #2
	rsb	ip, r6, ip
	str	r7, [sp, #40]
	rsb	r3, r2, r3
	mov	r6, r5, asl #4
	sub	r6, r6, r5, asl #2
	mov	r1, ip, asl #5
	ldr	r5, [sp, #40]
	str	r3, [sp, #4]
	ldr	r3, [sp, #8]
	rsb	r1, ip, r1
	mov	r7, r7, asl #4
	mov	ip, r6, asl #4
	sub	r7, r7, r5, asl #2
	add	r2, r3, sl
	rsb	ip, r6, ip
	ldr	sl, [sp, #44]
	ldr	r6, [sp, #52]
	mov	r5, r7, asl #4
	rsb	r5, r7, r5
	ldr	r3, [sp, #48]
	add	r7, r6, sl
	ldr	r6, [sp, #36]
	add	r0, r0, r8
	ldr	sl, [sp, #4]
	ldr	r8, [sp, #40]
	add	r4, r4, lr
	mov	r1, r1, asl #1
	add	r9, r9, r3
	add	ip, ip, r6
	rsb	lr, r9, r7
	rsb	r2, r2, r1
	add	r6, r0, r4
	mov	ip, ip, asr #7
	add	r5, r5, r8
	add	r1, r1, sl
	add	r9, r9, r7
	rsb	r0, r4, r0
	str	ip, [fp, #12]
	mov	r9, r9, asl #7
	mov	lr, lr, asl #7
	mov	r1, r1, asr #7
	mov	r2, r2, asr #7
	mov	r0, r0, asr #7
	mov	r5, r5, asr #7
	mov	r6, r6, asr #7
	ldr	ip, [sp, #100]
	str	r9, [fp, #0]
	str	lr, [fp, #16]
	str	r1, [fp, #8]
	str	r2, [fp, #24]
	str	r0, [fp, #28]
	str	r5, [fp, #20]
	str	r6, [fp, #4]
	add	fp, fp, #32
	cmp	ip, fp
	bne	.L33
	add	lr, sp, #112
	ldr	r6, .L60+12
	str	lr, [sp, #84]
	add	r7, sp, #112
.L34:
	ldr	r8, .L60+24
	ldr	r3, [r6, #0]
	ldr	r2, [r6, #32]
	ldr	r1, [r6, #64]
	ldr	r0, [r6, #96]
	ldr	ip, [r6, #128]
	ldr	lr, [r6, #160]
	ldr	r4, [r6, #192]
	ldr	r5, [r6, #224]
	add	r6, r6, #4
	cmp	r6, r8
	str	r3, [r7, #0]
	str	r2, [r7, #4]
	str	r1, [r7, #8]
	str	r0, [r7, #12]
	str	ip, [r7, #16]
	str	lr, [r7, #20]
	str	r4, [r7, #24]
	str	r5, [r7, #28]
	add	r7, r7, #32
	bne	.L34
	add	fp, sp, #112
.L35:
	ldr	sl, [fp, #4]
	ldr	r9, [fp, #20]
	ldr	ip, [fp, #12]
	ldr	lr, [fp, #16]
	ldr	r3, [fp, #24]
	ldr	r2, [fp, #8]
	rsb	r7, lr, ip
	rsb	r6, r3, sl
	ldr	r0, [fp, #0]
	ldr	r1, [fp, #28]
	rsb	r2, r9, r2
	str	r2, [sp, #80]
	add	r5, r6, r2
	mov	ip, r7, asl #2
	mov	r2, r7, asl #4
	rsb	r8, r1, r0
	add	ip, ip, r2
	ldr	r2, [sp, #80]
	add	r4, r8, r7
	mov	r3, r6, asl #5
	mov	r1, r6, asl #2
	str	r5, [sp, #20]
	add	r1, r1, r3
	mov	lr, r4, asl #4
	mov	r3, r2, asl #4
	mov	r0, r5, asl #8
	mov	r5, r2, asl #2
	add	r5, r5, r3
	sub	lr, lr, r4, asl #2
	ldr	r3, [sp, #20]
	str	r4, [sp, #24]
	add	lr, lr, r4
	ldr	r4, [sp, #20]
	sub	r0, r0, r3, asl #2
	rsb	r0, r4, r0
	mov	r4, r5, asl #4
	mov	r3, ip, asl #2
	mov	r2, r1, asl #4
	rsb	r4, r5, r4
	ldr	r5, [sp, #24]
	add	ip, ip, r3
	add	r1, r1, r2
	mov	r3, r8, asl #7
	mov	lr, lr, asl #2
	add	ip, ip, r7
	add	r1, r1, r6
	add	lr, lr, r5
	sub	r3, r3, r8, asl #4
	add	r3, r3, r8
	mov	r2, lr, asl #8
	mov	r8, ip, asl #4
	mov	r5, r1, asl #2
	add	lr, lr, r2
	rsb	r8, ip, r8
	ldr	r2, [fp, #24]
	ldr	ip, [fp, #28]
	rsb	r5, r1, r5
	ldr	r1, [fp, #0]
	ldr	r6, [sp, #20]
	ldr	r7, [sp, #80]
	add	ip, ip, r1
	add	sl, r2, sl
	mov	r0, r0, asl #4
	str	ip, [sp, #68]
	str	sl, [sp, #72]
	add	r0, r0, r6
	ldr	sl, [fp, #12]
	ldr	r6, [fp, #8]
	add	r4, r4, r7
	ldr	r7, [fp, #16]
	ldr	ip, [sp, #72]
	ldr	r1, [sp, #68]
	add	r7, r7, sl
	add	r9, r9, r6
	ldr	r6, [sp, #24]
	rsb	sl, r9, ip
	rsb	r1, r7, r1
	ldr	ip, [sp, #80]
	str	r7, [sp, #76]
	mov	r2, r3, asl #2
	ldr	r7, [sp, #20]
	str	r1, [sp, #108]
	add	lr, lr, r6
	add	r3, r3, r2
	mov	r0, r0, asl #2
	mov	r4, r4, asl #5
	sub	r8, r8, r8, asl #4
	add	r8, lr, r8
	add	r0, r0, r7
	sub	lr, lr, r3, asl #3
	add	r4, r4, ip
	ldr	r3, [sp, #108]
	sub	r5, r5, r5, asl #3
	mov	r2, sl, asl #6
	add	r6, sl, r1
	sub	r4, r0, r4, asl #1
	sub	r2, r2, sl, asl #2
	add	r0, r0, r5
	mov	r1, r1, asl #9
	sub	r1, r1, r3, asl #6
	rsb	r5, r0, r8
	mov	r3, r6, asl #7
	mov	ip, r6, asl #4
	rsb	r2, sl, r2
	mov	r5, r5, asr #7
	add	ip, ip, r3
	mov	r2, r2, asl #3
	mov	r3, r1, asl #3
	str	r5, [sp, #60]
	rsb	r3, r1, r3
	add	r2, r2, sl
	ldr	r1, [sp, #108]
	mov	r2, r2, asl #6
	rsb	r7, r4, lr
	rsb	r3, r1, r3
	str	r2, [sp, #8]
	ldr	r2, [sp, #108]
	mov	r7, r7, asr #7
	mov	r3, r3, asl #2
	rsb	ip, r6, ip
	str	r7, [sp, #64]
	rsb	r3, r2, r3
	mov	r6, r5, asl #4
	sub	r6, r6, r5, asl #2
	mov	r1, ip, asl #5
	ldr	r5, [sp, #64]
	str	r3, [sp, #4]
	ldr	r3, [sp, #8]
	rsb	r1, ip, r1
	mov	r7, r7, asl #4
	mov	ip, r6, asl #4
	sub	r7, r7, r5, asl #2
	add	r2, r3, sl
	rsb	ip, r6, ip
	ldr	sl, [sp, #68]
	ldr	r6, [sp, #76]
	mov	r5, r7, asl #4
	ldr	r3, [sp, #72]
	add	r0, r0, r8
	rsb	r5, r7, r5
	ldr	r8, [sp, #64]
	add	r7, r6, sl
	ldr	r6, [sp, #60]
	ldr	sl, [sp, #4]
	add	r4, r4, lr
	mov	r1, r1, asl #1
	add	r9, r9, r3
	rsb	lr, r9, r7
	rsb	r2, r2, r1
	add	ip, ip, r6
	add	r5, r5, r8
	add	r6, r0, r4
	add	r1, r1, sl
	add	r9, r9, r7
	rsb	r0, r4, r0
	mov	ip, ip, asr #7
	mov	r9, r9, asl #7
	mov	lr, lr, asl #7
	mov	r1, r1, asr #7
	mov	r2, r2, asr #7
	mov	r0, r0, asr #7
	mov	r5, r5, asr #7
	mov	r6, r6, asr #7
	str	ip, [fp, #12]
	str	r9, [fp, #0]
	str	lr, [fp, #16]
	str	r1, [fp, #8]
	str	r2, [fp, #24]
	str	r0, [fp, #28]
	str	r5, [fp, #20]
	str	r6, [fp, #4]
	add	ip, sp, #368
	add	fp, fp, #32
	cmp	fp, ip
	bne	.L35
	ldr	r6, .L60+12
	ldr	r7, [sp, #84]
	ldr	r8, [sp, #12]
.L38:
	ldr	r4, [sp, #84]
	ldr	r2, [sp, #84]
	ldr	r1, [r4, #64]
	ldr	r3, [r2, #0]
	ldr	r0, [r4, #96]
	ldr	ip, [r4, #128]
	ldr	lr, [r4, #160]
	ldr	r5, [r7, #224]
	ldr	r2, [r2, #32]
	ldr	r4, [r4, #192]
	add	r7, r7, #4
	cmp	r7, r8
	str	r3, [r6, #0]
	str	r2, [r6, #4]
	str	r1, [r6, #8]
	str	r0, [r6, #12]
	str	ip, [r6, #16]
	str	lr, [r6, #20]
	str	r4, [r6, #24]
	str	r5, [r6, #28]
	str	r7, [sp, #84]
	add	r6, r6, #32
	bne	.L38
	ldr	lr, [sp, #16]
	ldr	r0, [sp, #88]
	ldr	r1, .L60+28
	add	r3, lr, r0
	mov	r3, r3, asl #2
	ldr	sl, [sp, #96]
	ldr	r7, [sp, #100]
	add	r6, r1, r3
.L37:
	ldr	r3, [sl, #0]
	ldr	r2, [sl, #4]
	ldr	r1, [sl, #8]
	add	r0, sl, #12
	ldmia	r0, {r0, ip, lr}	@ phole ldm
	ldr	r4, [sl, #24]
	ldr	r5, [sl, #28]
	add	sl, sl, #32
	cmp	sl, r7
	str	r3, [r6, #0]
	str	r2, [r6, #4]
	str	r1, [r6, #8]
	str	r0, [r6, #12]
	str	ip, [r6, #16]
	str	lr, [r6, #20]
	str	r4, [r6, #24]
	str	r5, [r6, #28]
	str	sl, [sp, #96]
	add	r6, r6, #1280
	bne	.L37
	ldr	r8, [sp, #88]
	add	r8, r8, #8
	cmp	r8, #240
	str	r8, [sp, #88]
	bne	.L40
	ldr	sl, [sp, #92]
	add	sl, sl, #8
	cmp	sl, #320
	str	sl, [sp, #92]
	bne	.L31
	ldr	r0, .L60+32
	bl	puts
	mov	r5, #0
.L42:
	mov	r3, r5, asl #8
	mov	r2, r5, asl #10
	ldr	r0, .L60+28
	add	r3, r3, r2
	add	r6, r0, r3
	mov	r4, #0
.L43:
	ldr	r0, [r6], #4
	bl	__aeabi_i2d
	mov	r2, #0
	ldr	r3, .L60+36
	bl	__aeabi_dmul
	add	r4, r4, #1
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L60+40
	bl	printf
	cmp	r4, #8
	bne	.L43
	add	r5, r5, #1
	mov	r0, #10
	bl	putchar
	cmp	r5, #8
	bne	.L42
	ldr	r0, .L60+44
	bl	puts
	mov	r6, #120
.L45:
	mov	r3, r6, asl #8
	mov	r2, r6, asl #10
	ldr	r1, .L60+28
	add	r3, r3, r2
	add	r4, r1, r3
	mov	r5, #0
.L46:
	ldr	r0, [r4, #640]
	bl	__aeabi_i2d
	mov	r2, #0
	ldr	r3, .L60+36
	bl	__aeabi_dmul
	add	r5, r5, #1
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L60+40
	bl	printf
	cmp	r5, #8
	add	r4, r4, #4
	bne	.L46
	add	r6, r6, #1
	mov	r0, #10
	bl	putchar
	cmp	r6, #128
	bne	.L45
	mov	r0, #0
	b	.L30
.L61:
	.align	2
.L60:
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	g_current_group
	.word	g_pixel_matrix
	.word	g_current_group+256
	.word	g_current_group+32
	.word	g_output_matrix
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
