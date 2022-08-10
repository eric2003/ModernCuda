#include <cstdio>
#include <cuda_runtime.h>

__global__ void printDimInfo()
{
    int blockId = blockIdx.x + blockIdx.y * gridDim.x
        + gridDim.x * gridDim.y * blockIdx.z;
    int threadId = blockId * (blockDim.x * blockDim.y * blockDim.z)
        + (threadIdx.z * (blockDim.x * blockDim.y))
        + (threadIdx.y * blockDim.x) + threadIdx.x;

    if ( threadId == 0 )
    {
        std::printf("block Dim =[%d,%d,%d]\n", blockDim.x, blockDim.y, blockDim.z);
        std::printf("grid  Dim =[%d,%d,%d]\n", gridDim.x, gridDim.y, gridDim.z);
        std::printf("\n");
    }
}

int main(int argc, char *argv[])
{
    dim3 dimGrid(4, 3, 2);
    dim3 dimBlock(2, 4, 6);
    printDimInfo<<<1, 10 >>>();
    printDimInfo<<<dimGrid, dimBlock >>>();

    cudaDeviceSynchronize();
    
    return 0;
}
