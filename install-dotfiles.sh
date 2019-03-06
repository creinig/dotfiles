#!/bin/bash

# "r" => no git commit capabilities, but doesn't need registered SSH key to install
if [[ -z $INSTALL_MODE ]] ; then
  INSTALL_MODE=rw
fi

if command -v git > /dev/null 2>&1; then
  echo "git installed. that's good."
else 
  echo "git not found"
  exit -1
fi

SCRIPTNAME=$( basename $0 )
if [[ $SCRIPTNAME == 'install-dotfiles.sh' ]]  ; then
  echo "Please rename this script to something other than install-dotfiles.sh"
  exit -1
fi

if [[ $INSTALL_MODE == "rw" ]] ; then
  GIT_REPO="git@github.com:creinig/dotfiles.git"
else
  GIT_REPO="https://github.com/creinig/dotfiles.git"
fi


cd "$HOME"

#
# (0) Safety checks
#

for dir in .dotfiles-backup .dotfiles .oh-my-zsh ;  do
  if [[ -d "$dir" ]] ; then
    echo "Dir '$dir' already exists. Please move it away and try again"
    exit -1
  fi
done


#
# (1) Install the dotfiles repo in the current home dir.
# Copied & adapted from https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/ 
#
git clone --bare "$GIT_REPO" .dotfiles

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
# (2) install oh-my-zsh, since I want to use zsh if in any way possible
#
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
