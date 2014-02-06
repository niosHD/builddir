# builddir #

**builddir** is a little helper tool for C/C++ programmers to manage out-of-source build directories. 

### Bash Aliases
    alias builddir='source builddir_script'
    alias cds='builddir -s'
    alias cdb='builddir -cb'
    alias cmake='source cmake_script'

### TODO: ###
* add documentation
* add unit tests
* add remove option (break connection between src and build directory)
* add delete option (remove + deletion of build directory)
* add purge option (delete all unreferenced build directories)
* support multiple build directories