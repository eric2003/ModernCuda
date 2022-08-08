#include <omp.h>
#include <cstdio>

int main(int argc, char* argv[])
{
    std::printf("number of host CPUs:\t%d\n", omp_get_num_procs());
    int nThreads = 2;
    std::printf("nThreads=%d\n", nThreads);
    omp_set_num_threads(nThreads);
#pragma omp parallel
    {
        unsigned int cpu_thread_id = omp_get_thread_num();
        unsigned int num_cpu_threads = omp_get_num_threads();
        std::printf("CPU thread %d (of %d)\n", cpu_thread_id, num_cpu_threads);
    }
    return 0;
}
