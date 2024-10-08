cmake_minimum_required(VERSION 3.17)
project (RTX-RMQ LANGUAGES CXX CUDA)
include(FetchContent)

# Set default build type to 'Release'
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build, options are: Debug Release RelWithDebInfo MinSizeRel." FORCE)
endif(NOT CMAKE_BUILD_TYPE)

# add path to our CMake modules
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/CMake")

find_package(OpenMP)


FetchContent_Declare(mimir
    GIT_REPOSITORY https://github.com/temporal-hpc/mimir.git
    GIT_TAG        279e2ccea5f76fc806f5d867e8fc873b83ce4875 # master
    FIND_PACKAGE_ARGS
)
FetchContent_MakeAvailable(mimir)

add_subdirectory(powermon)
add_subdirectory(CA3D-voxels)
add_subdirectory(GPU-visual-tool-example)
add_subdirectory(image)
add_subdirectory(mesh3d)
add_subdirectory(points3d)
add_subdirectory(points3dcpu)
add_subdirectory(structured)
add_subdirectory(unstructured)
add_subdirectory(voronoi-simple)
add_subdirectory(texture_cudaarray)
#add_subdirectory(edgeflip)

# Copy slang shaders to output directory
add_custom_target(copy_shaders ALL
  COMMAND ${CMAKE_COMMAND} -E copy_directory
          ${PROJECT_SOURCE_DIR}/shaders
          ${PROJECT_BINARY_DIR}/samples/shaders/
  WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
  COMMENT "Copying test files..."
  VERBATIM
)
