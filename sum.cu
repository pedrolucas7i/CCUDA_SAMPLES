#include <stdio.h>
#include <stdlib.h>
#include <math.h>

__global__ void sum(short vec_size, int *a, int *b) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < vec_size) {
        b[i] = a[i] + b[i];
    }
}

int main() {
    int *a, *b, *d_a, *d_b;
    
    short vect_size = 254;
    unsigned long lenght = sizeof(int)*vect_size;
    
    a = (int*)malloc(lenght);
    b = (int*)malloc(lenght);

    srand(time(NULL));
    
    
    printf("C CUDA SAMPLE (SUM OF VECTORS)\n\nA -> [");
    
    for (int i = 0; i < vect_size-1; i++) {
        printf("%d,", a[i] = rand() % 25);
    }
    printf("%d]\n\nB -> [", a[vect_size-1] = rand() % 25);

    for (int i = 0; i < vect_size-1; i++) {
        printf("%d,", b[i] = rand() % 25);
    }
    printf("%d]\n", b[vect_size-1] = rand() % 25);

    
    cudaMalloc(&d_a, lenght);
    cudaMalloc(&d_b, lenght);
    
    cudaMemcpy(d_a, a, lenght, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, lenght, cudaMemcpyHostToDevice);

    sum<<<(vect_size+255)/256, 256>>>(vect_size, d_a, d_b);

    cudaMemcpy(b, d_b, lenght, cudaMemcpyDeviceToHost);

    printf("\nFINAL -> [");
    int i = 0;
    for(;i<vect_size-1; i++) {
        printf("%d,", b[i]);
    }
    printf("%d]\n", b[vect_size-1]);

    cudaFree(d_a);
    cudaFree(d_b);
    free(a);
    free(b);


}