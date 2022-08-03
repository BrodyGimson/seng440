#include <stdio.h>
#include <string.h>
#include <float.h>
#include <stdint.h>

/*
General Barr-C things that were followed included 
- Rules under 7.1 for variables
- Rules for bracing under 1.3
- Rules for line widths under 1.2
- Rules for parentheses under 1.4
- White space rules under section 3

More specific examples given as they appear and are assumed to be used throughout after
*/

// Image related constants
int const IMAGE_SIZE = 240*320;
int const IMAGE_HEIGHT = 240;
int const IMAGE_WIDTH = 320;

// Constants used in Loeffler's Algorithm
int const SQRT2 = 181;
int const ROTATE_CONST_p_output_1[3] = {-12873, -4520, 12539};      // Constants used for output 1 in rotators
int const ROTATE_CONST_p_output_2[3] = {-19266, -22725, -30273};    // Constants used for output 2 in rotators
int const ROTATE_CONST[3] = {16069, 13622, 8866};                   // Constants used for both in rotators
int const END_SCALE = 16384;                                        // Ending scale factor

// Barr-C: Global variables should start with "g_" (7.1.j)
int32_t g_pixel_matrix[240][320];
int32_t g_output_matrix[240][320];
int32_t g_current_group[8][8];

void get_image(char *p_image_name) 
{
    // Barr-C: Pointers should start with "p_" (7.1.k)
    // Barr-C: variables initialized before use (7.2.a)
    FILE *p_image_file;
    int cbinary;
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
        for (int j = 0; j < IMAGE_WIDTH; j++) 
        {
            cbinary = fgetc(p_image_file);

            if (cbinary  == EOF)
            {
                break;
            }
            else
            {
                g_pixel_matrix[i][j] = cbinary;
            }
        }
    }
}

void transpose(int32_t orig[][8], int32_t trans[][8])
{
    for (int i = 0; i < 8; i++)
    {
        for (int j = 0; j < 8; j++) 
        {
            trans[i][j] = orig[j][i];
        }
    }
}

void get_next_group(int current_x, int current_y) 
{
    for (int i = 0; i < 8; i++) 
    {
        for (int j = 0; j < 8; j++) 
        {
            g_current_group[i][j] = g_pixel_matrix[current_y + i][current_x + j];
        }
    }
}

void reflector(int32_t input_1, int32_t input_2, int32_t *p_output_1, int32_t *p_output_2)
{       
    p_output_1[0] = input_1 + input_2;
    p_output_2[0] = input_1 - input_2;
}

void rotator(int32_t input_1, int32_t input_2, int c, int32_t *p_output_1, int32_t *p_output_2)
{
    // Barr-C: Don't rely on C's operation precedence rules, use parentheses (1.4.a)
    p_output_1[0] = (ROTATE_CONST_p_output_1[c] * input_2) + (ROTATE_CONST[c] * (input_1 + input_2));
    p_output_2[0] = (ROTATE_CONST_p_output_2[c] * input_1) + (ROTATE_CONST[c] * (input_1 + input_2));
}

int32_t scale_up(int32_t input)
{
    int32_t output;

    input = input >> 7;
    output = SQRT2 * input;
    return output;
}

void loefflers(int32_t * x)
{
    int32_t tmp_output[8];
    
    //stage 1
    reflector(x[0], x[7], &tmp_output[0], &tmp_output[7]);
    reflector(x[1], x[6], &tmp_output[1], &tmp_output[6]);
    reflector(x[2], x[5], &tmp_output[2], &tmp_output[5]);
    reflector(x[3], x[4], &tmp_output[3], &tmp_output[4]);
    
    //stage 2
    reflector(tmp_output[0], tmp_output[3], &tmp_output[0], &tmp_output[3]);
    reflector(tmp_output[1], tmp_output[2], &tmp_output[1], &tmp_output[2]);
    
    rotator(tmp_output[4], tmp_output[7], 1, &tmp_output[4], &tmp_output[7]);
    rotator(tmp_output[5], tmp_output[6], 0, &tmp_output[5], &tmp_output[6]);
    
    //stage 3
    reflector(tmp_output[0], tmp_output[1], &tmp_output[0], &tmp_output[1]);
    rotator(tmp_output[2], tmp_output[3], 2, &tmp_output[2], &tmp_output[3]);
    reflector(tmp_output[4], tmp_output[6], &tmp_output[4], &tmp_output[6]);
    reflector(tmp_output[7], tmp_output[5], &tmp_output[7], &tmp_output[5]);
    
    //stage 4
    reflector(tmp_output[7], tmp_output[4], &tmp_output[7], &tmp_output[4]);
    tmp_output[5] = scale_up(tmp_output[5]);
    tmp_output[6] = scale_up(tmp_output[6]);  
    
    // unscramble values
    x[0] = tmp_output[0] << 7;
    x[4] = tmp_output[1] << 7;
    x[2] = tmp_output[2] >> 7;
    x[6] = tmp_output[3] >> 7;
    x[7] = tmp_output[4] >> 7;
    x[3] = tmp_output[5] >> 7;
    x[5] = tmp_output[6] >> 7;
    x[1] = tmp_output[7] >> 7;
}

int main(int argc, char *argv[])
{
    int32_t current_group_trans[8][8];
    
    if (argc != 2)
    {
        printf("Error: 1 arg expected {filename}, received: %d\n", (argc - 1));
        return 1;
    }

    printf("Filename: %s\n", argv[1]);

    printf("\n----TESTING AREA----\n");

    get_image(argv[1]);

    for (int x = 0; x < 40; x++)
    {
        for (int y = 0; y < 30; y++)
        {
    		get_next_group(8*x, 8*y);
    		
    		for (int i = 0; i < 8; i++)
            {
    			loefflers(g_current_group[i]);
    		}	
    		
    		transpose(g_current_group, current_group_trans);
    		
    		for (int i = 0; i < 8; i++)
            {
    			loefflers(current_group_trans[i]);
    		}
    		
    		transpose(current_group_trans, g_current_group);

    		for (int i = 0; i < 8; i++) 
            {
        		for (int j = 0; j < 8; j++) 
                {
            		g_output_matrix[x*8 + i][y*8 + j] = g_current_group[i][j];
        		}
    		}
    	}
    }

    printf("\nCorner 8x8:\n");
    for (int i = 0; i < 8; i++) 
    {
        for (int j = 0; j < 8; j++) 
        {
            printf("%f, ", (double) g_output_matrix[i][j] / END_SCALE);
        }
        printf("\n");
    }

    printf("\nCenter 8x8:\n");
    for (int i = 0; i < 8; i++) 
    {
        for (int j = 0; j < 8; j++) 
        {
            printf("%f, ", (double) g_output_matrix[i + 120][j + 160] / END_SCALE);
        }
        printf("\n");
    }
    			
    return 0;
}
