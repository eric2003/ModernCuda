cmd.exe "/K" '"C:\Program Files (x86)\Intel\oneAPI\setvars.bat" && powershell'
cmake -DCMAKE_C_COMPILER=icx -DCMAKE_CXX_COMPILER=icx -DCMAKE_BUILD_TYPE=Release -GNinja ..
cmake --build .
mpiexec -n 4 .\testprj.exe

cmake .. -D CMAKE_BUILD_TYPE=Debug
cmake --build . --config Debug
cmake .. -D CMAKE_BUILD_TYPE=Release
cmake --build . --config Release


cmake .. -D CMAKE_BUILD_TYPE=Release
cmake --build . --config Release
PS D:\work\mpi_work\ModernMPI\codes\pi\mpi_omp\01\build> mpiexec -n 1 .\Release\testprj.exe 1
 time elapsed : 1.23189 seconds
pi = 3.1415926557174387 +/- 0.0000000021276456
PS D:\work\mpi_work\ModernMPI\codes\pi\mpi_omp\01\build> mpiexec -n 2 .\Release\testprj.exe 1
 time elapsed : 0.650616 seconds
pi = 3.1415926557176190 +/- 0.0000000021278259
PS D:\work\mpi_work\ModernMPI\codes\pi\mpi_omp\01\build> mpiexec -n 2 .\Release\testprj.exe 2
 time elapsed : 0.460508 seconds
pi = 3.1415926557174085 +/- 0.0000000021276154
PS D:\work\mpi_work\ModernMPI\codes\pi\mpi_omp\01\build> mpiexec -n 4 .\Release\testprj.exe 1
 time elapsed : 0.460375 seconds
pi = 3.1415926557171856 +/- 0.0000000021273925
PS D:\work\mpi_work\ModernMPI\codes\pi\mpi_omp\01\build> mpiexec -n 4 .\Release\testprj.exe 2
 time elapsed : 0.279716 seconds
pi = 3.1415926557174005 +/- 0.0000000021276074
PS D:\work\mpi_work\ModernMPI\codes\pi\mpi_omp\01\build> mpiexec -n 4 .\Release\testprj.exe 4
 time elapsed : 0.172297 seconds
pi = 3.1415926557173703 +/- 0.0000000021275772
PS D:\work\mpi_work\ModernMPI\codes\pi\mpi_omp\01\build> mpiexec -n 4 .\Release\testprj.exe 8
 time elapsed : 0.223923 seconds
pi = 3.1415926557173224 +/- 0.0000000021275293
PS D:\work\mpi_work\ModernMPI\codes\pi\mpi_omp\01\build> mpiexec -n 8 .\Release\testprj.exe 1
 time elapsed : 0.262272 seconds
pi = 3.1415926557174405 +/- 0.0000000021276474
PS D:\work\mpi_work\ModernMPI\codes\pi\mpi_omp\01\build> mpiexec -n 8 .\Release\testprj.exe 2
 time elapsed : 0.156524 seconds
pi = 3.1415926557174512 +/- 0.0000000021276580
PS D:\work\mpi_work\ModernMPI\codes\pi\mpi_omp\01\build> mpiexec -n 8 .\Release\testprj.exe 4
 time elapsed : 0.212333 seconds
pi = 3.1415926557173326 +/- 0.0000000021275395
PS D:\work\mpi_work\ModernMPI\codes\pi\mpi_omp\01\build> mpiexec -n 16 .\Release\testprj.exe 1
 time elapsed : 0.166623 seconds
pi = 3.1415926557174023 +/- 0.0000000021276092
PS D:\work\mpi_work\ModernMPI\codes\pi\mpi_omp\01\build> mpiexec -n 16 .\Release\testprj.exe 2
 time elapsed : 0.237595 seconds
pi = 3.1415926557173339 +/- 0.0000000021275408