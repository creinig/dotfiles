#!/usr/bin/env bash

. $HOME/.local/bin/.df-common.sh

function usage() {
	echo "Usage: df-tools.sh <bundle>"
	echo "  Installs the specified bundle of packages / tools"
	echo 
	echo "Supported bundles:"
	echo "  * basics : quite some standard system utilties"
	echo "  * cloud  : cloud dev tools (kubectl, az cli, ...)"

	exit 1
}


function install_basics() {
	PKG="     curl ntp"                         # Basic system stuff
	PKG="$PKG vim tmux git zsh unzip multitail" # basic convenience tools
	PKG="$PKG most bc pinfo tree mosh httpie"
	PKG="$PKG dstat sysstat htop atop iftop"    # System Info
	PKG="$PKG pigz lbzip2 parallel"             # parallel processing

	if [[ $DF_OS == 'termux' ]] ; then
		pkg install \
			mosh nodejs zsh vim-python multitail \
			tree bat ripgrep
	elif [[ $DF_OS == 'rhel' ]] ; then
		sudo yum install epel-release bind-utils
		sudo yum install $PKG
	elif [[ $DF_OS == 'ubuntu' ]] ; then
		sudo apt install $PKG \
			dnsutils

		if apt-cache search '^ripgrep$' >/dev/null ; then
			sudo apt install ripgrep
		else
			curl -L https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb >/tmp/ripgrep.deb
			sudo dpkg --install /tmp/ripgrep.deb
		fi

		if apt-cache search '^bat$' >/dev/null ; then
			sudo apt install bat
		else
			curl -L https://github.com/sharkdp/bat/releases/download/v0.12.1/bat_0.12.1_amd64.deb >/tmp/bat.deb
			sudo dpkg --install /tmp/bat.deb
		fi
	else
		echo "OS '$DF_OS' not supported"
	fi
}


function install_cloud() {
	if [[ §DF_OS == 'termux' ]] ; then
		echo "Not implemented yet"
		exit 1
	fi

	curl -L https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubect > ~/.local/bin/kubectl
	curl -L https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx >~/.local/bin/kubectx
	curl -L https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens >~/.local/bin/kubens

	curl -L https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip >/tmp/terraform.zip
	unzip -p /tmp/terraform.zip terraform >~/.local/bin/terraform

	(cd ~/.local/bin && chmod u+x kubectl kubectx kubens terraform)

	curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
}


case $1 in
	basics)
		install_basics
		;;
	cloud)
		install_cloud
		;;
	*)
		usage
		;;
esac


