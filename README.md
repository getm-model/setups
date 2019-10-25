## Standard GETM\_SETUPs 

This repository contains a set of standard GETM setups that can be used to test and varify new developments.

The repository is a clone of the original repository on SourceForge (\*).

The major difference is the exclusive use of CMake to build the execuatbles - opposed to the Makefile based system on SourceForge. The major benefit being that setups can be tested on Windows.

This is work in progress - and there are things not working 100%.

### Various compilation methods

Below is given examples of different configurations. All options available when building GETM is also available - in addition it is possible to give the name of a setup - e.g. sylt - via \_-DGETM\_SETUP=sylt. When a setup is provided a static compilation is done and the executable is placed in <setup>/bin. If no setup is provided a dynamically allocated executable is made - it is placed in ./bin.

CMake encourage out of source compilation. The following examples are build from a folder \_build - hence the ../. The compilation can be done anywhere and then ../ must be ajusted accordingly.

#### Dynamical allocation with default Fortran compiler
cmake ../

#### Dynamical allocation with specified Fortran compiler
cmake -DCMAKE\_Fortran\_COMPILER=gfortran-8 ../

#### Dynamical allocation with specified Fortran compiler and parallel
cmake -DCMAKE\_Fortran\_COMPILER=gfortran-8 -DGETM\_SETUP=sylt -DGETM\_USE\_PARALLEL=ON ../

#### Specifying a specific setup implies static compilation
cmake -DCMAKE\_Fortran\_COMPILER=gfortran-8 -DGETM\_SETUP=sylt ../

#### Specifying a specific setup implies static compilation sudomain size in <setup>/CMakeLists.txt
cmake -DCMAKE\_Fortran\_COMPILER=gfortran-8 -DGETM\_SETUP=sylt -DGETM\_USE\_PARALLEL=ON ../

The specific subdomain sizes can be given in <setup>/CMakeLists.txt.


(\*) The setups in this repository will work with the GETM source code from [GitHub](https://github.com/getm-model/code). The GitHub version of GETM will over time diverge from the GETM source code on [SourceForge](https://sourceforge.net/projects/getm/) to the point where the two codes are not compatible.
