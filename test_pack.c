#include <stdio.h>
#include <string.h>
#include <stdint.h>

// Image related constants
int const IMAGE_SIZE = 240*320;
int const IMAGE_HEIGHT = 240;
int const IMAGE_WIDTH = 320;

// Barr-C: Global variables should start with "g_" (7.1.j)
uint32_t g_pixel_matrix[240][80];
int32_t g_output_matrix[240][320];

void get_image(char *p_image_name) 
{
    // Barr-C: Pointers should start with "p_" (7.1.k)
    // Barr-C: variables initialized before use (7.2.a)
    FILE *p_image_file;
    int *cbinary;
    int error;

    fflush(stdout);
    
    p_image_file = fopen(p_image_name, "rb");

    // Barr-C: When checking equivalence with a constant, the constant should be on the left (8.6.a)
    if (NULL == p_image_file) 
    {
        perror("Error: Could not open file");
    }

    //Move to end of file header
    error = fseek(p_image_file, 54, SEEK_SET);

    if (0 != error) 
    {
        perror("Error: Could not seek past header of file");
    }
    
    //Move to end of Colour table
    error = fseek(p_image_file, 1024, SEEK_CUR);

    if (0 != error) 
    {
        perror("Error: Could not seek past colour table of file");
    }
    
    for (int i = 0; i < IMAGE_HEIGHT; i++) 
    {
        for (int j = 0; j < 80; j++) 
        {
            error = fread(cbinary, 4, 1, p_image_file);

            if (error < 1)
            {
                break;
            }
            else
            {
                g_pixel_matrix[i][j] = *cbinary;
            }
        }
    }
    fclose(p_image_file);
}

void get_next_group(int current_x, int current_y, int32_t p_current_group[][8]) 
{
    uint32_t masks[4] = { 0x000000FF, 0x0000FF00, 0x00FF0000, 0xFF000000 };
    uint32_t shift;
    uint32_t mask_index;
    uint32_t cur_value;
    uint32_t pixel_value;

    for (int i = 0; i < 8; i++) 
    {
        for (int j = 0; j < 8; j++) 
        {
            shift = j >> 2;
            mask_index = j - ((shift) << 2);
            
            cur_value = g_pixel_matrix[current_y + i][current_x + shift];
            pixel_value = (cur_value & masks[mask_index]) >> ((mask_index) << 3);

            p_current_group[i][j] = pixel_value;
        }
    }
}

int main(int argc, char *argv[])
{
    int32_t current_group_trans[8][8];
    int32_t current_group[8][8];
    
    if (argc != 2)
    {
        printf("Error: 1 arg expected {filename}, received: %d\n", (argc - 1));
        return 1;
    }

    printf("Filename: %s\n", argv[1]);

    printf("\n----TESTING AREA----\n");

    get_image(argv[1]);

    get_next_group(0, 0, current_group);

    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            printf("%d, ", current_group[i][j]);
        }
        printf("\n");
    }
    printf("\n");

    get_next_group(40, 120, current_group);

    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            printf("%d, ", current_group[i][j]);
        }
        printf("\n");
    }
    printf("\n");
}