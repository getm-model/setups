set( GETM_USE_STATIC ON )
set( CMAKE_INSTALL_PREFIX ${PROJECT_SOURCE_DIR}/seamount )
set( GETM_COORDINATE_TYPE Cartesian )

if ( NOT ${GETM_USE_PARALLEL} )
    set(IEXTR  66)
    set(JEXTR  66)
    set(IMAX   66)
    set(JMAX   66)
    set(KMAX   25)
else()
    set(IEXTR  66)
    set(JEXTR  66)
    set(IMAX   33)
    set(JMAX   33)
    set(KMAX   25)
endif()
