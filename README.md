# Collection of dotfiles for my personal use

***Note: This repository is hosted on [codeberg](https://codeberg.org/creinig/dotfiles) 
and mirrored on [github](https://github.com/creinig/dotfiles). The state on github
typically lags behind codeberg.***

This repo contains my core dotfiles that I really want to have on each system I 
regularly use. So as long as git is installed I can get (most of) my familiar 
environment with a single command (see the "Installation" section for details).

The dotfiles aim to be tolerant of different environments and the user experience
should gracefully degrade if some of my favourite tools are not installed on the
system. For example, most aliases work both in zsh (preferred) and bash (always 
available) and I try to be defensive about special commands, letting my aliases 
fall back to a more standard command if the preferred one is not installed. 

# Installation

Readonly (pull via https only)
```bash
curl -Lks https://tinyurl.com/crdotfiles | /bin/bash
```

Read/write (pull + push via ssh key)
```bash
curl -Lks https://tinyurl.com/crdotfiles | INSTALL_MODE=rw /bin/bash 
```

This fetches the [install script](.local/bin/df-install.sh) and executes it. 

Or, to be more safety conscious: download the [install script](.local/bin/df-install.sh),
review it and then run it.

The basic idea behind it is described in this atlassian 
[blog post](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/).
The same install script can also perform an update (it autodetects what mode of 
operation is correct). For convenience, `.shellrc` defines an alias "cfgu", 
fetching the install/update script and running it. 

In most cases a simple `git pull` is sufficient for updating this (and faster than
running the install script), but the script also takes care of installing / updating
plugins, handling (infrequent) structural changes etc.


# What's included?

* A .zshrc with a zinit-based plugin selection and some custom settings
  - Things that only make sense on the current machine can be added in `~/.zsh/local/*.zsh`
* A .shellrc with aliases, functions and environment for both zsh and bash
* Configuration for [neovim](.config/nvim) (preferred) and [vim](.vimrc) (fallback)
* A .tmuxrc with some custom settings
* Settings for [termux](https://wiki.termux.com/wiki/Main_Page), `bc`, `kitty`, `ugrep`, `yazi`, `psql` and a few others
* A [default git config](.config/git/config) with settings that can be overridden by the "normal" `.gitconfig`
* An [installer](.local/bin/df-install.sh) that can also upgrade existing installations 
* (outdated) A script to install my favorite packages (`.local/bin/df-tools.sh`)

## A note on QA

I test these scripts by using them almost daily, and since they are only intended
for my personal use I don't worry about doing explicit QA.

The environments I regularly use them on are:

* Arch Linux
* termux (android)
* MacOS
* Amazon Linux & Ubuntu on a few servers
* Ubuntu in WSL2

# Want more?

* https://dotfiles.github.io/ has a large collection of dotfile repos
* https://github.com/tony/.dot-config got me started with this idea
* https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/ has a cool idea on how to integrate the versioned dotfiles into your home dir (used by the `df-install.sh` in here)

See also [creinig/technotes](https://github.com/creinig/technotes/)
for documentation, tips and more.


