#include <stdio.h>
#include <string.h>
#include <float.h>
#define _USE_MATH_DEFINES
#include <math.h>
#include <stdint.h>
#include <float.h>

#define IMAGE_HEIGHT 240
#define IMAGE_WIDTH 320
#define N 3
#define M 3

int IMAGE_SIZE = 240*320;
int32_t pixel_matrix[240][320];
int32_t current_group[8][8];
int32_t rotateConstO1[3] = {-12873, -4520, 12539};
int32_t rotateConstO2[3] = {-19266, -22725, -30273};
int32_t rotateConst[3] = {16069, 13622, 8866};
int32_t sqrt2 = 181;

void getImage(char *image_name){
    FILE *image_file;
    int cbinary;
    int error;

    fflush(stdout);
    
    image_file = fopen(image_name, "rb");
    if (image_file == NULL) {
        perror("Error: Could not open file");
    }

    //Move to end of file header
    error = fseek(image_file, 54, SEEK_SET);
    if (error != 0) {
        perror("Error: Could not seek past header of file");
    }
    
    //Move to end of Colour table
    error = fseek(image_file, 1024, SEEK_CUR);
    if (error != 0) {
        perror("Error: Could not seek past colour table of file");
    }
    
    for(int i = 0; i < IMAGE_HEIGHT; i++){
        for(int j = 0; j < IMAGE_WIDTH; j++) {
            if((cbinary = fgetc(image_file)) == EOF){
                break;
            }
            else{
                pixel_matrix[i][j] = cbinary;
            }
        }
    }
}

void transpose(int32_t A[][8], int32_t B[][8]){

    for(int i = 0; i < 8; i++){
        for(int j = 0; j < 8; j++){
            B[i][j] = A[j][i];
        }
    }
}

void getNextGroup(int current_x, int current_y) {
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            current_group[i][j] = pixel_matrix[current_y + i][current_x + j];
        }
    }
}

void * reflector(int32_t I1, int32_t I2, int32_t *O1, int32_t *O2){       
    O1[0] = I1 + I2;
    O2[0] = I1 - I2;
}

void rotator(int32_t I1, int32_t I2, int c, int32_t *O1, int32_t *O2){
    O1[0] = (rotateConstO1[c])*I2 + (rotateConst[c])*(I1 + I2);
    O2[0] = (rotateConstO2[c])*I1 + (rotateConst[c])*(I1 + I2);
}

int32_t scaleUp(int32_t I){
    I = I >> 7;
    int32_t O = sqrt2 * I;
    return O;
}

void * loefflers(int32_t * x){
    
    int32_t A[8];
    
    //stage 1
    reflector(x[0], x[7], &A[0], &A[7]);
    reflector(x[1], x[6], &A[1], &A[6]);
    reflector(x[2], x[5], &A[2], &A[5]);
    reflector(x[3], x[4], &A[3], &A[4]);
    printf("stage 1\n");
    for (int i = 0; i < 8; i++) {
        printf("%d, ", A[i]);
    }
    printf("\n\n");
    
    //stage 2
    reflector(A[0], A[3], &A[0], &A[3]);
    reflector(A[1], A[2], &A[1], &A[2]);
    
    rotator(A[4], A[7], 1, &A[4], &A[7]);
    rotator(A[5], A[6], 0, &A[5], &A[6]);
    printf("stage 2\n");
    for (int i = 0; i < 8; i++) {
        printf("%d, ", A[i]);
    }
    printf("\n\n");
    
    //stage 3
    reflector(A[0], A[1], &A[0], &A[1]);
    rotator(A[2], A[3], 2, &A[2], &A[3]);
    reflector(A[4], A[6], &A[4], &A[6]);
    reflector(A[7], A[5], &A[7], &A[5]);
    printf("stage 3\n");
    for (int i = 0; i < 8; i++) {
        printf("%d, ", A[i]);
    }
    printf("\n\n");
    
    
    //stage 4
    reflector(A[7], A[4], &A[7], &A[4]);
    A[5] = scaleUp(A[5]);
    A[6] = scaleUp(A[6]);
    printf("stage 4\n");
    for (int i = 0; i < 8; i++) {
        printf("%d, ", A[i]);
    }
    printf("\n\n");
    
    
    x[0] = A[0];
    x[4] = A[1];
    x[2] = A[2];
    x[6] = A[3];
    x[7] = A[4];
    x[3] = A[5];
    x[5] = A[6];
    x[1] = A[7];
    
}

