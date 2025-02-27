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


prependToPath() {
    (echo "$PATH" | grep -q -F "$1") || export PATH="$1:$PATH"
}

appendToPath() {
    (echo "$PATH" | grep -q -F "$1") || export PATH="$PATH:$1"
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
