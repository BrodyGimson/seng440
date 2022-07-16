#include <stdio.h>
#include <string.h>
#include <float.h>

const int IMAGE_HEIGHT = 240;
const int IMAGE_WIDTH = 320;
int IMAGE_SIZE = 240*320;
float jpegMatrix [240*320];

void getImage(char *imageName){
    fflush(stdout);
    printf("Filename: %s\n", imageName);
    
    FILE *imageFile = fopen(imageName, "rb");
    if (imageFile == NULL) {
        perror("Error: Could not open file");
    }

    int cbinary;
    int error;

    //Move to end of file header
    error = fseek(imageFile, 54, SEEK_SET);
    if (error != 0) {
        perror("Error: Could not seek past header of file");
    }
    
    //Move to end of Colour table
    error = fseek(imageFile, 1024, SEEK_CUR);
    if (error != 0) {
        perror("Error: Could not seek past colour table of file");
    }
    
    printf("\nBody\n");
    for(int i = 0; i < IMAGE_SIZE; i++){
        if((cbinary = fgetc(imageFile)) == EOF){
            break;
        }
        else{
            jpegMatrix[i] = cbinary;
            printf("%d ", cbinary);
        }
    }

    printf("Array first value: %f\n", jpegMatrix[0]);
    printf("Array last value: %f\n", jpegMatrix[IMAGE_SIZE-1]);

    while((cbinary = fgetc(imageFile)) != EOF){
        printf("%d ", cbinary);
    }
}

int main(int argc, char *argv[]){
    
    if (argc != 2){
        printf("Error: 1 arg expected {filename}, received: %d\n", (argc-1));
        return 1;
    }

    getImage(argv[1]);

    printf("Success\n");

    return 0;
}