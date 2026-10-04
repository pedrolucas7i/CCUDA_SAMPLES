#include <stdio.h>
#include <stdlib.h>
#include <math.h>

__global__ void sum(short vec_size, int *a) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < vec_size) {
        a[i] = a[i] << 1; // 2*a[i]
    }
}

int main() {
    int *a, *d_a;
    
    int vect_size = 1<<14;
    unsigned long lenght = sizeof(int)*vect_size;
    
    a = (int*)malloc(lenght);

    srand(time(NULL));
    
    
    printf("C CUDA SAMPLE (MULT OF VECTOR)\n\nA -> [");
    
    for (int i = 0; i < vect_size-1; i++) {
        printf("%d,", a[i] = rand() % 25);
    }
    printf("%d]\n", a[vect_size-1] = rand() % 25);

    
    cudaMalloc(&d_a, lenght);
    
    cudaMemcpy(d_a, a, lenght, cudaMemcpyHostToDevice);

    sum<<<(vect_size+255)/256, 256>>>(vect_size, d_a);

    cudaMemcpy(a, d_a, lenght, cudaMemcpyDeviceToHost);

    printf("\nFINAL -> [");
    int i = 0;
    for(;i<vect_size-1; i++) {
        printf("%d,", a[i]);
    }
    printf("%d]\n", a[vect_size-1]);

    cudaFree(d_a);
    free(a);

}