cmake_minimum_required ( VERSION 3.20 )

project ( testprj )

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()
message(STATUS "Build directory: ${PROJECT_BINARY_DIR}")
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

set ( PRJ_COMPILE_FEATURES )
set ( PRJ_LIBRARIES )
set ( PRJ_INCLUDE_DIRS )

list ( APPEND PRJ_COMPILE_FEATURES cxx_std_20 )

find_package ( CUDAToolkit )
message ( STATUS  "CUDAToolkit_FOUND=${CUDAToolkit_FOUND}" )
if ( CUDAToolkit_FOUND )
    enable_language( CUDA )
    set ( CMAKE_CUDA_STANDARD 14 )
    set ( CMAKE_CUDA_ARCHITECTURES "60;72;75" )
    set ( CUDA_INCLUDE_DIRS )
endif ()

add_executable ( ${PROJECT_NAME}
    main.cu
    TimeSpan.cpp
)

set_target_properties( ${PROJECT_NAME}
    PROPERTIES 
        POSITION_INDEPENDENT_CODE ON
)

set_target_properties ( ${PROJECT_NAME}
    PROPERTIES
    CUDA_SEPARABLE_COMPILATION ON
)

target_include_directories ( ${PROJECT_NAME}
    PRIVATE
        ${PRJ_INCLUDE_DIRS}
)

target_link_libraries( ${PROJECT_NAME} 
    PRIVATE 
        ${PRJ_LIBRARIES}
)

target_compile_features ( ${PROJECT_NAME} 
    PRIVATE 
        ${PRJ_COMPILE_FEATURES}
)
