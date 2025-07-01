export SHELL=$(which zsh)

# Plugins --------------------------

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# settings (env)
export PURE_GIT_PULL=0 # don't automatically fetch from remote - can be expensive on a mobile hotspot
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#505050"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSHZ_DATA=~/.zsh/.z
OMZ_DIR="$HOME/.zsh/ohmyzsh"
zstyle ":prompt:pure:host" color red       # highlight when on remote host
zstyle ":prompt:pure:user:root" color red  # highlight when root
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh') # Fix fzf keybinds that may be broken by zsh-vi-mode

# OMZ references are handled a bit strange due to https://github.com/zdharma-continuum/zinit/discussions/651
# We locally reference the plugins in the OMZ repo clone created by df-install.sh to work aroud the above bug.
# But for the lib/*.zsh this somehow doesn't work, so we download these separately.
# Ugly, but works.
zinit wait lucid for \
    "$OMZ_DIR/plugins/git"  \
    "$OMZ_DIR/plugins/gitfast"  \
    "$OMZ_DIR/plugins/mosh" \
    OMZL::key-bindings.zsh \
    OMZL::completion.zsh

zinit ice pick:pure.zsh as:theme depth:1
zinit light "sindresorhus/pure"

# The "depth:1 in the individual lines is just to allow for easier alignment
zinit wait lucid depth:1 for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" zdharma-continuum/fast-syntax-highlighting \
 blockf                                                  zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start"                         zsh-users/zsh-autosuggestions \
 depth:1                                                 agkozak/zsh-z \
 depth:1                                                 mafredri/zsh-async \
 depth:1                                                 jeffreytse/zsh-vi-mode \

zinit ice wait lucid depth:1 as:command, use:"bin/git-forgit"
zinit light 'wfxr/forgit'
#export FORGIT_INSTALL_DIR=$(zplug info wfxr/forgit | grep -E 'dir' | sed -E 's#[^"]*"([^"]+)".*#\1#')

# User configuration --------------------------

. "$HOME/.local/bin/.df-common.sh"

prependToPath "/usr/local/bin"
prependToPath "$HOME/.local/bin"

. ~/.shellrc

# internally resolve aliases before completion
setopt no_complete_aliases
# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all
# display PID when suspending processes as well
setopt longlistjobs
# report the status of backgrounds jobs immediately
setopt notify
# allow use of comments in interactive code
setopt interactivecomments

# useful when having parallel sessions, each dedicated
# to its own tasks
setopt no_share_history
# We can manually enabling sharing for a session on demand
alias share_history="setopt share_history"
# still save the history incrementally. Append so that sessions don't overwrite each other.
# We need the incremental saving, since save-on-exit doesn't reliably trigger when killing
# tmux on system shutdown
setopt inc_append_history_time
# use a history file neatly tucked away
export HISTFILE="$HOME/.zsh/history"
export HISTSIZE=50000
export SAVEHIST=$HISTSIZE
# save each command's beginning timestamp and the duration to the history file
setopt extended_history
# dupes in the history are just annoying. also remove extra blanks.
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_reduce_blanks

zstyle ':completion:*' special-dirs true

# In the plugins section above the key bindings from oh-my-zsh are loaded.
# In almost all cases that should be perfectly fine, but here's an additional
# mechanism to fix bad bindings:
# If zkbd keycode definitions exist, apply the most important ones
# This means, if some of the keys listed here don't work in your terminal,
# you can 'autoload zkbd ; zkbd', follow the instructions and re-login
# to make it work.
if [[ -f ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE} ]] ; then
    source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
    [[ -n ${key[Left]}      ]] && bindkey "${key[Left]}"      backward-char
    [[ -n ${key[Right]}     ]] && bindkey "${key[Right]}"     forward-char
    [[ -n ${key[Up]}        ]] && bindkey "${key[Up]}"        up-line-or-history
    [[ -n ${key[Down]}      ]] && bindkey "${key[Down]}"      down-line-or-history
    [[ -n ${key[Home]}      ]] && bindkey "${key[Home]}"      beginning-of-line
    [[ -n ${key[End]}       ]] && bindkey "${key[End]}"       end-of-line
    [[ -n ${key[Delete]}    ]] && bindkey "${key[Delete]}"    delete-char
    [[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
fi

# ^v will edit the current cmdline in the default editor
# Note: C-xC-e also does this (defined in omz key bindings). Maybe I'll remove
# this mapping here (^v) in the future, but for now it's at least useful documentation.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line

autoload -Uz compinit && compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -d ~/.zsh/local ]] ; then
    for script in ~/.zsh/local/*.zsh ; do
        source $script
    done
fi