# Builddir

**builddir** is a little helper tool for C/C++ programmers to manage
out-of-source build directories. It manages mappings between build directories
and the associated source directories and allows to switch between them.

The provided configure and cmake wrappers additionally ease the configuration
by automatically specifying the path to the source directory.

## Installation

Installation consists out of multiple steps. The first is to install the
builddir gem:

    gem install builddir

Second, a shell wrapper script (`builddir_source_script`) has to be placed in
the PATH. The script can either be installed by hand (from `lib/builddir/data`)
or can be generated using the `builddir_generate_source_script` command.

    builddir_generate_source_script ~/bin/builddir_source_script

Third, to make builddir intuitively usable it is recommended to define the
following bash aliases.

    alias builddir='source builddir_source_script'
    alias bdir='builddir'
    alias cds='builddir -s'
    alias cdb='builddir -cb'
    alias cmake='builddir_cmake'
    alias configure='builddir_configure'

Fourth, define the build directory root by exporting the `DEFAULT_BUILDDIR`
environment variable. When `DEFAULT_BUILDDIR` is not defined then
`/tmp/builddir` is used as default.

    export DEFAULT_BUILDDIR="<path to the builddir>"

It is highly recommended to add the alias definitions and the environment
variable definition to the configuration file
(`~/.bashrc`, `~/.zshrc.local`, ...) of the used shell to make them permanent. 

## Usage

The following sections describe the most common operations briefly assuming
that the recommended aliases have been configured.

### Change to the build directory

`cdb [baseName]` looks up the current directory as source directory and changes
to the associated build directory. If no mapping could be found then a new one
is created considering the optional basename.

### Change to the source directory

`cds` looks up the current directory as build directory and changes to the
associated source directory. An error is returned if no mapping could be found.

### Configuring inside of the build directory

The configuration of an out-of-source build requires the path to the source
directory. Wrapper scripts for the most common build systems are provided
which automatically specify this path when needed. It is therefore possible
to simply call `configure [options]` or `cmake [options]` in the build
directory without any source path.

### Further operations (deleting, purging, ...)

The `bdir` command supports further operations like the deletion of mappings or
the purging of the build directory root from abandoned directories. The flags
for these and other operations can be found in the help of the command.
(`bdir --help`)

## TODO:
* add unit tests
* support multiple build directories?
