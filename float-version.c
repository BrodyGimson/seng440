#include <stdio.h>
#include <float.h>

//float jpegMatrix [];

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
    for(int i = 0; i < 250; i++){
        for(int j = 0; j < 8; j++){
            if((cbinary = fgetc(imageFile)) != EOF){
                printf("%d ", cbinary);
            }
        }
        printf("\n");
    }

    // while((cbinary = fgetc(imageFile)) != EOF){
    //     printf("%d ", cbinary);
    // }
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