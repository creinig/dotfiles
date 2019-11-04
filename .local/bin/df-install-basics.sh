#!/usr/bin/env bash

. $HOME/.local/bin/.df-common.sh

PKG="     curl ntp"   i                     # Basic system stuff
PKG="$PKG vim tmux git zsh unzip multitail" # basic convenience tools
PKG="$PKG most bc pinfo tree mosh httpie mosh"
PKG="$PKG dstat sysstat htop atop iftop"    # System Info
PKG="$PKG pigz lbzip2 parallel"             # parallel processing

if [[ $DF_OS == 'termux' ]] ; then
	pkg install mosh nodejs zsh vim multitail
elif [[ $DF_OS == 'rhel' ]] ; then
	sudo yum install epel-release bind-utils
	sudo yum install $PKG
elif [[ $DF_OS == 'ubuntu' ]] ; then
	sudo apt install $PKG \
		dnsutils
else
	echo "OS '$DF_OS' not supported"
fi

