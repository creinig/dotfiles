#!/bin/sh
#
# Wrapper to ensure that the bat invocation also works with mandoc
# (which ist the man implementation used in termux).
# See https://github.com/sharkdp/bat/issues/1145
#
cat "$1" | col -bx | bat --language man --style plain

