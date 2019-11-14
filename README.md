# Collection of dotfiles for my personal use

# Installation

```
# Readonly (pull via https only)
curl -Lks https://git.io/crdotfiles | /bin/bash

# Read/write (pull + push via ssh key)
curl -Lks https://git.io/crdotfiles | INSTALL_MODE=rw /bin/bash 
```

# What's included?

* A .zshrc with oh-my-zsh and some custom stuff
* A .shellrc with custom stuff for both zsh and bash
* A .vimrc with Vundle and some custom stuff
* A .tmuxrc with some custom settings
* [termux](https://wiki.termux.com/wiki/Main_Page) settings
* A default git config (`.config/git/config`) with settings that can be overridden by the "normal" .gitconfig
* A script to install my favorite packages (`.local/bin/df-install-basics.sh`)
* An installer that can also upgrade existing installations (`.local/bin/df-install.sh`)

# Want more?

* https://dotfiles.github.io/ has a large collection of dotfile repos
* https://github.com/tony/.dot-config started me with this idea
* https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/ has a cool idea on how to integrate the versioned dotfiles into your home dir (used by the `install-dotfiles.sh` in here)

# TODO



