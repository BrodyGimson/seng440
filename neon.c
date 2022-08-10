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
int const END_SCALE = 1024;                                        // Ending scale factor


// Barr-C: Global variables should start with "g_" (7.1.j)
int32_t g_pixel_matrix[240][320];
int32_t g_output_matrix[240][320];
int32x2_t g_current_group[4][8];

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
	fclose(p_image_file);
}

void transpose(int32x2_t orig[4][8], int32x2_t trans[4][8])
{
    int32_t temp_trans[8][8];
    int32_t temp_orig[4][8][2];
	for (int i = 0; i < 8; i++)
    {
		
		for(int k = 0; k < 8; ++k){
			vst1_s32(temp_orig[i>>1][k], orig[i>>1][k]);
		}
	}
    for(int i = 0; i < 8; i++){
        for (int j = 0; j < 8; j++) 
        {
        	temp_trans[i][j] = temp_orig[j>>1][i][j%2];
        }
    }
	
	for (int i = 0; i < 8; i+=2) 
    {
		int32_t pix_group[2];
		for (int j = 0; j < 8; ++j){
        	
			pix_group[0] = temp_trans[i][j];
			pix_group[1] = temp_trans[i+1][j];
			trans[i>>1][j] = vld1_s32(pix_group);
		}
    }
}

void get_next_group(int current_x, int current_y) 
{
    for (int i = 0; i < 8; i+=2) 
    {
		for (int j = 0; j < 8; ++j){
        		int32_t pix_group[2];
			pix_group[0] = g_pixel_matrix[current_y + i][current_x + j];
			pix_group[1] = g_pixel_matrix[current_y + i+1][current_x + j];
			
			g_current_group[i>>1][j] = vld1_s32(pix_group);
			//int32_t temp[2];
			//vst1_s32(temp, g_current_group[i>>1][j]);
			//printf("%d ", temp[0]);
		}
    }
}

void * reflector(int32x2_t input_1, int32x2_t input_2, int32x2_t *p_output_1, int32x2_t *p_output_2)
{       
    p_output_1[0] = vadd_s32(input_1, input_2);
    p_output_2[0] = vsub_s32(input_1, input_2);
}

void rotator(int32x2_t input_1, int32x2_t input_2, int c, int32x2_t *p_output_1, int32x2_t *p_output_2)
{
	int ROTATE_CONST[3] = {16069, 13622, 8866}; 	// Constant used for both in rotators
    // Barr-C: Don't rely on C's operation precedence rules, use parentheses (1.4.a)
    int32x2_t p_output_1_mul_1 = vmul_n_s32(input_2, ROTATE_CONST_p_output_1[c]);
    int32x2_t p_output_1_add_1 = vadd_s32(input_1, input_2);
    int32x2_t p_output_1_mul_2 = vmul_n_s32(p_output_1_add_1, ROTATE_CONST[c]);
 
    p_output_1[0] = vadd_s32(p_output_1_mul_1, p_output_1_mul_2);

    int32x2_t p_output_2_mul_1 = vmul_n_s32(input_1, ROTATE_CONST_p_output_2[c]);
    int32x2_t p_output_2_add_1 = vadd_s32(input_1, input_2);
    int32x2_t p_output_2_mul_2 = vmul_n_s32(p_output_2_add_1, ROTATE_CONST[c]);
    p_output_2[0] = vadd_s32(p_output_2_mul_1, p_output_2_mul_2);
    
}

int32x2_t scale_up(int32x2_t input)
{
    int32x2_t output;
	input = vshr_n_s32(input, 7);
    output = vmul_n_s32(input, SQRT2);
    return output;
}

