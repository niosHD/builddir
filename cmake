#!/bin/bash

COMMAND="builddir_impl.rb"
OPTIONS=$@
APPEND_SRC_DIR=1

# check if the --build flag has been specified
while test $# -gt 0
do
  case "$1" in
    --build) APPEND_SRC_DIR=0
      ;;
  esac
  shift
done

# Script from:
# http://stackoverflow.com/questions/11027679/bash-store-stdout-and-stderr-in-different-variables
unset t_std t_err t_ret
eval "$( $COMMAND -s 2> >(t_err="$(cat)"; typeset -p t_err) > >(t_std="$(cat)"; typeset -p t_std); t_ret=$?; typeset -p t_ret )"

# print the stderr stream of the command
#echo "${t_err}"

# tell cmake the source directory if there is no error
if [ $t_ret -eq 0 ] && [ $APPEND_SRC_DIR -eq 1 ]; then
  /usr/bin/cmake $OPTIONS "${t_std}"
else
  /usr/bin/cmake $OPTIONS
fi

