# Mìmir Samples

Examples for the Mìmir Library: Visualization of CUDA code with Vulkan

## Dependencies

### Required

- Vulkan 1.2 or higher
- CUDA 10 or higher (for Vulkan interop)
- Mìmir library (must be installed separately)

### Included

Mìmir Samples downloads additional dependencies via the FetchContent function provided by cmake:

- Slang
- GLFW
- ImGui
- ImGuiFileDialog

## Building

To build the samples, you need a C++20 host compiler, CUDA SDK >= 10.0 with the included nvcc device compiler, and cmake >= 3.24. After cloning or downloading the repository located at `<samples_dir>`, to generate a build in folder `<build_dir>`, run:

```bash
cmake -B <build_dir> -S <samples_dir>
cmake --build <build_dir> --config <mode> --parallel <ncores>
```

Compilation can be sped up by specifying the <ncores> value to the --parallel or -j option. Release and Debug builds can be generated by passing the respective value to the --config field.
## Running samples

A successful build with the above steps allows to run samples from the `build` directory, so running the unstructured domain sample should be executed as `./samples/run_structured`. The library currently provides the following samples:

* `run_unstructured`: Displays a 2D brownian moving point cloud with various sizes.
* `run_structured`: As above, but executing and a Jump Flood Algorithm (JFA) CUDA kernel to compute a Distance Transform (DT) over a regular structured grid, using point positions
as JFA seeds.
* `run_image [path_to_image]`: Simple image viewer for visualizing RGBA image formats. No CUDA kernel is executed in here.
* `run_texture [path_to_image]`: As above, but executes a box filter with periodically varying radii over the loaded image. Kernel code was ported from the [vulkanImageCUDA](https://github.com/NVIDIA/cuda-samples/tree/master/Samples/5_Domain_Specific/vulkanImageCUDA) CUDA sample.
* `run_mesh [path_to_off]`: Simple `.off` mesh viewer with no kernel execution. Support for more mesh formats is planned.
* `points3d`: As the unstructured sample, but over 3D space.
* `points3dcpy`: As `points3d`, but performing computation in host with OpenMP and transferring iteration results to device before displaying each time step.
* `automata3d`: Demonstrates the mapping of double buffered experiments in a ping-pong fashion to display the evolution of a 3D cellular automata. Press enter to advance the simulation.


# Current features
* Visualization of 2D structured and non-structured data
* Synchronous and asynchronous (on separate thread) rendering
