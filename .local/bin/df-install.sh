#!/usr/bin/env bash

# "r" => no git push commit capabilities, but doesn't need registered SSH key to install
# "rw" => clone via SSH (full push capabilities)
if [[ -z $INSTALL_MODE ]] ; then
  INSTALL_MODE=r
fi

# Collection of hints to be displayed at the end
declare HINTS=()

DF_CHANGED=false

if [[ -t 1 ]]; then
  LOG_START='\e[1m'
  LOG_INFO='\e[33m'
  LOG_OK='\e[32m'
  LOG_DO='\e[96m'
  LOG_ERR='\e[31m'
  LOG_END='\e[0m'
fi

function log() {
  printf "${LOG_START}${LOG_INFO}== "
  echo -n "$@"
  printf "${LOG_END}\n"
}

function logOk() {
  printf "${LOG_START}${LOG_OK}=/ "
  echo -n "$@"
  printf "${LOG_END}\n"
}

function logDo() {
  printf "${LOG_START}${LOG_DO}=> "
  echo -n "$@"
  printf "${LOG_END}\n"
}

function logError() {
  printf "${LOG_START}${LOG_ERR}!! "
  echo -n "$@"
  printf "${LOG_END}\n"
}

if command -v git &>/dev/null ; then
  logOk "git installed. that's good."
else
  logError "git not found"
  exit 1
fi


if [[ $INSTALL_MODE == "rw" ]] ; then
  GIT_REPO="git@github.com:creinig/dotfiles.git"
else
  GIT_REPO="https://github.com/creinig/dotfiles.git"
fi


cd "$HOME" || exit

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
    logError "Dir '.dotfiles-backup' already exists. Please move it away and try again"
    exit 1
  fi
fi

function config() {
  /usr/bin/git "--git-dir=$HOME/.dotfiles/" --work-tree="$HOME" "$@"
}

#
# Function: Install the dotfiles repo in the current home dir.
# Copied & adapted from https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/
#
function install() {
  git clone --bare "$GIT_REPO" .dotfiles || exit 1

  git config --global core.eol lf
  git config --global core.autocrlf input

  mkdir -p .dotfiles-backup
  config checkout
  if [[ $? = 0 ]]; then
    logDo "Checked out dotfiles."
  else
    logDo "Backing up pre-existing dot files."
    config checkout 2>&1 | grep -E "\s+\." | awk '{ print $1 }' | xargs -I{} mv {} .dotfiles-backup/{}
  fi
  config checkout
  config config status.showUntrackedFiles no
}


#
# (1) Install or update
#
if $DO_UPDATE ; then
  last_commit=$(config log -n 1 --format=oneline)
  log "Updating the installation"
  config pull || exit 1
  if [[ "$last_commit" != $(config log -n 1 --format=oneline) ]] ; then
    DF_CHANGED=true
  fi
else
  log "Performing fresh install"
  install
  DF_CHANGED=true
fi

#
# (2) Detect existing oh-my-zsh and warn that it's not used anymore
#
echo
if [[ -d ~/.oh-my-zsh ]] ; then
  HINTS+=("~/.oh-my-zsh exists. Since it's not used anymore you might want to remove it")
fi


#
# (3) install vim plugins
#
echo
if [[ -t 0 ]] ; then
  logDo 'Installing missing vim plugins'
  vim +PlugInstall +PlugUpdate +qall
else
  logDo 'Input is not a tty - installing missing vim plugins in the background.'
  logDo 'This may take a few minutes'
  # credits: unhashable on https://github.com/VundleVim/Vundle.vim/issues/511
  echo | vim +PlugInstall! +PlugUpdate! +qall &>/dev/null
fi

#
# (3.1) install tmux plugins
#
if command -v tmux >/dev/null && [[ -f ~/.tmux/plugins/tpm/bin/install_plugins ]] ; then
  echo
  logDo 'Installing missing tmux plugins'
  ~/.tmux/plugins/tpm/bin/install_plugins && \
    ~/.tmux/plugins/tpm/bin/update_plugins all
  tmux source-file ~/.tmux.conf
fi

#
# (3.2) install neovim plugins
#
if command -v nvim >/dev/null 2>&1 ; then
  echo
  logDo 'Installing missing neovim plugins'
  nvim --headless "+Lazy! sync" +qall
