#!/bin/sh
#
# Wrapper around the bat invocation for mandoc
# (which is the man implementation used in termux).
# See https://github.com/sharkdp/bat/issues/1145
#
if [ "x$1" = "x" ] ; then
  col -bx | bat --language man --style plain
else
  cat "$1" | col -bx | bat --language man --style plain
fi

