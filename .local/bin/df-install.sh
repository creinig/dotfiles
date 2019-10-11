#!/bin/bash

# "r" => no git push commit capabilities, but doesn't need registered SSH key to install
# "rw" => clone via SSH (full push capabilities)
if [[ -z $INSTALL_MODE ]] ; then
  INSTALL_MODE=r
fi

if command -v git > /dev/null 2>&1; then
  echo "git installed. that's good."
else 
  echo "git not found"
  exit -1
fi

SCRIPTNAME=$( basename $0 )

if [[ $INSTALL_MODE == "rw" ]] ; then
  GIT_REPO="git@github.com:creinig/dotfiles.git"
else
  GIT_REPO="https://github.com/creinig/dotfiles.git"
fi


cd "$HOME"

# Mode of operation: update/fix or install
if [[ -d .dotfiles ]] ; then
  DO_UPDATE=true
else
  DO_UPDATE=false
fi

#
# (0) Safety checks
#


if ! $DO_UPDATE ; then
  if [[ -d ".dotfiles-backup" ]] ; then
    echo "Dir '.dotfiles-backup' already exists. Please move it away and try again"
    exit -1
  fi
fi

function config {
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

#
# Function: Install the dotfiles repo in the current home dir.
# Copied & adapted from https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/ 
#
function install {
  git clone --bare "$GIT_REPO" .dotfiles

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
}


#
# (1) Install or update
#
if $DO_UPDATE ; then
  echo "Updating the installation"
  config pull
else
  echo "Performing fresh install"
  install
fi

#
# (2) install oh-my-zsh, since I want to use zsh if in any way possible
#
if [[ ! -d .oh-my-zsh ]] ; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
else
  echo "oh-my-zsh is already installed"
fi

#
# (3) install Vundle if it's not installed yet
#
if [[ ! -d ~/.vim/bundle/Vundle.vim ]] ; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim -c ":BundleInstall" -c ':qall!'
else
  echo "Vundle is already installed"
fi

#
# (4) source .shellrc in .bashrc if not done already

if [ -f .bashrc ] ; then
  if grep -q '\.shellrc' .bashrc ; then
    echo ".bashrc already sources .shellrc"
  else
    echo >> .bashrc
    echo ". ~/.shellrc" >> .bashrc
    echo >> .bashrc
    echo ".bashrc now sources .shellrc"
  fi
else
  echo "no .bashrc present -- skipping sourcing of .shellrc"
fi
