# Example installation of pFUnit and pFUnit_demos on [Tetralith](https://www.nsc.liu.se/systems/tetralith/)

## Load the environment

```bash
module add git/2.19.3-nsc1-gcc-system
module add CMake/3.16.4-nsc1
export FC=/software/sse/manual/mpprun/4.1.3/nsc-wrappers/ifort
```

## Clone the pFUnit repository

```bash
git clone --recursive git@github.com:Goddard-Fortran-Ecosystem/pFUnit.git
cd pFUnit
```

## Configure with Cmake

```bash
mkdir build
cd build
cmake -DMPI=YES -DOPENMP=YES -DCMAKE_INSTALL_PREFIX=./installed ../
```

## Build and install to local directory 'installed'

```bash
make -j tests
make install
```

## Clone the pFUnit_demos repository

```bash
git clone git@github.com:Goddard-Fortran-Ecosystem/pFUnit_demos.git
```


## Try out the Trivial, Basic, and MPI examples

```bash
cd pFUnit_demos
export PFUNIT_DIR=~pFUnit/build/installed/PFUNIT-4.2
cd Trivial
./build_with_cmake_and_run.x
cd ../Basic
./build_with_cmake_and_run.x
cd ../MPI
./build_with_cmake_and_run.x
´´´
