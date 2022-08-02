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
    printf("Filename: %s\n", image_name);
    
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
    
    printf("\nBody\n");
    for(int i = 0; i < IMAGE_HEIGHT; i++){
        for(int j = 0; j < IMAGE_WIDTH; j++) {
            if((cbinary = fgetc(image_file)) == EOF){
                break;
            }
            else{
                pixel_matrix[i][j] = cbinary;
                printf("%d ", cbinary);
            }
        }
        printf("\n");
    }

    printf("Array first value: %f\n", pixel_matrix[0][0]);
    printf("Array last value: %f\n", pixel_matrix[IMAGE_HEIGHT-1][IMAGE_WIDTH-1]);

    while((cbinary = fgetc(image_file)) != EOF){
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

void getNextGroup(int current_x, int current_y) {
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            current_group[i][j] = pixel_matrix[current_y + i][current_x + j];
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

int main(int argc, char *argv[]){
    int current_x;
    int current_y;
    
    if (argc != 2){
        printf("Error: 1 arg expected {filename}, received: %d\n", (argc-1));
        return 1;
    }

    current_x = 0;
    current_y = 0;

    getImage(argv[1]);
    getNextGroup(current_x, current_y);

    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            printf("%f ", current_group[i][j]);
        }
        printf("\n");
    }

    current_y = 120;
    current_x = 160;
    getNextGroup(current_x, current_y);

    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            printf("%f ", current_group[i][j]);
        }
        printf("\n");
    }

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
