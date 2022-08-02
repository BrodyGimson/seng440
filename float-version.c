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

void * reflector(float I1, float I2, float *O){
        
    O[0] = I1 + I2;
    O[1] = I1 - I2;
}

void rotator(float I1, float I2, float k, float Cn, float *O){
    O[0] = ((k * sin((Cn * M_PI)/16)) - (k * cos((Cn * M_PI)/16)))*I2 + (k * cos((Cn * M_PI)/16)*(I1 + I2));
    O[1] = -((k * sin((Cn * M_PI)/16)) + (k * cos((Cn * M_PI)/16)))*I1 + (k * cos((Cn * M_PI)/16)*(I1 + I2));
}

float scaleUp(float I){
    float O = sqrt(2) * I;
    return O;
}

void * loefflers(float * x){
    
    
    
    //stage 1
    reflector(x[0], x[7], );
    reflector(x[1], x[6], );
    reflector(x[2], x[5], );
    reflector(x[3], x[4], );
    
    //stage 2
    reflector(x[0], x[3], );
    reflector(x[1], x[2], );
    
    rotator(x[4], x[7], 1, 3, );
    rotator(x[5], x[6], 1, 1, );
    
    //stage 3
    reflector(x[0], x[1], );
    rotator(x[2], x[3], sqrt(2), 6, );
    reflector(x[4], x[6], );
    reflector(x[7], x[5], );
    
    //stage 4
    reflector(x[7], x[4], );
    scaleUp(x[5]);
    scaleUp(x[6]);
    
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
            printf("%f ", B[i][j]);
        }
        printf("\n");
    }

    float I1 = 1;
    float I2 = 2;
	
    float O[2];	

    reflector(I1, I2, O);
    printf("I1: %f, I2: %f\n", I1, I2);
    printf("O1: %f, O2: %f\n", O[0], O[1]);
    
    rotator(I1, I2, 1, 1, O);
    printf("I1: %f, I2: %f\n", I1, I2);
    printf("O1: %f, O2: %f\n", O[0], O[1]);
    
    printf("I1: %f, O: %f\n", I1, scaleUp(I1));	

    return 0;
}
