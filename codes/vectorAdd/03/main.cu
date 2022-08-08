#include <stdio.h>
#include <iostream>
#include <cuda_runtime.h>
#include <ctime>
#include <chrono>
#include "TimeSpan.h"

__global__ void vectorAdd( const float *A, const float *B, float *C, int numElements )
{
    int i = blockDim.x * blockIdx.x + threadIdx.x;
    
    if ( i < numElements )
    {
        C[i] = A[i] + B[i] + 0.0f;
    }
}

void Check( const float *A, const float *B, const float *C, int numElements )
{
    // Verify that the result vector is correct
    for ( int i = 0; i < numElements; ++ i )
    {
        if ( std::fabs(A[i] + B[i] - C[i]) > 1e-5 )
        {
            fprintf(stderr, "Result verification failed at element %d!\n", i);
            std::exit(EXIT_FAILURE);
        }
    }
    std::printf("Test PASSED\n");
}

void vectorAddSerial( const float *A, const float *B, float *C, int numElements )
{
    // Verify that the result vector is correct
    for ( int i = 0; i < numElements; ++ i )
    {
        C[i] = A[i] + B[i] + 0.0f;
    }
}

void vectorAddSerial()
{
    int numElements = 50000000;
    size_t size = numElements * sizeof(float);
    std::printf("[Vector addition of %d elements]\n", numElements);
   
    float *h_A = (float *)std::malloc(size);
    float *h_B = (float *)std::malloc(size);
    float *h_C = (float *)std::malloc(size);
	
    
    for ( int i = 0; i < numElements; ++i )
    {
        h_A[i] = rand() / (float)RAND_MAX;
        h_B[i] = rand() / (float)RAND_MAX;
    }
	
    TimeSpan ts;
    ts.Start();
	
	vectorAddSerial( h_A, h_B, h_C, numElements );
	
	ts.ShowTimeSpan("vectorAddSerial");	
	
	Check( h_A, h_B, h_C, numElements );
	
    
    std::free(h_A);
    std::free(h_B);
    std::free(h_C);
    
    std::printf("Done\n");
}

int main(int argc, char* argv[])
{
	vectorAddSerial();
    //int numElements = 50000;
    int numElements = 50000000;
    size_t size = numElements * sizeof(float);
    std::printf("[Vector addition of %d elements]\n", numElements);
    
    float *h_A = (float *)std::malloc(size);
    float *h_B = (float *)std::malloc(size);
    float *h_C = (float *)std::malloc(size);
    
    for ( int i = 0; i < numElements; ++i )
    {
        h_A[i] = rand() / (float)RAND_MAX;
        h_B[i] = rand() / (float)RAND_MAX;
    }
    
    float *d_A = NULL;
    float *d_B = NULL;
    float *d_C = NULL;
    cudaMalloc((void **)&d_A, size);
    cudaMalloc((void **)&d_B, size);
    cudaMalloc((void **)&d_C, size);
    
    std::printf("Copy input data from the host memory to the CUDA device\n");
    cudaMemcpy(d_A, h_A, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, h_B, size, cudaMemcpyHostToDevice);
    
    // Launch the Vector Add CUDA Kernel
    int threadsPerBlock = 256;
    int blocksPerGrid = ( numElements + threadsPerBlock - 1 ) / threadsPerBlock;
    std::printf("CUDA kernel launch with %d blocks of %d threads\n", blocksPerGrid,
               threadsPerBlock);
    TimeSpan ts;
    ts.Start();
    vectorAdd<<<blocksPerGrid, threadsPerBlock>>>(d_A, d_B, d_C, numElements);
    {
        cudaDeviceSynchronize();
        ts.ShowTimeSpan("vectorAddCUDA");
    }

    std::printf("Copy output data from the CUDA device to the host memory\n");
    cudaMemcpy(h_C, d_C, size, cudaMemcpyDeviceToHost);
	
	Check( h_A, h_B, h_C, numElements );
    
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    
    std::free(h_A);
    std::free(h_B);
    std::free(h_C);
    
    std::printf("Done\n");
    return 0;
}
