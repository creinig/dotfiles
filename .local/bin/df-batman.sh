#!/bin/sh
cat "$1" | col -bx | bat --language man --style plain

