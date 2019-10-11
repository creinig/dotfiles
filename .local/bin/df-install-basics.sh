#!/bin/bash

. $HOME/.local/bin/.df-common.sh


if [[ $DF_OS == 'termux' ]] ; then
	pkg install mosh nodejs zsh vim multitail
elif [[ $DF_OS == 'rhel' ]] ; then
	sudo yum install \
		bind-utils curl epel-release ntp # Basic system stuff \
        vim tmux git zsh unzip multitail # basic convenience tools \
		most bc pinfo tree mosh \
		dstat sysstat htop atop iftop    # System Info \
		pigz lbzip2 parallel             # parallel processing
elif [[ $DF_OS == 'ubuntu' ]] ; then
	sudo apt install \
		bind-utils curl epel-release ntp # Basic system stuff \
		dnsutils \
        vim tmux git zsh unzip multitail # basic convenience tools \
		most bc pinfo tree  mosh \
		dstat sysstat htop atop iftop    # System Info \
		pigz lbzip2 parallel             # parallel processing
else
	echo "OS '$DS_OS' not supported"
fi

