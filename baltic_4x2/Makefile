#
# Makefile for making STATIC version of the -  executable.
#

SHELL	= /bin/sh

.EXPORT_ALL_VARIABLES:

name	= baltic_4x2
setup	= $(name)

export STATIC	=  -DNEW_CORI -DITERATE_VERT_ADV  -DUV_TVD -DSPHERICAL -DNONNEGSALT

#export GETM_BIO=true
export FABM=false

include ../Rules.make

clone_sources:
	. ./clone_sources.sh

compile_getm:
	. ./compile_getm.sh


clean:

#-----------------------------------------------------------------------
#                                                                      !
#-----------------------------------------------------------------------
