#
# Makefile for making STATIC version of the - box_curvilinear - executable.
#

SHELL	= /bin/sh

name	= box_curvilinear
setup	= $(name)

include ../Rules.make

STATIC += -DSTATIC -DUV_TVD -DCURVILINEAR

include ../Boxes.make
