#!/bin/bash

#
# (1) Install the dotfiles repo in the current home dir.
# Copied & adapted from https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/ 
#
git clone --bare git@github.com:creinig/dotfiles.git $HOME/.dotfiles

function config {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}


git config --global core.eol lf
git config --global core.autocrlf input
mkdir -p .dotfiles-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no

#
# (2) If possible, switch to zsh and install oh-my-zsh
#
if command -v zsh > /dev/null 2>&1; then
#  git config --global core.eol lf
#  git config --global core.autocrlf input
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  #chsh -s $(which zsh)
fi