fi

#
# (4) source .shellrc in .bashrc if not done already
#
echo
if [[ -f ~/.bashrc ]] ; then
  if grep -q '\.shellrc' ~/.bashrc ; then
    logOk ".bashrc already sources .shellrc"
  else
    echo >> ~/.bashrc
    echo ". ~/.shellrc" >> ~/.bashrc
    echo >> ~/.bashrc
    logDo ".bashrc now sources .shellrc"
  fi
else
  logOk "no .bashrc present -- skipping sourcing of .shellrc"
fi

#
# (5) Make zsh the default shell
#
echo
if ! command -v zsh >/dev/null ; then
  logOk "zsh is not installed"
  HINTS+=('Without zsh you will miss out quite a bit. "df-tools.sh basics" will install it')
elif [[ ${SHELL##*/} != 'zsh' ]] && command -v zsh >/dev/null ; then
  logDo 'zsh is installed, but not the login shell'
  if [[ -f /etc/shells ]] ; then
    zshfqn=$(grep zsh /etc/shells | head -n 1)
    if [[ -t 0 ]] ; then
      chsh -s "$zshfqn"
      logDo '... fixed that'
      HINTS+=("Your login shell has been changed. You'll want to re-login to use it")
    else
      HINTS+=("To make zsh your login shell, run: chsh -s $zshfqn")
    fi
  elif [[ $PREFIX =~ 'termux' ]] ; then
    chsh -s zsh
    logDo '... fixed that'
    HINTS+=("Your login shell has been changed. You'll want to re-login to use it")
  else
    logError '  strange system here. perhaps try running "chsh" manually'
  fi
else
  logOk 'zsh is already your login shell'
fi


#
# (6) Install fzf (fuzzy finder)
#
echo
if [[ ! -d ~/.fzf ]] ; then
  logDo 'installing fzf'
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --key-bindings --completion --no-update-rc --no-fish
elif [[ ! -f ~/.fzf.zsh ]] && command -v zsh >/dev/null ; then
  logDo '.fzf.zsh missing - re-running installer'
  ~/.fzf/install --key-bindings --completion --no-update-rc --no-fish
else
  logDo 'upgrading fzf'
  cd ~/.fzf && git pull --quiet --stat && cd
  ~/.fzf/install --key-bindings --completion --no-update-rc --no-fish
fi


#
# (7) Clone / update oh-my-zsh to work around https://github.com/zdharma-continuum/zinit/discussions/651
#
echo
OMZ_DIR="${HOME}/.zsh/ohmyzsh"
if [[ ! -d "$OMZ_DIR" ]] ; then
  logDo 'cloning oh-my-zsh'
  git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$OMZ_DIR"
else
  logDo 'updating oh-my-zsh'
  (cd "$OMZ_DIR" && git pull)
fi

#
# (8) Ensure this acts as "normal" git repo
#
[[ ! -d ~/.git ]] && ln -s ~/.dotfiles ~/.git
(cd ~ && git config core.bare false)
(cd ~ && git config remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*')

#
# (9) Set up yazi packages
#
echo
if command -v yazi >/dev/null 2>&1 ; then
  logDo 'installig yazi packages'
  ya pkg install
else
  logOk 'yazi is not installed -- skipping setup'
  HINTS+=("yazi is not installed. No problem, but it's a cool tool")
fi

#
# (x) Final things
#
if [[ $DF_CHANGED == true ]] ; then
  HINTS+=('Your dotfiles have changed. Either re-login or "source ~/.zshrc" to apply them.')
fi

if [[ -e $(config config user.email) ]] && config remote -v | grep -q 'git@' ; then
  HINTS+=('git: user.email is not set. You might want to run "cfg config --local user.email my@mail.org"')
fi

if ! command -v nvim &>/dev/null ; then
  HINTS+=("neovim is not installed. The vim config you'll use instead may be outdated")
fi

if ! command -v which &>/dev/null ; then
  HINTS+=("'which' is not installed. forgit may crash without it")
fi

if (( ${#HINTS[@]} > 0 )); then
  echo
  log 'Some issues you might want to take care of:'
  for hint in "${HINTS[@]}" ; do
    log '*' "$hint"
  done
fi