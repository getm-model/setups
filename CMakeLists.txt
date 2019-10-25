cmake_minimum_required(VERSION 3.0)

project(getm-setups VERSION 2.5.0 LANGUAGES Fortran)

mark_as_advanced( FORCE GETM_BASE )
find_path( GETM_BASE CMakeLists.txt HINTS ENV GETM_BASE DOC "Path to GETM source directory." )
if ( ${GETM_BASE} STREQUAL "GETM_BASE-NOTFOUND" )
    message( FATAL_ERROR "You must set the the environment variable to point to the GETM source code" ) 
else()
    message( "Using GETM source code from: " ${GETM_BASE} ) 
endif()

# ----------------------------
# User-configurable options
# ----------------------------
if( NOT GETM_SETUP )
    set( GETM_SETUP "_AA_" CACHE STRING "name of folder with GETM setup" FORCE )
else()
    set_property(CACHE GETM_SETUP PROPERTY STRINGS "syĺt" "box_cartesian" "box_curvilinear" "box_spherical")
endif()

# Options used by GETM executable configuration
set( GETM_EMBED_VERSION ON )

if( ${GETM_SETUP} STREQUAL "_AA_" )
    message( "Building dynamiclly allocated executable" )
    set( GETM_USE_STATIC OFF )
    set( CMAKE_INSTALL_PREFIX ${PROJECT_SOURCE_DIR} )
else()
    message( "Building static executable for - " ${GETM_SETUP} )
    set( GETM_USE_STATIC ON )
    set( CMAKE_INSTALL_PREFIX ${PROJECT_SOURCE_DIR}/${GETM_SETUP} )
    include( "${GETM_SETUP}/CMakeLists.txt" )
endif()

# Ready to add the GETM source code
add_subdirectory( ${GETM_BASE} getm )
