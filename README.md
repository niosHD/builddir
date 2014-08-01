# builddir #

**builddir** is a little helper tool for C/C++ programmers to manage out-of-source build directories. 

### Installation
* Install dependencies using bundle (`bundle install`)
* Symlink the scripts or add the directory to the PATH
* Define the build directory root by exporting the DEFAULT_BUILD_DIR

### Bash Aliases
    alias bdir='source builddir_script'
    alias cds='bdir -s'
    alias cdb='bdir -cb'
    alias cmake='builddir_cmake'
    alias configure='builddir_configure'


### TODO: ###
* add documentation
* add unit tests
* support multiple build directories
