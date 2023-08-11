#!/usr/bin/env bash

. $HOME/.local/bin/.df-common.sh

if [[ -t 0 ]] ; then
	echo "Terminal detected - apt will ask for confirmation"
	APT_OPTS=""
else
	echo "No terminal detected - apt will automatically install everything"
	APT_OPTS="-y"
fi

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
	PKG="$PKG bc tree mosh ncdu"
	PKG="$PKG dstat sysstat htop atop iftop"    # System Info
	PKG="$PKG pigz lbzip2 parallel"             # parallel processing
	PKG="$PKG zstd httpie hexedit"              # other

	if [[ $DF_OS == 'termux' ]] ; then
		pkg install \
			mosh nodejs zsh vim-python multitail \
			bat ripgrep man perl exa ncurses-utils \
			zstd
		# perl is needed for the enhancd zsh plugin
	elif [[ $DF_OS == 'ubuntu' ]] ; then
		sudo apt update
		sudo apt $APT_OPTS install $PKG \
			dnsutils shellcheck

		if apt-cache search '^ripgrep$' | grep -q ripgrep ; then
			sudo apt $APT_OPTS install ripgrep
		else
			curl -L https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb >/tmp/ripgrep.deb && sudo dpkg --install /tmp/ripgrep.deb
		fi

		if apt-cache search '^bat$'  | grep -q bat ; then
			sudo apt $APT_OPTS install bat
		else
			curl -L https://github.com/sharkdp/bat/releases/download/v0.23.0/bat_0.23.0_amd64.deb >/tmp/bat.deb && sudo dpkg --install /tmp/bat.deb
		fi

		curl -L https://github.com/dandavison/delta/releases/download/0.16.5/git-delta_0.16.5_amd64.deb >/tmp/delta.deb && sudo dpkg --install /tmp/delta.deb
	else
		echo "OS '$DF_OS' not supported"
	fi
}


function install_cloud() {
	if [[ $DF_OS == 'termux' ]] ; then
		echo "Not implemented yet"
		exit 1
	fi

	curl -L https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl > ~/.local/bin/kubectl
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


