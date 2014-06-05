#import <Foundation/Foundation.h>
#import <Accelerate/Accelerate.h>

static size_t const iterations = 1000000;

int main(int argc, char * argv[]) {
    __block la_object_t result;
    float *resultBuffer = malloc(sizeof(float)*3);
    
    float m1[] = {
        1.0f, 1.0f, 1.0f,
        0.0f, 2.0f, 5.0f,
        2.0f, 5.0f, -1.0f
    };
    
    float v1[] = {
        6.0f,
        -4.0f,
        27.0f
    };
    
    la_object_t matrix = la_matrix_from_float_buffer(m1, 3, 3, 3, LA_NO_HINT, LA_DEFAULT_ATTRIBUTES);
    la_object_t vector = la_matrix_from_float_buffer(v1, 3, 1, 1, LA_NO_HINT, LA_DEFAULT_ATTRIBUTES);
    
    uint64_t t_0 = dispatch_benchmark(iterations, ^{
        @autoreleasepool {
            result = la_solve(matrix, vector);
        }
    });
    
    la_vector_to_float_buffer(resultBuffer, 1, result);
    NSLog(@"result:\nx=%f\ny=%f\nz=%f", resultBuffer[0], resultBuffer[1], resultBuffer[2]);
    NSLog(@"Avg. Runtime: %llu ns", t_0);
    
    free(resultBuffer);
    return 0;
}