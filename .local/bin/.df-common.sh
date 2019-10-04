#!/bin/bash

if [[ $PREFIX =~ termux ]] ; then
	DF_OS=termux
elif grep -q rhel /etc/os-release 2>/dev/null ; then
	DF_OS=rhel
elif grep -q ubuntu /etc/lsb-release 2>/dev/null ; then
	DF_OS=ubuntu
else
	DF_OS=unknown
fi


