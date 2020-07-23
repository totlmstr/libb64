# Findlibb64.cmake
#
# Finds the libb64 library
#
# This will define the following variables
#
#    libb64_FOUND
#    libb64_INCLUDE_DIRS
#
# and the following imported targets
#
#     libb64::libb64
#
# Based on pabloariasal's "Modern CMake Sample"

find_package(PkgConfig)
pkg_check_modules(PC_libb64 QUIET libb64)

find_path(libb64_INCLUDE_DIR
    NAMES
        cencode.h
        cdecode.h
    PATHS ${PC_libb64_INCLUDE_DIRS}
    PATH_SUFFIXES b64
)

set(libb64_VERSION ${PC_libb64_VERSION})

mark_as_advanced(libb64_FOUND libb64_INCLUDE_DIR libb64_VERSION)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(libb64
    REQUIRED_VARS libb64_INCLUDE_DIR
    VERSION_VAR libb64_VERSION
)

if(libb64_FOUND)
    set(libb64_INCLUDE_DIRS ${libb64_INCLUDE_DIR})
endif()

if(libb64_FOUND AND NOT TARGET libb64::libb64)
    add_library(libb64::libb64 INTERFACE IMPORTED)
    set_target_properties(libb64::libb64 PROPERTIES
        INTERFACE_INCLUDE_DIRECTORIES "${libb64_INCLUDE_DIR}"
    )
endif()