int main(int argc, char *argv[]){
    int current_x;
    int current_y;
    
    if (argc != 2){
        printf("Error: 1 arg expected {filename}, received: %d\n", (argc-1));
        return 1;
    }

    printf("Filename: %s\n", argv[1]);

    printf("Success\n");

    printf("\n\n----TESTING AREA----\n\n");

    // Get image test
    getImage(argv[1]);

    printf("Get Image Test:\n");
    printf("Array first value: %d\n", pixel_matrix[0][0]);
    printf("Array last value: %d\n", pixel_matrix[IMAGE_HEIGHT-1][IMAGE_WIDTH-1]);
    
    int32_t a = 1;
    int32_t b = 2;
    int32_t O[2];
    reflector(a * pow(2, 7), b * pow(2, 7), &O[0], &O[1]);
    printf("\nOutputs: %d, %d\n", O[0], O[1]);
    
    rotator(a * pow(2, 7), b * pow(2, 7), 1, &O[0], &O[1]);
    printf("\nOutputs: %d, %d\n", O[0], O[1]);
    
    int32_t scaleO = scaleUp(b* pow(2, 7));
    printf("\nOutputs: %d\n", scaleO);
    /*
    // Get first group test
    printf("\nGet first group of pixels:\n");

    current_x = 0;
    current_y = 0;

    getNextGroup(current_x, current_y);

    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            printf("%f ", current_group[i][j]);
        }
        printf("\n");
    }

    // Get center group test
    printf("\nGet center group of pixels:\n");

    current_y = 120;
    current_x = 160;

    getNextGroup(current_x, current_y);

    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            printf("%f ", current_group[i][j]);
        }
        printf("\n");
    }
    */
    
    // Loeffler's testing
    int32_t I[8] = { 2, 1, 4, 9, 3, 8, 7, 2 };
    float Out[8];
    for(int i = 0; i < 8; i++){
    	I[i] = I[i] * pow(2, 7);
    }

    loefflers(I);
    printf("\nTesting Loefflers with { 2, 1, 4, 9, 3, 8, 7, 2 } as input\n");
    for (int i = 0; i < 8; i++) {
    	if(i != 0 && i != 4){
    		Out[i] = I[i] >> 14;
    	}
    	else{
    		Out[i] = I[i];
    	}
        printf("%f, ", Out[i]);
    }
    printf("\n\n");
    /*
    
    // Transpose testing
    int32_t *testMatrix;

    int32_t A[N][M] = {{0, 1, 2}, {3, 4, 5}, {6, 7, 8}};
    int32_t B[M][N];

    printf("Transpose test on \n");
    for(int i = 0; i < N; i++){
        for(int j = 0; j < M; j++){
            printf("%f ", A[i][j]);
        }
        printf("\n");
    }
    printf("\nTranspose\n");

    transpose(A, B);

    for(int i = 0; i < N; i++){
        for(int j = 0; j < M; j++){
            printf("%f ", B[i][j]);
        }
        printf("\n");
    }

    printf("\nTranspose back\n");
    transpose(B, A);

    for(int i = 0; i < N; i++){
        for(int j = 0; j < M; j++){
            printf("%f ", A[i][j]);
        }
        printf("\n");
    }
    /*
    // Loeffler Function Tests
    int32_t I1 = 1;
    int32_t I2 = 2;
	
    int32_t O[2];	

    printf("\nReflector Test\n");
    reflector(I1, I2, &O[0], &O[1]);
    printf("I1: %f, I2: %f\n", I1, I2);
    printf("O1: %f, O2: %f\n", O[0], O[1]);
    
    printf("\nRotator Test\n");
    rotator(I1, I2, 1, 1, &O[0], &O[1]);
    printf("I1: %f, I2: %f\n", I1, I2);
    printf("O1: %f, O2: %f\n", O[0], O[1]);
    
    printf("\nScale Up Test\n");
    printf("I1: %f, O: %f\n", I1, scaleUp(I1));
    
    printf("\nLoefflers 8x8\n");
    getNextGroup(120, 160);
    for(int i = 0; i < 8; i++){
    	loefflers(current_group[i]);
    }
    
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            printf("%f ", current_group[i][j]);
        }
        printf("\n");
    }			

    printf("\n");
    
    float current_group_t[8][8];
    transpose(current_group, current_group_t);
    printf("Transpose\n");
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            printf("%f ", current_group_t[i][j]);
        }
        printf("\n");
    }
    
    printf("\n");	
    
    for(int i = 0; i < 8; i++){
    	loefflers(current_group_t[i]);
    }
    
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            printf("%f ", current_group_t[i][j]);
        }
        printf("\n");
    }
    
    for(int x = 0; x < 40; x++){
    	for(int y = 0; y < 30; y++){
    		getNextGroup(8*x, 8*y);
    		
    		for(int i = 0; i < 8; i++){
    			loefflers(current_group[i]);
    		}
    		
    		float current_group_t[8][8];
    		transpose(current_group, current_group_t);
    		
    		for(int i = 0; i < 8; i++){
    			loefflers(current_group_t[i]);
    		}
    		
    		for (int i = 0; i < 8; i++) {
        		for (int j = 0; j < 8; j++) {
            			printf("%f ", current_group_t[i][j]);
        		}
        		printf("\n");
    		}
    		printf("\n");
    	}
    }
    */			
    return 0;
}
