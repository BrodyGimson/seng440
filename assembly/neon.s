	.arch armv5
	.eabi_attribute 27, 3
	.fpu neon
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 18, 4
	.file	"neon.c"
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
	.global	ROTATE_CONST_p_output_1
	.align	2
	.type	ROTATE_CONST_p_output_1, %object
	.size	ROTATE_CONST_p_output_1, 12
ROTATE_CONST_p_output_1:
	.word	-12873
	.word	-4520
	.word	12539
	.global	ROTATE_CONST_p_output_2
	.align	2
	.type	ROTATE_CONST_p_output_2, %object
	.size	ROTATE_CONST_p_output_2, 12
ROTATE_CONST_p_output_2:
	.word	-19266
	.word	-22725
	.word	-30273
	.global	END_SCALE
	.align	2
	.type	END_SCALE, %object
	.size	END_SCALE, 4
END_SCALE:
	.word	1024
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
	ldr	r0, [fp, #-24]
	bl	fclose
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
	@ args = 0, pretend = 0, frame = 680
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, fp}
	add	fp, sp, #12
	sub	sp, sp, #680
	str	r0, [fp, #-680]
	str	r1, [fp, #-684]
	mov	r3, #0
	str	r3, [fp, #-68]
	b	.L14
.L15:
	sub	r2, fp, #580
	ldr	r3, [fp, #-68]
	mov	r3, r3, asl #5
	add	r1, r2, r3
	ldr	r3, [fp, #-68]
	mov	r2, r3, asl #5
	ldr	r3, [fp, #-680]
	add	r3, r3, r2
	str	r1, [fp, #-52]
	sub	r4, fp, #612
	mov	ip, r3
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	r4!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	r4, {r0, r1, r2, r3}
	sub	r0, fp, #644
	str	r0, [fp, #-688]
	mov	r3, #0
	ldr	r1, [fp, #-688]
	str	r3, [r1, #0]
	ldr	r2, [fp, #-688]
	add	r2, r2, #4
	str	r2, [fp, #-688]
	mov	r3, #0
	ldr	r0, [fp, #-688]
	str	r3, [r0, #0]
	ldr	r1, [fp, #-688]
	add	r1, r1, #4
	str	r1, [fp, #-688]
	mov	r3, #0
	ldr	r2, [fp, #-688]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-688]
	add	r3, r3, #4
	str	r3, [fp, #-688]
	mov	r3, #0
	ldr	r0, [fp, #-688]
	str	r3, [r0, #0]
	ldr	r1, [fp, #-688]
	add	r1, r1, #4
	str	r1, [fp, #-688]
	mov	r3, #0
	ldr	r2, [fp, #-688]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-688]
	add	r3, r3, #4
	str	r3, [fp, #-688]
	mov	r3, #0
	ldr	r0, [fp, #-688]
	str	r3, [r0, #0]
	ldr	r1, [fp, #-688]
	add	r1, r1, #4
	str	r1, [fp, #-688]
	mov	r3, #0
	ldr	r2, [fp, #-688]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-688]
	add	r3, r3, #4
	str	r3, [fp, #-688]
	mov	r3, #0
	ldr	r0, [fp, #-688]
	str	r3, [r0, #0]
	ldr	r1, [fp, #-688]
	add	r1, r1, #4
	sub	r4, fp, #644
	sub	ip, fp, #612
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	r4!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	r4, {r0, r1, r2, r3}
	ldr	r3, .L23
	sub	r2, fp, #12
	add	r3, r2, r3
	vldmia	r3, {d16-d19}
	ldr	r3, [fp, #-52]
	vst4.32	{d16-d19}, [r3]
	ldr	r3, [fp, #-68]
	add	r3, r3, #1
	str	r3, [fp, #-68]
.L14:
	ldr	r3, [fp, #-68]
	cmp	r3, #7
	ble	.L15
	mov	r3, #0
	str	r3, [fp, #-64]
	b	.L16
.L19:
	mov	r3, #0
	str	r3, [fp, #-60]
	b	.L17
.L18:
	ldr	r4, [fp, #-60]
	ldr	r3, [fp, #-64]
	mov	r5, r3, asr #1
	ldr	r2, [fp, #-64]
	mov	r3, r2, asr #31
	mov	r1, r3, lsr #31
	add	r3, r2, r1
	and	r3, r3, #1
	rsb	r3, r1, r3
	mov	r6, r3
	ldr	r0, [fp, #-64]
	ldr	r3, [fp, #-60]
	mov	ip, r3, asr #1
	ldr	r2, [fp, #-60]
	mov	r3, r2, asr #31
	mov	r1, r3, lsr #31
	add	r3, r2, r1
	and	r3, r3, #1
	rsb	r3, r1, r3
	mov	r2, r3
	mov	r3, r0, asl #2
	add	r3, r3, ip
	mov	r3, r3, asl #1
	add	r3, r3, r2
	ldr	r2, .L23+4
	mov	r3, r3, asl #2
	sub	r0, fp, #12
	add	r3, r0, r3
	add	r3, r3, r2
	ldr	r1, [r3, #0]
	mov	r3, r4, asl #2
	add	r3, r3, r5
	mov	r3, r3, asl #1
	add	r3, r3, r6
	ldr	r2, .L23+8
	mov	r3, r3, asl #2
	sub	r0, fp, #12
	add	r3, r0, r3
	add	r3, r3, r2
	str	r1, [r3, #0]
	ldr	r3, [fp, #-60]
	add	r3, r3, #1
	str	r3, [fp, #-60]
.L17:
	ldr	r3, [fp, #-60]
	cmp	r3, #7
	ble	.L18
	ldr	r3, [fp, #-64]
	add	r3, r3, #1
	str	r3, [fp, #-64]
.L16:
	ldr	r3, [fp, #-64]
	cmp	r3, #7
	ble	.L19
	mov	r3, #0
	str	r3, [fp, #-56]
	b	.L20
.L21:
	ldr	r3, [fp, #-56]
	mov	r2, r3, asl #5
	ldr	r3, [fp, #-684]
	add	r5, r3, r2
	sub	r2, fp, #324
	ldr	r3, [fp, #-56]
	mov	r3, r3, asl #5
	add	r3, r2, r3
	str	r3, [fp, #-48]
	ldr	r3, [fp, #-48]
	vld4.32	{d16-d19}, [r3]
	ldr	r3, .L23+12
	sub	r1, fp, #12
	add	r3, r1, r3
	vstmia	r3, {d16-d19}
	sub	r4, fp, #44
	sub	ip, fp, #676
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	r4!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	r4, {r0, r1, r2, r3}
	mov	r4, r5
	sub	ip, fp, #44
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	r4!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	r4, {r0, r1, r2, r3}
	ldr	r3, [fp, #-56]
	add	r3, r3, #1
	str	r3, [fp, #-56]
.L20:
	ldr	r3, [fp, #-56]
	cmp	r3, #7
	ble	.L21
	sub	sp, fp, #12
	ldmfd	sp!, {r4, r5, r6, fp}
	bx	lr
.L24:
	.align	2
.L23:
	.word	-632
	.word	-568
	.word	-312
	.word	-664
	.size	transpose, .-transpose
	.align	2
	.global	get_next_group
	.type	get_next_group, %function
get_next_group:
	@ args = 0, pretend = 0, frame = 208
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, fp}
	add	fp, sp, #8
	sub	sp, sp, #212
	str	r0, [fp, #-208]
	str	r1, [fp, #-212]
	mov	r3, #0
	str	r3, [fp, #-64]
	b	.L26
.L29:
	mov	r3, #0
	str	r3, [fp, #-60]
	b	.L27
.L28:
	ldr	r2, [fp, #-212]
	ldr	r3, [fp, #-64]
	add	r1, r2, r3
	ldr	r2, [fp, #-208]
	ldr	r3, [fp, #-60]
	add	r0, r2, r3
	ldr	ip, .L31
	mov	r3, r1
	mov	r3, r3, asl #6
	mov	r2, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r0
	ldr	r3, [ip, r3, asl #2]
	str	r3, [fp, #-104]
	ldr	r2, [fp, #-212]
	ldr	r3, [fp, #-64]
	add	r1, r2, r3
	ldr	r2, [fp, #-208]
	ldr	r3, [fp, #-60]
	add	r3, r2, r3
	add	r0, r3, #1
	ldr	ip, .L31
	mov	r3, r1
	mov	r3, r3, asl #6
	mov	r2, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r0
	ldr	r3, [ip, r3, asl #2]
	str	r3, [fp, #-100]
	ldr	r3, [fp, #-60]
	mov	r3, r3, asr #1
	ldr	r1, [fp, #-104]
	mvn	r2, #83
	mov	r3, r3, asl #3
	sub	r0, fp, #12
	add	r3, r0, r3
	add	r3, r3, r2
	str	r1, [r3, #0]
	ldr	r3, [fp, #-60]
	mov	r3, r3, asr #1
	ldr	r1, [fp, #-100]
	mov	r3, r3, asl #1
	add	r3, r3, #1
	mvn	r2, #83
	mov	r3, r3, asl #2
	sub	r0, fp, #12
	add	r3, r0, r3
	add	r3, r3, r2
	str	r1, [r3, #0]
	ldr	r3, [fp, #-60]
	add	r3, r3, #2
	str	r3, [fp, #-60]
.L27:
	ldr	r3, [fp, #-60]
	cmp	r3, #7
	ble	.L28
	ldr	r5, [fp, #-64]
	sub	r3, fp, #96
	str	r3, [fp, #-56]
	ldr	r3, [fp, #-56]
	vld4.32	{d16-d19}, [r3]
	mvn	r3, #159
	sub	r2, fp, #12
	add	r3, r2, r3
	vstmia	r3, {d16-d19}
	sub	r4, fp, #52
	sub	ip, fp, #172
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	r4!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	r4, {r0, r1, r2, r3}
	ldr	r3, .L31+4
	mov	r4, r5, asl #5
	add	r4, r3, r4
	sub	ip, fp, #52
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	r4!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	r4, {r0, r1, r2, r3}
	sub	r3, fp, #136
	ldr	r2, [fp, #-64]
	str	r3, [fp, #-16]
	mov	r3, r2
	ldr	r2, .L31+4
	sub	r4, fp, #172
	mov	ip, r3, asl #5
	add	ip, r2, ip
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	r4!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	r4, {r0, r1, r2, r3}
	sub	r3, fp, #204
	str	r3, [fp, #-216]
	mov	r3, #0
	ldr	r0, [fp, #-216]
	str	r3, [r0, #0]
	ldr	r2, [fp, #-216]
	add	r2, r2, #4
	str	r2, [fp, #-216]
	mov	r3, #0
	ldr	r0, [fp, #-216]
	str	r3, [r0, #0]
	ldr	r2, [fp, #-216]
	add	r2, r2, #4
	str	r2, [fp, #-216]
	mov	r3, #0
	ldr	r0, [fp, #-216]
	str	r3, [r0, #0]
	ldr	r2, [fp, #-216]
	add	r2, r2, #4
	str	r2, [fp, #-216]
	mov	r3, #0
	ldr	r0, [fp, #-216]
	str	r3, [r0, #0]
	ldr	r2, [fp, #-216]
	add	r2, r2, #4
	str	r2, [fp, #-216]
	mov	r3, #0
	ldr	r0, [fp, #-216]
	str	r3, [r0, #0]
	ldr	r2, [fp, #-216]
	add	r2, r2, #4
	str	r2, [fp, #-216]
	mov	r3, #0
	ldr	r0, [fp, #-216]
	str	r3, [r0, #0]
	ldr	r2, [fp, #-216]
	add	r2, r2, #4
	str	r2, [fp, #-216]
	mov	r3, #0
	ldr	r0, [fp, #-216]
	str	r3, [r0, #0]
	ldr	r2, [fp, #-216]
	add	r2, r2, #4
	str	r2, [fp, #-216]
	mov	r3, #0
	ldr	r0, [fp, #-216]
	str	r3, [r0, #0]
	ldr	r2, [fp, #-216]
	add	r2, r2, #4
	sub	r4, fp, #204
	sub	ip, fp, #172
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	r4!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	r4, {r0, r1, r2, r3}
	mvn	r3, #191
	sub	r0, fp, #12
	add	r3, r0, r3
	vldmia	r3, {d16-d19}
	ldr	r3, [fp, #-16]
	vst4.32	{d16-d19}, [r3]
	ldr	r3, [fp, #-64]
	add	r3, r3, #1
	str	r3, [fp, #-64]
.L26:
	ldr	r3, [fp, #-64]
	cmp	r3, #7
	ble	.L29
	sub	sp, fp, #8
	ldmfd	sp!, {r4, r5, fp}
	bx	lr
.L32:
	.align	2
.L31:
	.word	g_pixel_matrix
	.word	g_current_group
	.size	get_next_group, .-get_next_group
	.align	2
	.global	reflector
	.type	reflector, %function
reflector:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #28
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	str	r2, [fp, #-16]
	str	r3, [fp, #-20]
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-12]
	add	r2, r2, r3
	ldr	r3, [fp, #-16]
	str	r2, [r3, #0]
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-12]
	rsb	r2, r3, r2
	ldr	r3, [fp, #-20]
	str	r2, [r3, #0]
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
	.size	reflector, .-reflector
	.section	.rodata
	.align	2
	.type	C.259.18543, %object
	.size	C.259.18543, 12
C.259.18543:
	.word	16069
	.word	13622
	.word	8866
	.text
	.align	2
	.global	rotator
	.type	rotator, %function
rotator:
	@ args = 4, pretend = 0, frame = 32
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!
	add	fp, sp, #0
	sub	sp, sp, #36
	str	r0, [fp, #-24]
	str	r1, [fp, #-28]
	str	r2, [fp, #-32]
	str	r3, [fp, #-36]
	ldr	r3, .L37
	sub	ip, fp, #16
	ldmia	r3, {r0, r1, r2}
	stmia	ip, {r0, r1, r2}
	ldr	r2, [fp, #-32]
	ldr	r3, .L37+4
	ldr	r2, [r3, r2, asl #2]
	ldr	r3, [fp, #-28]
	mul	r0, r3, r2
	ldr	r3, [fp, #-32]
	mvn	r2, #11
	mov	r3, r3, asl #2
	sub	r1, fp, #4
	add	r3, r1, r3
	add	r3, r3, r2
	ldr	r1, [r3, #0]
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-28]
	add	r3, r2, r3
	mul	r3, r1, r3
	add	r2, r0, r3
	ldr	r3, [fp, #-36]
	str	r2, [r3, #0]
	ldr	r2, [fp, #-32]
	ldr	r3, .L37+8
	ldr	r2, [r3, r2, asl #2]
	ldr	r3, [fp, #-24]
	mul	r0, r3, r2
	ldr	r3, [fp, #-32]
	mvn	r2, #11
	mov	r3, r3, asl #2
	sub	r1, fp, #4
	add	r3, r1, r3
	add	r3, r3, r2
	ldr	r1, [r3, #0]
	ldr	r2, [fp, #-24]
	ldr	r3, [fp, #-28]
	add	r3, r2, r3
	mul	r3, r1, r3
	add	r2, r0, r3
	ldr	r3, [fp, #4]
	str	r2, [r3, #0]
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
.L38:
	.align	2
.L37:
	.word	C.259.18543
	.word	ROTATE_CONST_p_output_1
	.word	ROTATE_CONST_p_output_2
	.size	rotator, .-rotator
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
	ldr	r3, .L41
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-16]
	mul	r3, r2, r3
	str	r3, [fp, #-8]
	ldr	r3, [fp, #-8]
	mov	r0, r3
	add	sp, fp, #0
	ldmfd	sp!, {fp}
	bx	lr
.L42:
	.align	2
.L41:
	.word	SQRT2
	.size	scale_up, .-scale_up
	.align	2
	.global	loefflers
	.type	loefflers, %function
loefflers:
	@ args = 32, pretend = 8, frame = 176
	@ frame_needed = 1, uses_anonymous_args = 0
	sub	sp, sp, #8
	stmfd	sp!, {r4, r5, fp, lr}
	add	fp, sp, #12
	sub	sp, sp, #184
	mov	r5, r0
	add	r1, fp, #4
	stmia	r1, {r2, r3}
	sub	r3, fp, #84
	str	r3, [fp, #-20]
	sub	lr, fp, #116
	add	ip, fp, #4
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	sub	r2, fp, #148
	str	r2, [fp, #-184]
	mov	r3, #0
	ldr	r2, [fp, #-184]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-184]
	add	r3, r3, #4
	str	r3, [fp, #-184]
	mov	r3, #0
	ldr	r2, [fp, #-184]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-184]
	add	r3, r3, #4
	str	r3, [fp, #-184]
	mov	r3, #0
	ldr	r2, [fp, #-184]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-184]
	add	r3, r3, #4
	str	r3, [fp, #-184]
	mov	r3, #0
	ldr	r2, [fp, #-184]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-184]
	add	r3, r3, #4
	str	r3, [fp, #-184]
	mov	r3, #0
	ldr	r2, [fp, #-184]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-184]
	add	r3, r3, #4
	str	r3, [fp, #-184]
	mov	r3, #0
	ldr	r2, [fp, #-184]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-184]
	add	r3, r3, #4
	str	r3, [fp, #-184]
	mov	r3, #0
	ldr	r2, [fp, #-184]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-184]
	add	r3, r3, #4
	str	r3, [fp, #-184]
	mov	r3, #0
	ldr	r2, [fp, #-184]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-184]
	add	r3, r3, #4
	sub	lr, fp, #148
	sub	ip, fp, #116
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	mvn	r3, #135
	sub	r2, fp, #12
	add	r3, r2, r3
	vldmia	r3, {d16-d19}
	ldr	r3, [fp, #-20]
	vst4.32	{d16-d19}, [r3]
	ldr	r2, [fp, #-84]
	ldr	r1, [fp, #-56]
	sub	ip, fp, #52
	sub	r3, fp, #52
	add	r3, r3, #28
	mov	r0, r2
	mov	r2, ip
	bl	reflector
	ldr	r1, [fp, #-80]
	ldr	ip, [fp, #-60]
	sub	r3, fp, #52
	add	r2, r3, #4
	sub	r3, fp, #52
	add	r3, r3, #24
	mov	r0, r1
	mov	r1, ip
	bl	reflector
	ldr	r1, [fp, #-76]
	ldr	ip, [fp, #-64]
	sub	r3, fp, #52
	add	r2, r3, #8
	sub	r3, fp, #52
	add	r3, r3, #20
	mov	r0, r1
	mov	r1, ip
	bl	reflector
	ldr	r1, [fp, #-72]
	ldr	ip, [fp, #-68]
	sub	r3, fp, #52
	add	r2, r3, #12
	sub	r3, fp, #52
	add	r3, r3, #16
	mov	r0, r1
	mov	r1, ip
	bl	reflector
	ldr	r2, [fp, #-52]
	ldr	r1, [fp, #-40]
	sub	ip, fp, #52
	sub	r3, fp, #52
	add	r3, r3, #12
	mov	r0, r2
	mov	r2, ip
	bl	reflector
	ldr	r1, [fp, #-48]
	ldr	ip, [fp, #-44]
	sub	r3, fp, #52
	add	r2, r3, #4
	sub	r3, fp, #52
	add	r3, r3, #8
	mov	r0, r1
	mov	r1, ip
	bl	reflector
	ldr	r2, [fp, #-52]
	ldr	r1, [fp, #-48]
	sub	ip, fp, #52
	sub	r3, fp, #52
	add	r3, r3, #4
	mov	r0, r2
	mov	r2, ip
	bl	reflector
	ldr	r2, [fp, #-44]
	ldr	r1, [fp, #-40]
	sub	r3, fp, #52
	add	ip, r3, #8
	sub	r3, fp, #52
	add	r3, r3, #12
	str	r3, [sp, #0]
	mov	r0, r2
	mov	r2, #2
	mov	r3, ip
	bl	rotator
	ldr	r3, [fp, #-52]
	mov	r3, r3, asl #5
	str	r3, [fp, #-84]
	ldr	r3, [fp, #-48]
	mov	r3, r3, asl #5
	str	r3, [fp, #-68]
	ldr	r3, [fp, #-44]
	mov	r3, r3, asr #9
	str	r3, [fp, #-76]
	ldr	r3, [fp, #-40]
	mov	r3, r3, asr #9
	str	r3, [fp, #-60]
	ldr	r2, [fp, #-36]
	ldr	r1, [fp, #-24]
	sub	r3, fp, #52
	add	ip, r3, #16
	sub	r3, fp, #52
	add	r3, r3, #28
	str	r3, [sp, #0]
	mov	r0, r2
	mov	r2, #1
	mov	r3, ip
	bl	rotator
	ldr	r2, [fp, #-32]
	ldr	r1, [fp, #-28]
	sub	r3, fp, #52
	add	ip, r3, #20
	sub	r3, fp, #52
	add	r3, r3, #24
	str	r3, [sp, #0]
	mov	r0, r2
	mov	r2, #0
	mov	r3, ip
	bl	rotator
	ldr	r1, [fp, #-36]
	ldr	ip, [fp, #-28]
	sub	r3, fp, #52
	add	r2, r3, #16
	sub	r3, fp, #52
	add	r3, r3, #24
	mov	r0, r1
	mov	r1, ip
	bl	reflector
	ldr	r1, [fp, #-24]
	ldr	ip, [fp, #-32]
	sub	r3, fp, #52
	add	r2, r3, #28
	sub	r3, fp, #52
	add	r3, r3, #20
	mov	r0, r1
	mov	r1, ip
	bl	reflector
	ldr	r1, [fp, #-24]
	ldr	ip, [fp, #-36]
	sub	r3, fp, #52
	add	r2, r3, #28
	sub	r3, fp, #52
	add	r3, r3, #16
	mov	r0, r1
	mov	r1, ip
	bl	reflector
	ldr	r3, [fp, #-32]
	mov	r0, r3
	bl	scale_up
	mov	r3, r0
	str	r3, [fp, #-32]
	ldr	r3, [fp, #-28]
	mov	r0, r3
	bl	scale_up
	mov	r3, r0
	str	r3, [fp, #-28]
	ldr	r3, [fp, #-36]
	mov	r3, r3, asr #9
	str	r3, [fp, #-56]
	ldr	r3, [fp, #-32]
	mov	r3, r3, asr #9
	str	r3, [fp, #-72]
	ldr	r3, [fp, #-28]
	mov	r3, r3, asr #9
	str	r3, [fp, #-64]
	ldr	r3, [fp, #-24]
	mov	r3, r3, asr #9
	str	r3, [fp, #-80]
	sub	r3, fp, #84
	str	r3, [fp, #-16]
	ldr	r3, [fp, #-16]
	vld4.32	{d16-d19}, [r3]
	mvn	r3, #167
	sub	r2, fp, #12
	add	r3, r2, r3
	vstmia	r3, {d16-d19}
	add	r4, fp, #4
	sub	ip, fp, #180
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	r4!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	r4, {r0, r1, r2, r3}
	mov	r4, r5
	add	ip, fp, #4
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	r4!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	r4, {r0, r1, r2, r3}
	mov	r0, r5
	sub	sp, fp, #12
	ldmfd	sp!, {r4, r5, fp, lr}
	add	sp, sp, #8
	bx	lr
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
	@ args = 0, pretend = 0, frame = 456
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, fp, lr}
	add	fp, sp, #24
	sub	sp, sp, #484
	str	r0, [fp, #-440]
	str	r1, [fp, #-444]
	ldr	r3, [fp, #-440]
	cmp	r3, #2
	beq	.L46
	ldr	r3, [fp, #-440]
	sub	r3, r3, #1
	ldr	r0, .L69
	mov	r1, r3
	bl	printf
	mov	r0, #1
	str	r0, [fp, #-480]
	b	.L47
.L46:
	ldr	r3, [fp, #-444]
	add	r3, r3, #4
	ldr	r3, [r3, #0]
	ldr	r0, .L69+4
	mov	r1, r3
	bl	printf
	ldr	r0, .L69+8
	bl	puts
	ldr	r3, [fp, #-444]
	add	r3, r3, #4
	ldr	r3, [r3, #0]
	mov	r0, r3
	bl	get_image
	mov	r3, #0
	str	r3, [fp, #-72]
	b	.L48
.L59:
	mov	r3, #0
	str	r3, [fp, #-68]
	b	.L49
.L58:
	ldr	r3, [fp, #-68]
	mov	r3, r3, asl #3
	str	r3, [fp, #-80]
	ldr	r3, [fp, #-72]
	mov	r3, r3, asl #3
	str	r3, [fp, #-76]
	ldr	r0, [fp, #-80]
	ldr	r1, [fp, #-76]
	bl	get_next_group
	mov	r3, #0
	str	r3, [fp, #-64]
	b	.L50
.L51:
	ldr	r6, [fp, #-64]
	ldr	r4, [fp, #-64]
	ldr	r7, .L69+12
	sub	r8, fp, #476
	ldr	r5, .L69+12
	mov	r2, #8
	mov	r3, r4, asl #5
	add	r3, r5, r3
	add	r3, r3, r2
	mov	lr, sp
	mov	ip, r3
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1}
	stmia	lr, {r0, r1}
	mov	r3, r4, asl #5
	add	r3, r5, r3
	ldmia	r3, {r2, r3}
	mov	r0, r8
	bl	loefflers
	mov	r4, r6, asl #5
	add	r4, r7, r4
	sub	ip, fp, #476
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	r4!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	r4, {r0, r1, r2, r3}
	ldr	r3, [fp, #-64]
	add	r3, r3, #1
	str	r3, [fp, #-64]
.L50:
	ldr	r3, [fp, #-64]
	cmp	r3, #7
	ble	.L51
	sub	r3, fp, #340
	ldr	r0, .L69+12
	mov	r1, r3
	bl	transpose
	mov	r3, #0
	str	r3, [fp, #-60]
	b	.L52
.L53:
	ldr	r3, [fp, #-60]
	ldr	r1, [fp, #-60]
	ldr	r2, .L69+16
	mov	r3, r3, asl #5
	sub	r0, fp, #28
	add	r3, r0, r3
	add	r5, r3, r2
	sub	r6, fp, #476
	ldr	r2, .L69+16
	mov	r3, r1, asl #5
	sub	r1, fp, #28
	add	r3, r1, r3
	add	r4, r3, r2
	mov	lr, sp
	add	ip, r4, #8
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1}
	stmia	lr, {r0, r1}
	ldmia	r4, {r2, r3}
	mov	r0, r6
	bl	loefflers
	mov	r4, r5
	sub	ip, fp, #476
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	r4!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	r4, {r0, r1, r2, r3}
	ldr	r3, [fp, #-60]
	add	r3, r3, #1
	str	r3, [fp, #-60]
.L52:
	ldr	r3, [fp, #-60]
	cmp	r3, #7
	ble	.L53
	sub	r3, fp, #340
	mov	r0, r3
	ldr	r1, .L69+12
	bl	transpose
	mov	r3, #0
	str	r3, [fp, #-56]
	b	.L54
.L57:
	sub	r3, fp, #372
	ldr	r2, [fp, #-56]
	str	r3, [fp, #-32]
	mov	r3, r2
	ldr	r2, .L69+12
	sub	lr, fp, #404
	mov	ip, r3, asl #5
	add	ip, r2, ip
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	sub	r2, fp, #436
	str	r2, [fp, #-484]
	mov	r3, #0
	ldr	r0, [fp, #-484]
	str	r3, [r0, #0]
	ldr	r1, [fp, #-484]
	add	r1, r1, #4
	str	r1, [fp, #-484]
	mov	r3, #0
	ldr	r2, [fp, #-484]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-484]
	add	r3, r3, #4
	str	r3, [fp, #-484]
	mov	r3, #0
	ldr	r0, [fp, #-484]
	str	r3, [r0, #0]
	ldr	r1, [fp, #-484]
	add	r1, r1, #4
	str	r1, [fp, #-484]
	mov	r3, #0
	ldr	r2, [fp, #-484]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-484]
	add	r3, r3, #4
	str	r3, [fp, #-484]
	mov	r3, #0
	ldr	r0, [fp, #-484]
	str	r3, [r0, #0]
	ldr	r1, [fp, #-484]
	add	r1, r1, #4
	str	r1, [fp, #-484]
	mov	r3, #0
	ldr	r2, [fp, #-484]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-484]
	add	r3, r3, #4
	str	r3, [fp, #-484]
	mov	r3, #0
	ldr	r0, [fp, #-484]
	str	r3, [r0, #0]
	ldr	r1, [fp, #-484]
	add	r1, r1, #4
	str	r1, [fp, #-484]
	mov	r3, #0
	ldr	r2, [fp, #-484]
	str	r3, [r2, #0]
	ldr	r3, [fp, #-484]
	add	r3, r3, #4
	sub	lr, fp, #436
	sub	ip, fp, #404
	ldmia	ip!, {r0, r1, r2, r3}
	stmia	lr!, {r0, r1, r2, r3}
	ldmia	ip, {r0, r1, r2, r3}
	stmia	lr, {r0, r1, r2, r3}
	ldr	r3, .L69+20
	sub	r0, fp, #28
	add	r3, r0, r3
	vldmia	r3, {d16-d19}
	ldr	r3, [fp, #-32]
	vst4.32	{d16-d19}, [r3]
	mov	r3, #0
	str	r3, [fp, #-52]
	b	.L55
.L56:
	ldr	r2, [fp, #-76]
	ldr	r3, [fp, #-56]
	add	ip, r2, r3
	ldr	r2, [fp, #-80]
	ldr	r3, [fp, #-52]
	add	lr, r2, r3
	ldr	r3, [fp, #-52]
	mov	r0, r3, asr #1
	ldr	r2, [fp, #-52]
	mov	r3, r2, asr #31
	mov	r1, r3, lsr #31
	add	r3, r2, r1
	and	r3, r3, #1
	rsb	r3, r1, r3
	mov	r2, r3
	mov	r3, r0, asl #1
	add	r3, r3, r2
	ldr	r2, .L69+24
	mov	r3, r3, asl #2
	sub	r1, fp, #28
	add	r3, r1, r3
	add	r3, r3, r2
	ldr	r1, [r3, #0]
	ldr	r0, .L69+28
	mov	r3, ip
	mov	r3, r3, asl #6
	mov	r2, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, lr
	str	r1, [r0, r3, asl #2]
	ldr	r3, [fp, #-52]
	add	r3, r3, #1
	str	r3, [fp, #-52]
.L55:
	ldr	r3, [fp, #-52]
	cmp	r3, #7
	ble	.L56
	ldr	r3, [fp, #-56]
	add	r3, r3, #1
	str	r3, [fp, #-56]
.L54:
	ldr	r3, [fp, #-56]
	cmp	r3, #7
	ble	.L57
	ldr	r3, [fp, #-68]
	add	r3, r3, #1
	str	r3, [fp, #-68]
.L49:
	ldr	r3, [fp, #-68]
	cmp	r3, #39
	ble	.L58
	ldr	r3, [fp, #-72]
	add	r3, r3, #1
	str	r3, [fp, #-72]
.L48:
	ldr	r3, [fp, #-72]
	cmp	r3, #29
	ble	.L59
	ldr	r0, .L69+32
	bl	puts
	mov	r3, #0
	str	r3, [fp, #-48]
	b	.L60
.L63:
	mov	r3, #0
	str	r3, [fp, #-44]
	b	.L61
.L62:
	ldr	r3, [fp, #-48]
	ldr	r1, [fp, #-44]
	ldr	r0, .L69+28
	mov	r3, r3, asl #6
	mov	r2, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r3, [r0, r3, asl #2]
	fmsr	s15, r3	@ int
	fsitod	d17, s15
	ldr	r3, .L69+36
	ldr	r3, [r3, #0]
	fmsr	s15, r3	@ int
	fsitod	d16, s15
	fdivd	d16, d17, d16
	ldr	r0, .L69+40
	fmrrd	r2, r3, d16
	bl	printf
	ldr	r3, [fp, #-44]
	add	r3, r3, #1
	str	r3, [fp, #-44]
.L61:
	ldr	r3, [fp, #-44]
	cmp	r3, #7
	ble	.L62
	mov	r0, #10
	bl	putchar
	ldr	r3, [fp, #-48]
	add	r3, r3, #1
	str	r3, [fp, #-48]
.L60:
	ldr	r3, [fp, #-48]
	cmp	r3, #7
	ble	.L63
	ldr	r0, .L69+44
	bl	puts
	mov	r3, #0
	str	r3, [fp, #-40]
	b	.L64
.L67:
	mov	r3, #0
	str	r3, [fp, #-36]
	b	.L65
.L66:
	ldr	r3, [fp, #-40]
	add	r2, r3, #120
	ldr	r3, [fp, #-36]
	add	r1, r3, #160
	ldr	r0, .L69+28
	mov	r3, r2
	mov	r3, r3, asl #6
	mov	r2, r3, asl #2
	add	r3, r3, r2
	add	r3, r3, r1
	ldr	r3, [r0, r3, asl #2]
	fmsr	s15, r3	@ int
	fsitod	d17, s15
	ldr	r3, .L69+36
	ldr	r3, [r3, #0]
	fmsr	s15, r3	@ int
	fsitod	d16, s15
	fdivd	d16, d17, d16
	ldr	r0, .L69+40
	fmrrd	r2, r3, d16
	bl	printf
	ldr	r3, [fp, #-36]
	add	r3, r3, #1
	str	r3, [fp, #-36]
.L65:
	ldr	r3, [fp, #-36]
	cmp	r3, #7
	ble	.L66
	mov	r0, #10
	bl	putchar
	ldr	r3, [fp, #-40]
	add	r3, r3, #1
	str	r3, [fp, #-40]
.L64:
	ldr	r3, [fp, #-40]
	cmp	r3, #7
	ble	.L67
	mov	r0, #0
	str	r0, [fp, #-480]
.L47:
	ldr	r3, [fp, #-480]
	mov	r0, r3
	sub	sp, fp, #24
	ldmfd	sp!, {r4, r5, r6, r7, r8, fp, pc}
.L70:
	.align	2
.L69:
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	g_current_group
	.word	-312
	.word	-408
	.word	-344
	.word	g_output_matrix
	.word	.LC7
	.word	END_SCALE
	.word	.LC8
	.word	.LC9
	.size	main, .-main
	.comm	g_pixel_matrix,307200,4
	.comm	g_output_matrix,307200,4
	.comm	g_current_group,256,8
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
