add_executable(run_points3d points3d.cu)
target_link_libraries(run_points3d PRIVATE mimir powermon)
set_target_properties(run_points3d PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/samples
)