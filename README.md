# Builddir

**builddir** is a little helper tool for C/C++ programmers to manage
out-of-source build directories. It manages mappings between build directories
and the associated source directories and allows to switch between them.

## Installation

Installation consists out of multiple steps. The first is to install the
builddir gem:
    $ gem install builddir

Second, a shell wrapper script (`builddir_script`) is required.


Third, define bash aliases
    alias builddir='source builddir_script'
    alias bdir='builddir'
    
    alias cds='builddir -s'
    alias cdb='builddir -cb'
    
    alias cmake='builddir_cmake'
    alias configure='builddir_configure'
    
Fourth, define the build directory root by exporting the DEFAULT_BUILD_DIR

## Usage

TODO: Document the different operations

## TODO:
* add documentation
* add unit tests
* support multiple build directories
