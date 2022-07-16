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