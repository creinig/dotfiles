#!/bin/sh
#
# Wrapper around the bat invocation for mandoc
# (which is the man implementation used in termux).
# See https://github.com/sharkdp/bat/issues/1145
#
cat "$1" | col -bx | bat --language man --style plain

