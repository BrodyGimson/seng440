# SENG 440 Embedded Systems Project
This project is an implementation of the Discrete Cosine Transform (DCT) using Loeffler's algorithm in Embedded-C. Multiple implementations were done in order to look at the effects of different optimization techniques and utilizing NEON vector instructions. The Barr-C standards were used throughout the development of the project. The code was compiled and ran on a QEMU-ARM simulator. All code was compiled in the University of Victoria's undergraduate Linux lab where the simulator and compiler resided. The program is designed for images that are 320x240 and are greyscale with a .bmp file type.

## Running the Project on the QEMU-ARM Simulator
Each .c file is a different implementation of the DCT.

For running the code use the following commands to compile:
- With O1 optimization:
```
arm-none-linux-gnueabi-gcc -static -std=c99 -march=armv5 <name of implementation>.c -o <name of implementation> -O1
```
- Without it:
```
arm-none-linux-gnueabi-gcc -static -std=c99 -march=armv5 <name of implementation>.c -o <name of implementation>
```
To run the compiled code use the following command:
```
qemu ./<name of implementation> test_image.bmp
```

## Running the Performance Tests
The performance tests can be found under the branch "perf-tests". The code is very similar to the main branch, except the main logic is in a loop to be executed 1000 times.
For generating performance tests use the following commands to compile:
- With O1 optimization:
```
arm-none-linux-gnueabi-gcc -static -std=c99 -march=armv5 <name of implementation>.c -o <name of implementation> -pg -O1
```
- Without it:
```
arm-none-linux-gnueabi-gcc -static -std=c99 -march=armv5 <name of implementation>.c -o <name of implementation> -pg
```
The code then needs to be run in order to generate a profile of the code.
To run the compiled code use the following command:
```
qemu ./<name of implementation> test_image.bmp
```
To then create a report use the following command:
```
gprof <name of implementation> > <name of report>.txt
```

## Generating the Assembly
For generating the assembly use the following commands:
- With O1 optimization:
```
arm-none-linux-gnueabi-gcc -static -std=c99 -march=armv5 <name of implementation>.c -S -O1
```
- Without it:
```
arm-none-linux-gnueabi-gcc -static -std=c99 -march=armv5 <name of implementation>.c -S
```

## Running the Code without the Simulator
If you do not have access to the simulator mentioned you can simply compile with gcc using the optimizations flags mentioned. As per Barr-C the C standard used is C99. The command sets this standard just in case the default is not the same.
For running the code without the simulator use the following commands to compile:
- With O1 optimization:
```
gcc -std=c99 <name of implementation>.c -o <name of implementation> -O1
```
- Without it:
```
gcc -std=c99 <name of implementation>.c -o <name of implementation>
```
To run the compiled code use the following command:
```
./<name of implementation> test_image.bmp
```
