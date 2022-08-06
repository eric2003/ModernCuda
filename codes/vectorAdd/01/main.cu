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

int main(int argc, char* argv[])
{
    //int numElements = 50000;
    int numElements = 50000000;
    size_t size = numElements * sizeof(float);
    std::printf("[Vector addition of %d elements]\n", numElements);
    TimeSpan ts;
    clock_t clock_start;
    clock_t clock_end;  
    std::chrono::time_point<std::chrono::system_clock> c11_start, c11_end;
    using clock_type = std::chrono::time_point<std::chrono::system_clock>;
    clock_type time_now, time_old;
    typedef std::chrono::steady_clock Clock;
    Clock::time_point clock_t1, clock_t2;
    float elapsedTime = 0.0;
    cudaEvent_t event_start, event_stop;
    cudaEventCreate(&event_start);
    cudaEventCreate(&event_stop);
    cudaEventRecord(event_start, 0);
    clock_start = clock();
    c11_start = std::chrono::system_clock::now();
    time_old = std::chrono::system_clock::now();
    clock_t1 = std::chrono::steady_clock::now();
    ts.Start();
    
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
    vectorAdd<<<blocksPerGrid, threadsPerBlock>>>(d_A, d_B, d_C, numElements);
    std::printf("Copy output data from the CUDA device to the host memory\n");
    cudaMemcpy(h_C, d_C, size, cudaMemcpyDeviceToHost);
    
    // Verify that the result vector is correct
    for ( int i = 0; i < numElements; ++ i )
    {
        if ( std::fabs(h_A[i] + h_B[i] - h_C[i]) > 1e-5 )
        {
            fprintf(stderr, "Result verification failed at element %d!\n", i);
            std::exit(EXIT_FAILURE);
        }
    }
    
    std::printf("Test PASSED\n");
    
    cudaEventRecord(event_stop, 0);
    cudaEventSynchronize(event_stop);
    cudaEventElapsedTime(&elapsedTime, event_start, event_stop);
    std::printf("cudaevent time = %lfms\n", elapsedTime);
    {
        cudaDeviceSynchronize();
        clock_end= clock();
        double clock_diff_sec = ((double)(clock_end- clock_start) / CLOCKS_PER_SEC);
        std::printf("clock_ time: %lfms.\n", clock_diff_sec * 1000);    
    }
    {
        cudaDeviceSynchronize();
        c11_end = std::chrono::system_clock::now();
        int elapsed_seconds = std::chrono::duration_cast<std::chrono::milliseconds>
                             (c11_end-c11_start).count();
        std::printf("chrono time: %dms.\n", elapsed_seconds);
    }
    {
        cudaDeviceSynchronize();
        ts.ShowTimeSpan();
    }
    {
        cudaDeviceSynchronize();
        time_now = std::chrono::system_clock::now();
        double elapsed_ms = std::chrono::duration_cast<std::chrono::milliseconds>
                             (time_now-time_old).count();
        std::printf("chrono time: %lfms.\n", elapsed_ms);
    }
    {
        cudaDeviceSynchronize();
        time_now = std::chrono::system_clock::now();
        std::cout << "time_old.time_since_epoch().count() = " << time_old.time_since_epoch().count() << std::endl;
        std::cout << "time_now.time_since_epoch().count() = " << time_now.time_since_epoch().count() << std::endl;      
        std::cout << "(time_now - time_old).count() = " << (time_now - time_old).count() << std::endl;      
        std::cout << " time elapsed : " 
                  << std::chrono::duration_cast<std::chrono::milliseconds>(time_now - time_old).count()
                  << " milliseconds" << std::endl;      
    }
    {
        cudaDeviceSynchronize();
        clock_t2 = std::chrono::steady_clock::now();
        std::cout << "clock_t1.time_since_epoch().count() = " << clock_t1.time_since_epoch().count() << std::endl;
        std::cout << "clock_t2.time_since_epoch().count() = " << clock_t2.time_since_epoch().count() << std::endl;
        std::chrono::steady_clock::duration time_span = clock_t2 - clock_t1;
        std::cout << "(clock_t2 - clock_t1).count() = " << (clock_t2 - clock_t1).count() << std::endl;      
        std::cout << " time elapsed : " 
                  << double(std::chrono::duration_cast<std::chrono::milliseconds>(time_span).count())
                  << " milliseconds" << std::endl;
    }   
    
    
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    
    std::free(h_A);
    std::free(h_B);
    std::free(h_C);
    
    std::printf("Done\n");
    return 0;
}
