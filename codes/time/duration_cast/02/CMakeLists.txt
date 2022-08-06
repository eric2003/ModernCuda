cmake_minimum_required(VERSION 3.20)

project ( testprj )

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()
message(STATUS "Build directory: ${PROJECT_BINARY_DIR}")
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

set ( PRJ_COMPILE_FEATURES )

list ( APPEND PRJ_COMPILE_FEATURES cxx_std_23 )

add_executable( ${PROJECT_NAME}
    main.cpp
)

target_compile_features ( ${PROJECT_NAME} 
    PRIVATE 
        ${PRJ_COMPILE_FEATURES}
)
