# Based on pabloariasal's "Modern CMake Sample"
cmake_minimum_required(VERSION 3.0.2 FATAL_ERROR)

project(libb64 VERSION 1.0.0 LANGUAGES C)
list(INSERT CMAKE_MODULE_PATH 0 ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# Declare files that are part of the library
add_library(libb64
    src/cencode.c
    src/cdecode.c
    include/b64/cencode.h
    include/b64/cdecode.h
)

# Declare which files are public and private when exporting
target_include_directories(libb64
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
)
add_library(libb64::libb64 ALIAS libb64)

# Create installation instructions for clients
include(GNUInstallDirs)
set(INSTALL_CONFIGDIR ${CMAKE_INSTALL_LIBDIR}/cmake/libb64)

install(TARGETS libb64
    EXPORT libb64-targets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(EXPORT libb64-targets
    FILE libb64Targets.cmake
    NAMESPACE libb64::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/libb64
)

# Export the CMake files found in the source and build trees
export(EXPORT libb64-targets
    FILE ${CMAKE_CURRENT_BINARY_DIR}/libb64Targets.cmake
    NAMESPACE libb64::
)

configure_file(${CMAKE_CURRENT_LIST_DIR}/cmake/Findlibb64.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/Findlibb64.cmake
    COPYONLY
)

export(EXPORT libb64-targets
    FILE ${CMAKE_CURRENT_BINARY_DIR}/libb64Targets.cmake
    NAMESPACE libb64::
)

# Register the package in the user package registry
export(PACKAGE libb64)
