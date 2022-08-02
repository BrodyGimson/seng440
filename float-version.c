#include <stdio.h>
#include <string.h>
#include <float.h>
#define _USE_MATH_DEFINES
#include <math.h>

#define IMAGE_HEIGHT 240
#define IMAGE_WIDTH 320
#define N 3
#define M 3

int IMAGE_SIZE = 240*320;
float pixel_matrix[240][320];
float current_group[8][8];

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

void transpose(float A[][8], float B[][8]){

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

void * reflector(float I1, float I2, float *O1, float *O2){       
    O1[0] = I1 + I2;
    O2[0] = I1 - I2;
}

void rotator(float I1, float I2, float k, float Cn, float *O1, float *O2){
    O1[0] = ((k * sin((Cn * M_PI)/16)) - (k * cos((Cn * M_PI)/16)))*I2 + (k * cos((Cn * M_PI)/16)*(I1 + I2));
    O2[0] = -((k * sin((Cn * M_PI)/16)) + (k * cos((Cn * M_PI)/16)))*I1 + (k * cos((Cn * M_PI)/16)*(I1 + I2));
}

float scaleUp(float I){
    float O = sqrt(2) * I;
    return O;
}

void * loefflers(float * x){
    
    //stage 1
    reflector(x[0], x[7], &x[0], &x[7]);
    reflector(x[1], x[6], &x[1], &x[6]);
    reflector(x[2], x[5], &x[2], &x[5]);
    reflector(x[3], x[4], &x[3], &x[4]);
    
    //stage 2
    reflector(x[0], x[3], &x[0], &x[3]);
    reflector(x[1], x[2], &x[1], &x[2]);
    
    rotator(x[4], x[7], 1, 3, &x[4], &x[7]);
    rotator(x[5], x[6], 1, 1, &x[5], &x[6]);
    
    //stage 3
    reflector(x[0], x[1], &x[0], &x[1]);
    rotator(x[2], x[3], sqrt(2), 6, &x[2], &x[3]);
    reflector(x[4], x[6], &x[4], &x[6]);
    reflector(x[7], x[5], &x[7], &x[5]);
    
    //stage 4
    reflector(x[7], x[4], &x[7], &x[4]);
    x[5] = scaleUp(x[5]);
    x[6] = scaleUp(x[6]);
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
    printf("Array first value: %f\n", pixel_matrix[0][0]);
    printf("Array last value: %f\n", pixel_matrix[IMAGE_HEIGHT-1][IMAGE_WIDTH-1]);

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

    // Loeffler's testing
    float I[8] = { 21, 21, 21, 21, 21, 21, 21, 21 };

    loefflers(I);
    printf("\nTesting Loefflers with { 5, 8, 3, 1, 6, 2, 9, 1 } as input\n");
    for (int i = 0; i < 8; i++) {
        printf("%f, ", I[i]);
    }
    printf("\n\n");

    /*
    // Transpose testing
    float *testMatrix;

    float A[N][M] = {{0, 1, 2}, {3, 4, 5}, {6, 7, 8}};
    float B[M][N];

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
    */

    // Loeffler Function Tests
    float I1 = 1;
    float I2 = 2;
	
    float O[2];	

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

    return 0;
}
