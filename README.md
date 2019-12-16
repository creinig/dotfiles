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
* Some devops-y tooling and configuration (`devops/*`)
  * A Vagrantfile for a set of different VMs, for quick testing of stuff in various environments

# Want more?

* https://dotfiles.github.io/ has a large collection of dotfile repos
* https://github.com/tony/.dot-config started me with this idea
* https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/ has a cool idea on how to integrate the versioned dotfiles into your home dir (used by the `df-install.sh` in here)

# TODO

* Add ansible bootstrapping to vagrant stuff
* Add installers and/or install+config docs for useful extra tooling
  * https://github.com/tmux-python/tmuxp
  * https://github.com/emre/storm
  * https://kubernetes.io/docs/tasks/tools/install-minikube/
  * https://www.vagrantup.com/
  * https://www.terraform.io/
  * https://www.ansible.com/
  * https://kubernetes.io/docs/tasks/tools/install-kubectl/
  * https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest
  * https://github.com/cbucher/console
    * Cfg: unbind ctrl-R, ctrl-W; Fix size (view -> show console -> settigns -> set font size to tiny)
  * https://github.com/BurntSushi/ripgrep (and configure as finder for fzf)
  * https://github.com/honza/vim-snippets and https://github.com/SirVer/ultisnips ?
* Better environment detection (linux vs WSL vs cygwin)
* Personal documentation / notes and links to good doc resources
  * https://www.youtube.com/watch?v=qgG5Jhi_Els
