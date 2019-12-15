#!/usr/bin/env bash

# "r" => no git push commit capabilities, but doesn't need registered SSH key to install
# "rw" => clone via SSH (full push capabilities)
if [[ -z $INSTALL_MODE ]] ; then
  INSTALL_MODE=r
fi

function log() {
  echo -n '== '
  echo $@
}

if command -v git &>/dev/null ; then
  log "git installed. that's good."
else 
  log "git not found"
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
    log "Dir '.dotfiles-backup' already exists. Please move it away and try again"
    exit -1
  fi
fi

function config() {
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

#
# Function: Install the dotfiles repo in the current home dir.
# Copied & adapted from https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/ 
#
function install() {
  git clone --bare "$GIT_REPO" .dotfiles

  git config --global core.eol lf
  git config --global core.autocrlf input

  mkdir -p .dotfiles-backup
  config checkout
  if [[ $? = 0 ]]; then
    log "Checked out dotfiles.";
    else
      log "Backing up pre-existing dot files.";
      config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
  fi;
  config checkout
  config config status.showUntrackedFiles no
}


#
# (1) Install or update
#
if $DO_UPDATE ; then
  log "Updating the installation"
  config pull
else
  log "Performing fresh install"
  install
fi

#
# (2) install oh-my-zsh, since I want to use zsh if in any way possible
#
if [[ ! -d .oh-my-zsh ]] ; then
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
else
  log "oh-my-zsh is already installed. Updating."
  (cd ~/.oh-my-zsh ; git pull)
fi

#
# (3) install Vundle if it's not installed yet
#
if [[ ! -d ~/.vim/bundle/Vundle.vim ]] ; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  vim -c ":BundleInstall" -c ':qall!'
else
  log "Vundle is already installed. Updating Plugins"
  vim -c ":BundleInstall" -c ':qall!'
fi

#
# (4) source .shellrc in .bashrc if not done already
if [[ -f .bashrc ]] ; then
  if grep -q '\.shellrc' .bashrc ; then
    log ".bashrc already sources .shellrc"
  else
    echo >> .bashrc
    echo ". ~/.shellrc" >> .bashrc
    echo >> .bashrc
    log ".bashrc now sources .shellrc"
  fi
else
  log "no .bashrc present -- skipping sourcing of .shellrc"
fi

#
# (5) Make zsh the default shell
#
if [[ ${SHELL##*/} != 'zsh' ]] && command -v zsh >/dev/null ; then
  log 'zsh is installed, but not the login shell'
  if [[ -f /etc/shells ]] ; then
    chsh -s $(grep zsh /etc/shells)
    log '... fixed that'
  elif [[ $PREFIX =~ 'termux' ]] ; then
    chsh -s zsh
    log '... fixed that'
  else
    log '  strange system here. perhaps try running "chsh" manually'
  fi
else
  log 'zsh is already your login shell'
fi


#
# (6) Install fzf (fuzzy finder)
#
if [[ ! -d ~/.fzf ]] ; then
  log 'installing fzf'
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --key-bindings --completions --no-update-rc --no-fish 
else
  log 'fzf is already installed'
fi
