#include <omp.h>
#include <cstdio>

__global__ void kernelAddConstant(int *g_a, const int b)
{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    g_a[ idx ] += b;
}

int CheckResult( int *data, const int n, const int b )
{
    for ( int i = 0; i < n; ++ i )
    {
        if ( data[i] != i + b ) return 0;
    }
    
    return 1;
}

int main(int argc, char* argv[])
{
    int num_gpus = 0;
    
    std::printf("%s Starting...\n\n", argv[0]);
    
    cudaGetDeviceCount(&num_gpus);
    
    if ( num_gpus < 1 ) {
        std::printf("no CUDA capable devices were detected\n");
        return 1;
    }
    
    std::printf("number of host CPUs:\t%d\n", omp_get_num_procs());
    std::printf("number of CUDA devices:\t%d\n", num_gpus);
    
    for ( int i = 0; i < num_gpus; ++ i )
    {
        cudaDeviceProp dprop;
        cudaGetDeviceProperties(&dprop, i);
        std::printf("   %d: %s\n", i, dprop.name);
    }

    std::printf("---------------------------\n");

    unsigned int n = num_gpus * 8192;
    unsigned int nbytes = n * sizeof(int);

    int * a = (int *)std::malloc( nbytes );
    int b   = 3;    
    
    for ( unsigned int i = 0; i < n; ++ i )
    {
        a[i] = i;
    }
    
    omp_set_num_threads(2*num_gpus);
#pragma omp parallel
    {
        unsigned int cpu_thread_id = omp_get_thread_num();
        unsigned int num_cpu_threads = omp_get_num_threads();
        int gpu_id = -1;
        cudaSetDevice(cpu_thread_id % num_gpus );
        cudaGetDevice(&gpu_id);
        std::printf("CPU thread %d (of %d) uses CUDA device %d\n", cpu_thread_id,num_cpu_threads, gpu_id);
        int *d_a = 0;
        int *sub_a = a + cpu_thread_id * n / num_cpu_threads;
               
        unsigned int nbytes_per_kernel = nbytes / num_cpu_threads;
        dim3 gpu_threads(128);  // 128 threads per block
        dim3 gpu_blocks( n / ( gpu_threads.x * num_cpu_threads ) );
        std::printf("gpu_threads.x=%d gpu_threads.y=%d gpu_threads.z=%d\n", gpu_threads.x,gpu_threads.y, gpu_threads.z);
        std::printf("gpu_blocks.x=%d gpu_blocks.y=%d gpu_blocks.z=%d\n", gpu_blocks.x,gpu_blocks.y, gpu_blocks.z);
        
        cudaMalloc( (void **)&d_a, nbytes_per_kernel );
        cudaMemset( d_a, 0, nbytes_per_kernel );
        cudaMemcpy( d_a, sub_a, nbytes_per_kernel, cudaMemcpyHostToDevice );
        kernelAddConstant<<<gpu_blocks, gpu_threads>>>( d_a, b );
        
        cudaMemcpy( sub_a, d_a, nbytes_per_kernel, cudaMemcpyDeviceToHost );
        cudaFree( d_a );
    }
    bool bResult = CheckResult(a, n, b);
    if ( bResult )
    {
        std::printf( "CHECK PASSED!\n" );
    }
    else
    {
        std::printf( "CHECK FAILED!\n" );
    }
    std::free(a);
    return 0;
}
