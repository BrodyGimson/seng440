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
    
    float A[8];
    
    //stage 1
    reflector(x[0], x[7], &A[0], &A[7]);
    reflector(x[1], x[6], &A[1], &A[6]);
    reflector(x[2], x[5], &A[2], &A[5]);
    reflector(x[3], x[4], &A[3], &A[4]);

    
    //stage 2
    reflector(A[0], A[3], &A[0], &A[3]);
    reflector(A[1], A[2], &A[1], &A[2]);
    
    rotator(A[4], A[7], 1, 3, &A[4], &A[7]);
    rotator(A[5], A[6], 1, 1, &A[5], &A[6]);

    
    //stage 3
    reflector(A[0], A[1], &A[0], &A[1]);
    rotator(A[2], A[3], sqrt(2), 6, &A[2], &A[3]);
    reflector(A[4], A[6], &A[4], &A[6]);
    reflector(A[7], A[5], &A[7], &A[5]);

    
    //stage 4
    reflector(A[7], A[4], &A[7], &A[4]);
    A[5] = scaleUp(A[5]);
    A[6] = scaleUp(A[6]);

    
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

    printf("\n----TESTING AREA----\n\n");

    // Get image test
    getImage(argv[1]);

    printf("\nLoefflers 8x8 Corner\n");
    getNextGroup(0, 0);
    for(int i = 0; i < 8; i++){
    	loefflers(current_group[i]);
    }
    
    float current_group_t[8][8];
    transpose(current_group, current_group_t);	
    
    for(int i = 0; i < 8; i++){
    	loefflers(current_group_t[i]);
    }
    
    transpose(current_group_t, current_group);
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            printf("%f ", current_group[i][j]);
        }
        printf("\n");
    }

    printf("\nLoefflers 8x8 Center\n");
    getNextGroup(120, 160);
    for(int i = 0; i < 8; i++){
    	loefflers(current_group[i]);
    }
    
    transpose(current_group, current_group_t);	
    
    for(int i = 0; i < 8; i++){
    	loefflers(current_group_t[i]);
    }
    
    transpose(current_group_t, current_group);
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            printf("%f ", current_group[i][j]);
        }
        printf("\n");
    }
    			
    return 0;
}
