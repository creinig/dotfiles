# Collection of dotfiles for my personal use

# Installation

```
# Readonly (pull via https only)
curl -Lks https://git.io/crdotfiles | /bin/bash

# Read/write (pull + push via ssh key)
curl -Lks https://git.io/crdotfiles | INSTALL_MODE=rw /bin/bash 
```

This fetches the [install script](.local/bin/df-install.sh) and executes it. 
The basic idea behind it is described in this atlassian 
[blog post](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).
The same install script can also perform an update (it autodetects what mode of 
operation is correct). For convenience, `.shellrc` defines an alias "cfgu", 
fetching the install/update script and running it. 


# What's included?

* A .zshrc with zplug and some custom stuff
* A .shellrc with custom stuff for both zsh and bash
* A .vimrc with vim-plug and some custom settings
* A .tmuxrc with some custom settings
* [termux](https://wiki.termux.com/wiki/Main_Page) settings
* A default git config (`.config/git/config`) with settings that can be overridden by the "normal" .gitconfig
* A script to install my favorite packages (`.local/bin/df-tools.sh`)
* An installer that can also upgrade existing installations (`.local/bin/df-install.sh`)
* Some devops-y tooling and configuration (`devops/*`)
  * A Vagrantfile for a set of different VMs, for quick testing of stuff in various environments

## A note on QA

I test these scripts by using them almost daily, and since they are only intended
for my personal use I don't worry about doing explicit QA.

The environments I regularly use them on are:

* native ubuntu 22.04
* termux (android)
* MacOS

# Want more?

* https://dotfiles.github.io/ has a large collection of dotfile repos
* https://github.com/tony/.dot-config got me started with this idea
* https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/ has a cool idea on how to integrate the versioned dotfiles into your home dir (used by the `df-install.sh` in here)

See also [creinig/technotes](https://github.com/creinig/technotes/)
for documentation, tips and more.


