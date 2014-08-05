# Builddir

**builddir** is a little helper tool for C/C++ programmers to manage
out-of-source build directories. It manages mappings between build directories
and the associated source directories and allows to switch between them.

## Installation

Installation consists out of multiple steps. The first is to install the
builddir gem:

    gem install builddir

Second, a shell wrapper script (`builddir_source_script`) has to be placed in
the PATH. The script can either be installed by hand (from `lib/data`) or can
be generated using the `builddir_generate_source_script` command.

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

TODO: Document the different operations

## TODO:
* add documentation
* add unit tests
* support multiple build directories?
