#include <stdio.h>
#include <string.h>
#include <float.h>

const int IMAGE_HEIGHT = 240;
const int IMAGE_WIDTH = 320;
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

void getNextGroup(int current_x, int current_y) {
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            current_group[i][j] = pixel_matrix[current_y + i][current_x + j];
        }
    }
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

    return 0;
}