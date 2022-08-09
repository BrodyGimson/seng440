#include <stdio.h>
#include <string.h>
#include <float.h>
#include <stdint.h>
#include <arm_neon.h>

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
int const END_SCALE = 16384;                                        // Ending scale factor

// Barr-C: Global variables should start with "g_" (7.1.j)
int32_t g_pixel_matrix[240][320];
int32_t g_output_matrix[240][320];
int32x2x4_t g_current_group[8];

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
    
    for (int i = 0; i < IMAGE_HEIGHT; ++i) 
    {
        for (int j = 0; j < IMAGE_WIDTH; ++j) 
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

void transpose(int32x2x4_t orig[8], int32x2x4_t trans[8])
{
    int32_t temp_trans[8][4][2];
    int32_t temp_orig[8][4][2];
    for (int i = 0; i < 8; ++i){
	vst4_s32(temp_orig[i], orig[i]);
    }

    /*
    for (int i = 0; i < 8; ++i)
    {
        for (int j = 0; j < 8; ++j)
        {
		printf("%d, ", temp_orig[i][j>>1][j%2]);
	}
	printf("\n");
    }
    */

    for (int i = 0; i < 8; ++i)
    {
	for (int j = 0; j < 8; ++j) 
        {
            temp_trans[j][i>>1][i%2] = temp_orig[i][j>>1][j%2];
        }
    }

    //Required to ensure temp_trans is properly stored to the neon var
    for (int i = 0; i < 8; ++i)
    {
	trans[i] = vld4_s32(temp_trans[i]);
    }
}

void get_next_group(int current_x, int current_y) 
{
    int32_t temp_group[4][2];
    for (int i = 0; i < 8; ++i) 
    {
	for (int j = 0; j < 8; j += 2){
        	int32_t pix_group[2];
		pix_group[0] = g_pixel_matrix[current_y + i][current_x + j];
		pix_group[1] = g_pixel_matrix[current_y + i][current_x + j+1];
		
		temp_group[j>>1][0] = pix_group[0];
		temp_group[j>>1][1] = pix_group[1];
		//printf("\n %d \n", temp_group[j>>1][0]);
	}
	//printf("\n %d \n", temp_group[2][0]);
	//printf("%d, %d", g_current_group[0], vld4_s32(temp_group));
	g_current_group[i] = vld4_s32(temp_group);
	int32_t test[4][2];
	vst4_s32(test, g_current_group[i]);
	//printf("\n %d \n", test[2][0]);
    }
}

void * reflector(int32_t input_1, int32_t input_2, int32_t *p_output_1, int32_t *p_output_2)
{       
    p_output_1[0] = input_1 + input_2;
    p_output_2[0] = input_1 - input_2;
}

void rotator(int32_t input_1, int32_t input_2, int c, int32_t *p_output_1, int32_t *p_output_2)
{
	int ROTATE_CONST[3] = {16069, 13622, 8866}; 	// Constant used for both in rotators
    // Barr-C: Don't rely on C's operation precedence rules, use parentheses (1.4.a)
    p_output_1[0] = (ROTATE_CONST_p_output_1[c] * input_2) + (ROTATE_CONST[c] * (input_1 + input_2));
    p_output_2[0] = (ROTATE_CONST_p_output_2[c] * input_1) + (ROTATE_CONST[c] * (input_1 + input_2));
}

int32_t scale_up(int32_t input)
{
    int32_t output;

    output = SQRT2 * (input >> 7);
    return output;
}

int32x2x4_t loefflers(int32x2x4_t neon_x)
{
    int32_t tmp_output[8];
    int32_t x[4][2];
    vst4_s32(x, neon_x);
    //stage 1
    reflector(x[0][0], x[3][1], &tmp_output[0], &tmp_output[7]);
    reflector(x[0][1], x[3][0], &tmp_output[1], &tmp_output[6]);
    reflector(x[1][0], x[2][1], &tmp_output[2], &tmp_output[5]);
    reflector(x[1][1], x[2][0], &tmp_output[3], &tmp_output[4]);
    
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
    x[0][0] = tmp_output[0] << 7;
    x[2][0] = tmp_output[1] << 7;
    x[1][0] = tmp_output[2] >> 7;
    x[3][0] = tmp_output[3] >> 7;
    x[3][1] = tmp_output[4] >> 7;
    x[1][1] = tmp_output[5] >> 7;
    x[2][1] = tmp_output[6] >> 7;
    x[0][1] = tmp_output[7] >> 7;
    neon_x = vld4_s32(x);
    return neon_x;
}

int main(int argc, char *argv[])
{
    int32x2x4_t current_group_trans[8];
    
    if (argc != 2)
    {
        printf("Error: 1 arg expected {filename}, received: %d\n", (argc - 1));
        return 1;
    }

    printf("Filename: %s\n", argv[1]);

    printf("\n----TESTING AREA----\n");

    get_image(argv[1]);

    get_next_group(160, 120);
    
    for (int i = 0; i < 8; ++i) 
    {
        for (int j = 0; j < 8; ++j) 
        {
		int32_t output[4][2];
            	vst4_s32(output, g_current_group[i]);
		//printf("j>>1: %d, j%2: %d value: ", j>>1, j%2);
		printf("%d, ", output[j>>1][j%2]);
        }
        printf("\n");
    }
    printf("\n");
    get_next_group(160, 120);
    transpose(g_current_group, current_group_trans);
    
    for(int i = 0; i < 8; ++i){
	for(int j = 0; j < 8; ++j){
		int32_t output[4][2];
		vst4_s32(output, current_group_trans[i]);
		printf("%d, ", output[j>>1][j%2]);
	}
	printf("\n");
    }
    
    for (int x = 0; x < 40; ++x)
    {
        for (int y = 0; y < 30; ++y)
        {
    		get_next_group(8*x, 8*y);
    		
    		for (int i = 0; i < 8; ++i)
            	{
    			g_current_group[i] = loefflers(g_current_group[i]);
    		}	
    		
    		transpose(g_current_group, current_group_trans);
    		
    		for (int i = 0; i < 8; ++i)
            	{
    			current_group_trans[i] = loefflers(current_group_trans[i]);
    		}
    		
    		transpose(current_group_trans, g_current_group);

    		for (int i = 0; i < 8; ++i) 
            	{
        		int32_t temp_output[4][2];
			vst4_s32(temp_output, g_current_group[i]);
			for (int j = 0; j < 8; ++j) 
                	{
				//printf("%d ", temp_output[j>>1][j%2]);
            			g_output_matrix[x*8 + i][y*8 + j] = temp_output[j>>1][j%2];
        		}
			//printf("\n");
    		}
    	}
    }

    printf("\nCorner 8x8:\n");
    for (int i = 0; i < 8; ++i) 
    {
        for (int j = 0; j < 8; ++j) 
        {
            printf("%f, ", (double) g_output_matrix[i][j] / END_SCALE);
        }
        printf("\n");
    }

    printf("\nCenter 8x8:\n");
    for (int i = 0; i < 8; ++i) 
    {
        for (int j = 0; j < 8; ++j) 
        {
            printf("%f, ", (double) g_output_matrix[i + 120][j + 160] / END_SCALE);
        }
        printf("\n");
    }
    			
    return 0;
}
