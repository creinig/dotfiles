# Collection of dotfiles for my personal use

# Installation

```
# Readonly (pull via https only)
curl -Lks https://raw.githubusercontent.com/creinig/dotfiles/master/install-dotfiles.sh | /bin/bash

# Read/write (pull + push via ssh key)
curl -Lks https://raw.githubusercontent.com/creinig/dotfiles/master/install-dotfiles.sh | INSTALL_MODE=rw /bin/bash 
```


# Want more?

* https://dotfiles.github.io/ has a large collection of dotfile repos
* https://github.com/tony/.dot-config started me with this idea
* https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/ has a cool idea on how to integrate the versioned dotfiles into your home dir (used by the `install-dotfiles.sh` in here)

# TODO

* Improve installation script
  * Better checks for files that are already present
    * Properly save really all files that would be overwritten?

# Yum packages I like to have installed everywhere:

* yum install bind-utils curl epel-release              # Basic system stuff
* yum install vim tmux git zsh unzip multitail bc pinfo # basic convenience tools
* yum install dstat sysstat htop atop                   # System Info
* yum install pigz lbzip2 parallel                      # parallel processing

