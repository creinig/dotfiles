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
  * (X) https://www.terraform.io/
  * https://www.ansible.com/
  * (X) https://kubernetes.io/docs/tasks/tools/install-kubectl/
  * (X) https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest
  * https://github.com/cbucher/console
    * Cfg: unbind ctrl-R, ctrl-W; Fix size (view -> show console -> settigns -> set font size to tiny)
  * (X) https://github.com/BurntSushi/ripgrep (and configure as finder for fzf)
  * https://github.com/honza/vim-snippets and https://github.com/SirVer/ultisnips ?
* Better environment detection (linux vs WSL vs cygwin)
* Personal documentation / notes and links to good doc resources
  * https://www.youtube.com/watch?v=qgG5Jhi_Els

# Resources

## bash

* [BashGuide](http://mywiki.wooledge.org/BashGuide) : good guide aimed at beginners. I found the [Practices](http://mywiki.wooledge.org/BashGuide/Practices) chapter especially useful
* [Bash Scripting Cheatsheet](https://devhints.io/bash) : concise overview of all (or most) constructs
* [Adanced Bash-Scriptig Guide](http://www.tldp.org/LDP/abs/html/) : all the details
* [Bash Error Handling](https://linuxhint.com/bash_error_handling/)

## vim

* [A Byte of Vim](https://vim.swaroopch.com/) : good introduction to vim
* [Vim Tips Wiki](https://vim.fandom.com/wiki/Vim_Tips_Wiki)
* [VimCasts](http://vimcasts.org/) : screencasts about vim. also check out the author's book "Practical vim"!
* [Vim Awesome](https://vimawesome.com/) : awesome vim plugins

## tmux

* [The Tao of tmux](https://leanpub.com/the-tao-of-tmux/read) : basically everythig you need to know about tmux
* tmux cheat sheets: [one](https://gist.github.com/MohamedAlaa/2961058), [two](http://atkinsam.com/documents/tmux.pdf), [three](https://www.cheatography.com/thecultofkaos/cheat-sheets/tmux-basics/)

## Other Tools

* [Sed - An Introduction and Tutorial](http://www.grymoire.com/Unix/Sed.html)
* [bat](https://github.com/sharkdp/bat) : a better replacement for cat(1)
* [fzf](https://github.com/junegunn/fzf) : fuzzy finder with great integration into bash/zsh and vim

TODO: most, pinfo, multitail, zsh, tmuxp, storm
