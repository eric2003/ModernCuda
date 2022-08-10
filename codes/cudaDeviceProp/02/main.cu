#include <cstdio>
#include <cuda_runtime.h>

int main(int argc, char *argv[])
{
    int num_gpus = 0;    
    cudaGetDeviceCount( &num_gpus );

    for ( int iGpu = 0; iGpu < num_gpus; ++ iGpu )
    {
       cudaDeviceProp prop;
       cudaGetDeviceProperties( &prop, iGpu );

       std::printf( " --- General Information for device %d ---\n", iGpu );
       std::printf( "Device Name: %s\n", prop.name );
       std::printf( "Compute capability: %d.%d\n", prop.major, prop.minor );
       std::printf( "Clock rate: %d\n", prop.clockRate );
       std::printf( "Device copy overlap: " );
       
       if ( prop.deviceOverlap )
       {
            std::printf( "Enabled\n" );
       }
       else
       {
            std::printf( "Disabled\n" );
       }
       std::printf( "Kernel execition timeout : " );


       if ( prop.kernelExecTimeoutEnabled )
       {
            std::printf( "Enabled\n" );
       }
       else
       {
            std::printf( "Disabled\n" );
       }
    
       std::printf( " --- Memory Information for device %d ---\n", iGpu );
       std::printf( "Total global mem: %zd\n", prop.totalGlobalMem );
       std::printf( "Total constant Mem: %zd\n", prop.totalConstMem );
       std::printf( "Max mem pitch: %zd\n", prop.memPitch );
       std::printf( "Texture Alignment: %zd\n", prop.textureAlignment );
       std::printf( " --- MP Information for device %d ---\n", iGpu );
       std::printf( "Multiprocessor count: %d\n",prop.multiProcessorCount );
       std::printf( "Shared mem per mp: %zd\n", prop.sharedMemPerBlock );
       std::printf( "Registers per mp: %d\n", prop.regsPerBlock );
       std::printf( "Threads in warp: %d\n", prop.warpSize );
       std::printf( "Max threads per block: %d\n",prop.maxThreadsPerBlock );
       std::printf( "Max thread dimensions[0 - 2]: (%d, %d, %d)\n", prop.maxThreadsDim[0], prop.maxThreadsDim[1],prop.maxThreadsDim[2] );
       std::printf( "Max grid dimensions[0 - 2]: (%d, %d, %d)\n",prop.maxGridSize[0], prop.maxGridSize[1],prop.maxGridSize[2] );
       std::printf( "\n" );
    }
    
    return 0;
}
