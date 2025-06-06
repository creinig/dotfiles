export SHELL=$(which zsh)

# zplug configuration

if [[ -f ~/.zsh/zplug/init.zsh ]] ; then
    export ZPLUG_HOME=~/.zsh/zplug
    . $ZPLUG_HOME/init.zsh

    zplug 'zplug/zplug', hook-build:'zplug --self-manage'

    zplug "plugins/git",      from:oh-my-zsh # git aliases
    zplug "plugins/gitfast",  from:oh-my-zsh # git completion
    zplug "plugins/mosh",     from:oh-my-zsh # completion
    zplug "lib/completion",   from:oh-my-zsh
    zplug "lib/key-bindings", from:oh-my-zsh

    # zplug "Aloxaf/fzf-tab"
    zplug "mafredri/zsh-async"

    zplug "sindresorhus/pure", use:pure.zsh, as:theme
    export PURE_GIT_PULL=0 # don't automatically fetch from remote - can be expensive on a mobile hotspot
    zstyle ":prompt:pure:host" color red       # highlight when on remote host
    zstyle ":prompt:pure:user:root" color red  # highlight when root

    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#505050"
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    zplug "zsh-users/zsh-autosuggestions"

    ZSHZ_DATA=~/.zsh/.z
    zplug "agkozak/zsh-z"

    zplug 'wfxr/forgit', as:command, use:"bin/git-forgit"
    export FORGIT_INSTALL_DIR=$(zplug info wfxr/forgit | grep -E 'dir' | sed -E 's#[^"]*"([^"]+)".*#\1#')

    zplug "zsh-users/zsh-syntax-highlighting", defer:2

    zstyle ":zplug:tag" depth 1

    # Install plugins if there are plugins that have not been installed
    if ! zplug check --verbose; then
        printf "Install missing plugins? [y/N]: "
        if read -q; then
            echo; zplug install
            chmod -R 0755 ~/.zsh/ # satisfy compaudit
        fi
    fi

    # Then, source plugins and add commands to $PATH
    zplug load # --verbose
fi


# User configuration

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


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -d ~/.zsh/local ]] ; then
    for script in ~/.zsh/local/*.zsh ; do
        source $script
    done
fi