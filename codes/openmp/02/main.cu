#include <omp.h>
#include <cstdio>

int main(int argc, char* argv[])
{
    int num_gpus = 0;
    
    std::printf("%s Starting...\n\n", argv[0]);
    
    cudaGetDeviceCount(&num_gpus);
    
    if ( num_gpus < 1 ) {
        std::printf("no CUDA capable devices were detected\n");
        return 1;
    }
    
    /////////////////////////////////////////////////////////////////
    // display CPU and GPU configuration
    //
    std::printf("number of host CPUs:\t%d\n", omp_get_num_procs());
    std::printf("number of CUDA devices:\t%d\n", num_gpus);
    
    for ( int i = 0; i < num_gpus; ++ i )
	{
        cudaDeviceProp dprop;
        cudaGetDeviceProperties(&dprop, i);
        std::printf("   %d: %s\n", i, dprop.name);
    }

    std::printf("---------------------------\n");
	
#pragma omp parallel
    {
        unsigned int cpu_thread_id = omp_get_thread_num();
        unsigned int num_cpu_threads = omp_get_num_threads();
        std::printf("CPU thread %d (of %d)\n", cpu_thread_id, num_cpu_threads);
    }
    return 0;
}
