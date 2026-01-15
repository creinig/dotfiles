#!/bin/bash

if [[ $PREFIX =~ termux ]] ; then
    export DF_OS=termux
elif grep -q rhel /etc/os-release 2>/dev/null ; then
    export DF_OS=rhel
elif grep -q ubuntu /etc/os-release 2>/dev/null ; then
    export DF_OS=ubuntu
elif (uname -a | grep -qi darwin 2>/dev/null) ; then
    export DF_OS=osx
else
    export DF_OS=unknown
fi

# Ensure that the given path - if it exists - is sitting at the front of $PATH.
# If the given path is already in $PATH, it it moved to the front, otherwise it is
# prepended.
prependToPath() {
    if [[ -d "$1" ]] ; then
        PATH_WITHOUT=$(echo "$PATH" | sed -r -e "s#$1:?##")
        export PATH="$1:$PATH_WITHOUT"
    fi
}

# Ensure that the given path - if it exists - is sitting at the end of $PATH.
# If the given path is already in $PATH, it it moved to the end, otherwise it is
# appended.
appendToPath() {
    if [[ -d "$1" ]] ; then
        PATH_WITHOUT=$(echo "$PATH" | sed -r -e "s#$1:?##")
        export PATH="$PATH_WITHOUT:$1"
    fi
}

cmdExists() { 
    command -v "$1" >/dev/null 2>&1 ; 
}

firstCmdOf() {
    for cmd in "$@"; do
        if cmdExists "$cmd" ; then
            echo -n "$cmd"
            return
        fi
    done
}