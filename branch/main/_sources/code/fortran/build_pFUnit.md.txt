---
orphan: true
---

# Example installation of pFUnit and pFUnit_demos

## Set up the environment

Installing pFUnit requires Git, a Fortran compiler and CMake.

### On a cluster

On an HPC cluster you might need to add a few environment modules. For
example, on [Tetralith](https://www.nsc.liu.se/systems/tetralith/) you
would do:

```bash
module add git/2.19.3-nsc1-gcc-system
module add CMake/3.16.4-nsc1
export FC=/software/sse/manual/mpprun/4.1.3/nsc-wrappers/ifort
```

### On own computer

If you don't have [CMake](https://cmake.org/) or a Fortran compiler
installed yet, one option is to install them into a conda environment
by first saving the following into a file `environment.yml`:

```yaml
name: compilers
channels:
  - conda-forge
dependencies:
  - cmake
  - compilers
```

followed by installing the packages into a new environment:
```bash
conda env create -f environment.yml
```
and finally activating the environment:
```bash
conda activate compilers
```

For good measure, set the `FC` variable to point to your
Fortran compiler (adjust path as needed):
```bash
export FC=$HOME/miniconda3/envs/compilers/bin/gfortran
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
cmake ..
```

## Build and install

The following will install pFUnit into a directory `installed` under
the `build` directory.

```bash
make tests
make install
```

## Compiling with pFUnit

When compiling with pFUnit, set:
```bash
export PFUNIT_DIR=$HOME/path/to/pFUnit/build/installed
```

and run CMake with `-DCMAKE_PREFIX_PATH=$PFUNIT_DIR`.


## Clone the pFUnit_demos repository

This is for testing and learning purposes.

```bash
git clone git@github.com:Goddard-Fortran-Ecosystem/pFUnit_demos.git
```

### Try out the Trivial, Basic, and MPI examples

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
