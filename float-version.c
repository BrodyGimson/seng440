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
float jpegMatrix [240*320];

void getImage(char *imageName){
    fflush(stdout);
    printf("Filename: %s\n", imageName);
    FILE *imageFile = fopen(imageName, "rb");
    printf("File read\n");

    int cbinary;

    //Read file header
    // printf("Header\n");
    for(int i = 0; i < 54; i++){
        cbinary = fgetc(imageFile);
        // printf("%d ", cbinary);
    }
    //Read Colour table
    // printf("\nColour table\n");
    for(int i = 0; i < 128*8; i++){
        cbinary = fgetc(imageFile);
        // printf("%d ", cbinary);
    }
    
    printf("\nBody\n");
    for(int i = 0; i < IMAGE_SIZE; i++){
        if((cbinary = fgetc(imageFile)) == EOF){
            break;
        }
        else{
            jpegMatrix[i] = cbinary;
            // printf("%d ", cbinary);
        }
    }

    printf("\nArray first value: %f\n", jpegMatrix[0]);
    printf("\nArray last value: %f\n", jpegMatrix[IMAGE_SIZE-1]);

    while((cbinary = fgetc(imageFile)) != EOF){
        printf("%d ", cbinary);
    }
}

void transpose(float A[][N], float B[][M]){

    for(int i = 0; i < N; i++){
        for(int j = 0; j < M; j++){
            B[i][j] = A[j][i];
        }
    }
}

void reflector(float I1, float I2, float O1, float O2){
    O1 = I1 + I2;
    O2 = I1 - I2;
    printf("O1: %f, O2: %f\n", O1, O2);
}

void rotator(float I1, float I2, float k, float Cn, float O1, float O2){
    O1 = ((k * sin((Cn * M_PI)/16)) - (k * cos((Cn * M_PI)/16)))*I2 + (k * cos((Cn * M_PI)/16)*(I1 + I2));
    O2 = -((k * sin((Cn * M_PI)/16)) + (k * cos((Cn * M_PI)/16)))*I1 + (k * cos((Cn * M_PI)/16)*(I1 + I2));
}

void scaleUp(float I, float O){
    O = sqrt(2) * I;
}

int main(int argc, char *argv[]){
    
    if (argc != 2){
        printf("Error: 1 arg expected {filename}, received: %d\n", (argc-1));
        return 1;
    }

    getImage(argv[1]);

    printf("Success\n");

    printf("\n\n----TESTING AREA----\n\n");

    float *testMatrix;

    float A[N][M] = {{0, 1, 2}, {3, 4, 5}, {6, 7, 8}};
    float B[M][N];

    transpose(A, B);

    for(int i = 0; i < N; i++){
        for(int j = 0; j < M; j++){
            printf("%d ", B[i][j]);
        }
        printf("\n");
    }

    // float I1 = 1;
    // float I2 = 2;
    // float O1, O2;

    // reflector(I1, I2, O1, O2);
    // printf("I1: %f, I2: %f\n", I1, I2);
    // printf("O1: %f, O2: %f\n", O1, O2);

    return 0;
}