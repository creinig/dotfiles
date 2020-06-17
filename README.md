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

* WSL 1 with ubuntu 19 (tip: [MobaXTerm](https://mobaxterm.mobatek.net/) works great for this)
* native ubuntu 18
* native CentOS 7
* termux (android)


# Want more?

* https://dotfiles.github.io/ has a large collection of dotfile repos
* https://github.com/tony/.dot-config got me started with this idea
* https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/ has a cool idea on how to integrate the versioned dotfiles into your home dir (used by the `df-install.sh` in here)

# Resources

## bash

* [BashGuide](http://mywiki.wooledge.org/BashGuide) : good guide aimed at beginners. I found the [Practices](http://mywiki.wooledge.org/BashGuide/Practices) chapter especially useful
* [Bash Scripting Cheatsheet](https://devhints.io/bash) : concise overview of all (or most) constructs
* [Adanced Bash-Scriptig Guide](http://www.tldp.org/LDP/abs/html/) : all the details
* [Bash Error Handling](https://linuxhint.com/bash_error_handling/)

## vim

(vim is installed by `df-tools.sh basics`)

* [A Byte of Vim](https://vim.swaroopch.com/) : good introduction to vim
* [Vim Galore](https://github.com/mhinz/vim-galore#readme) : concise but complete and well-written overview
* [Vim Tips Wiki](https://vim.fandom.com/wiki/Vim_Tips_Wiki)
* [VimCasts](http://vimcasts.org/) : screencasts about vim. also check out the author's book "[Practical vim](https://pragprog.com/book/dnvim2/practical-vim-second-edition)"!
* [Vim Awesome](https://vimawesome.com/) : awesome vim plugins
* [Learn Vimscript the Hard Way](https://learnvimscriptthehardway.stevelosh.com/) : how to extend and customize vim

## tmux

(tmux is installed by `df-tools.sh basics`)

* [The Tao of tmux](https://leanpub.com/the-tao-of-tmux/read) : basically everythig you need to know about tmux
* tmux cheat sheets: [one](https://gist.github.com/MohamedAlaa/2961058), [two](http://atkinsam.com/documents/tmux.pdf), [three](https://www.cheatography.com/thecultofkaos/cheat-sheets/tmux-basics/)

## Other Tools

### General

* [Sed - An Introduction and Tutorial](http://www.grymoire.com/Unix/Sed.html)

### Installed by `df-tools.sh basics`

* [bat](https://github.com/sharkdp/bat) : a better replacement for cat(1)
* [most](https://linux.die.net/man/1/most) : a better replacement for less(1)
* [pinfo](https://linux.die.net/man/1/pinfo) : a better replacement for both info(1) and man(1)
* [multitail](https://www.vanheusden.com/multitail/) : a much better replacement for tail(1)
* [zsh](https://en.m.wikipedia.org/wiki/Z_shell) : my shell of choice

### Installed by `df-install.sh`

* [fzf](https://github.com/junegunn/fzf) : fuzzy finder with great integration into bash/zsh and vim
  * [video intro](https://www.youtube.com/watch?v=qgG5Jhi_Els) giving a great overview of fzf's capabilities


# TODO

* Add ansible bootstrapping to vagrant stuff
* Better environment detection (linux vs WSL)


