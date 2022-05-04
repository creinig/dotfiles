export SHELL=$(which zsh)

# zplug configuration

if [[ -f ~/.zsh/zplug/init.zsh ]] ; then
    export ZPLUG_HOME=~/.zsh/zplug
    . $ZPLUG_HOME/init.zsh

    zplug "plugins/git",      from:oh-my-zsh
    zplug "plugins/gitfast",  from:oh-my-zsh
    zplug "plugins/kubectl",  from:oh-my-zsh
    zplug "plugins/mosh",     from:oh-my-zsh
    zplug "lib/completion",   from:oh-my-zsh
    zplug "lib/key-bindings", from:oh-my-zsh

    zplug mafredri/zsh-async
    zplug sindresorhus/pure, use:pure.zsh, as:theme

    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#505050"
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    zplug "zsh-users/zsh-autosuggestions"

    ZSHZ_DATA=~/.zsh/.z
    zplug "agkozak/zsh-z"

    forgit_log=gilo
    forgit_diff=gid
    forgit_add=gia
    forgit_reset_head=girh
    forgit_ignore=gi
    forgit_restore=gicf
    forgit_clean=giclean
    forgit_stash_show=giss
    zplug 'wfxr/forgit'

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

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH


setopt no_complete_aliases
# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
setopt hash_list_all
# save each command's beginning timestamp and the duration to the history file
setopt extended_history
# display PID when suspending processes as well
setopt longlistjobs
# report the status of backgrounds jobs immediately
setopt notify
# allow use of comments in interactive code
setopt interactivecomments
# useful when having parallel sessions, each dedicated
# to its own tasks
setopt no_share_history
alias share_history="setopt share_history"
# dupes in the history are just annoying
setopt hist_ignore_all_dups

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


. ~/.shellrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -d ~/.zsh/local ]] ; then
    for script in ~/.zsh/local/*.zsh ; do
        source $script
    done
fi
