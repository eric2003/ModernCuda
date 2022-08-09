#include <cstdio>
#include <cstdlib>
#include <string>
#include <omp.h>
#include <mpi.h>
#include "TimeSpan.h"

int GetThreadCount( int argc, char** argv );
int GetThreadCount( int argc, char** argv )
{
    int nThreads = 1;
    if ( argc < 2 )
    {
        return nThreads;
    }
    std::size_t pos{};
    nThreads = std::stoi( argv[1], &pos );
    return nThreads;
}

int main(int argc, char *argv[]) {
    const int N = 10000000000;
    const double h = 1.0/N;
    const double PI = 3.141592653589793238462643;
    int myrank,nproc;
    MPI_Init(&argc,&argv); 
    MPI_Comm_rank(MPI_COMM_WORLD,&myrank); 
    MPI_Comm_size(MPI_COMM_WORLD,&nproc);

    int nThreads = GetThreadCount( argc, argv );
    omp_set_num_threads( nThreads );
    TimeSpan ts; 
    double sum = 0.0;
    #pragma omp parallel for shared(N,h,myrank,nproc),reduction(+:sum)
    for ( int i = myrank; i <= N; i = i + nproc )
    {
        double x = h * static_cast<double>( i ); 
        sum += 4.0/( 1.0 + x * x );
    }
    double mypi = h * sum;
    double pi;
    MPI_Reduce(&mypi,&pi,1,MPI_DOUBLE,MPI_SUM,0,MPI_COMM_WORLD);
    if ( myrank == 0 )
    {
        ts.ShowTimeSpan();
        double error = pi - PI;
        error = error< 0 ? -error:error;
        std::printf("pi = %18.16f +/- %18.16f\n",pi,error); 
    }
    MPI_Finalize(); 
    return 0;
}
