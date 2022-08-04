#include <stdio.h>

__global__ void MyCudaPrint();

__global__ void MyCudaPrint() {
    unsigned int idx = blockIdx.x * blockDim.x + threadIdx.x;
    printf("[ %d ] HelloWorld\n", idx);	
}

int main(int argc, char* argv[])
{
    MyCudaPrint <<<1, 1 >>> ();

    cudaDeviceSynchronize();

    return 0;
}