void * loefflers(int32x2_t x[8])
{
	int32x2_t tmp_output[8];
    //stage 1
    reflector(x[0], x[7], &tmp_output[0], &tmp_output[7]);
    reflector(x[1], x[6], &tmp_output[1], &tmp_output[6]);
    reflector(x[2], x[5], &tmp_output[2], &tmp_output[5]);
    reflector(x[3], x[4], &tmp_output[3], &tmp_output[4]);
    
	//Even Numbers
    //stage 2
    reflector(tmp_output[0], tmp_output[3], &tmp_output[0], &tmp_output[3]);
    reflector(tmp_output[1], tmp_output[2], &tmp_output[1], &tmp_output[2]);
	
	//stage 3
    reflector(tmp_output[0], tmp_output[1], &tmp_output[0], &tmp_output[1]);
    rotator(tmp_output[2], tmp_output[3], 2, &tmp_output[2], &tmp_output[3]);
	
	// unscramble values
    x[0] = vshl_n_s32(tmp_output[0], 5);
    x[4] = vshl_n_s32(tmp_output[1], 5);
    x[2] = vshr_n_s32(tmp_output[2], 9);
    x[6] = vshr_n_s32(tmp_output[3], 9);
	
    //Odd Numbers
	//stage 2
    rotator(tmp_output[4], tmp_output[7], 1, &tmp_output[4], &tmp_output[7]);
    rotator(tmp_output[5], tmp_output[6], 0, &tmp_output[5], &tmp_output[6]);
    
	//stage 3
    reflector(tmp_output[4], tmp_output[6], &tmp_output[4], &tmp_output[6]);
    reflector(tmp_output[7], tmp_output[5], &tmp_output[7], &tmp_output[5]);
    
    //stage 4
    reflector(tmp_output[7], tmp_output[4], &tmp_output[7], &tmp_output[4]);
    tmp_output[5] = scale_up(tmp_output[5]);
    tmp_output[6] = scale_up(tmp_output[6]);  
    
	// unscramble values
    x[7] = vshr_n_s32(tmp_output[4], 9);
    x[3] = vshr_n_s32(tmp_output[5], 9);
    x[5] = vshr_n_s32(tmp_output[6], 9);
    x[1] = vshr_n_s32(tmp_output[7], 9);
	
}

int main(int argc, char *argv[])
{
    int32x2_t current_group_trans[4][8];
    int pos_x;
    int pos_y;

    if (argc != 2)
    {
        printf("Error: 1 arg expected {filename}, received: %d\n", (argc - 1));
        return 1;
    }

    printf("Filename: %s\n", argv[1]);

    printf("\n----TESTING AREA----\n");
    get_image(argv[1]);
    /*
    get_next_group(160, 120);
    
    transpose(g_current_group, current_group_trans);
    
    int32_t temp_output[4][8][2];
    for (int i = 0; i < 8; i+=2)
    {
		printf("i: %d\n", i>>1);
                for(int k = 0; k < 8; k++){
			//printf("%d", temp_output);
                        vst1_s32(temp_output[i>>1][k], current_group_trans[i>>1][k]);
                }
		//printf("temp output 0: %d ", temp_output[0][0]);
                for (int j = 0; j < 8; ++j)
                {
                	g_output_matrix[i][j] = temp_output[i>>1][j][0];
                        g_output_matrix[i + 1][j] = temp_output[i>>1][j][1];
                }
    }
    for(int i = 0; i < 8; i++){
	for(int j = 0; j < 8; j++){
		printf("%d, ", g_output_matrix[i][j]);
	}
	printf("\n");
    }
    
    int32x2_t testIn1 = {1, 2};
    int32x2_t testIn2 = {2, 1};
    int32x2_t testOut1;
    int32x2_t  testOut2;

    rotator(testIn1, testIn2, 0, &testOut1, &testOut2);
    int32_t testOutPrint1[2];
    int32_t testOutPrint2[2];
    vst1_s32(testOutPrint1, testOut1);
    vst1_s32(testOutPrint2, testOut2);
    printf("%f \n", (double)testOutPrint1[0]/16384);
    printf("%f \n", (double)testOutPrint2[0]/16384);
    */
    for (int y = 0; y < 30; ++y)
    {
        for (int x = 0; x < 40; ++x)
        {
			pos_x = x << 3;
            pos_y = y << 3;
			
    		get_next_group(pos_x, pos_y);
    		
    		for (int i = 0; i < 4; ++i)
            {
    			loefflers(g_current_group[i]);
    		}	
    		
    		transpose(g_current_group, current_group_trans);
    		
    		for (int i = 0; i < 4; ++i)
            {
    			loefflers(current_group_trans[i]);
    		}
    		
    		transpose(current_group_trans, g_current_group);

    		for (int i = 0; i < 8; i+=2) 
            {
        		int32_t temp_output[8][2];
			for(int k = 0; k < 8; k++){
					vst1_s32(temp_output[k], g_current_group[i>>1][k]);
			}
				for (int j = 0; j < 8; ++j) 
				{
            		g_output_matrix[pos_y + i][pos_x + j] = temp_output[j][0];
					g_output_matrix[pos_y + i + 1][pos_x + j] = temp_output[j][1];
        		}
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
