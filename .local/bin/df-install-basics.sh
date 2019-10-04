#!/bin/bash

. $HOME/.local/bin/.df-common.sh


if [[ $DF_OS == 'termux' ]] ; then
	pkg install mosh nodejs zsh vim multitail
fi

