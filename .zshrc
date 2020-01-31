# zplug configuration

if [[ -f ~/.zsh/zplug/init.zsh ]] ; then
    export ZPLUG_HOME=~/.zsh/zplug
    . $ZPLUG_HOME/init.zsh

    zplug "plugins/git",     from:oh-my-zsh
    zplug "plugins/gitfast", from:oh-my-zsh
    zplug "plugins/kubectl", from:oh-my-zsh
    zplug "plugins/mosh",    from:oh-my-zsh
    zplug "themes/kardan",   from:oh-my-zsh, as:theme
    zplug "lib/completion", from:oh-my-zsh

#    zplug "laurenkt/zsh-vimto" # good, but messes with right prompt
    zplug "b4b4r07/enhancd", use:init.sh

    forgit_log=gilo
    forgit_diff=gid
    forgit_add=gia
    forgit_reset_head=girh
    forgit_ignore=gi
    forgit_restore=gicf
    forgit_clean=giclean
    forgit_stash_show=giss
    zplug 'wfxr/forgit'

    # Install plugins if there are plugins that have not been installed
    if ! zplug check --verbose; then
        printf "Install missing plugins? [y/N]: "
        if read -q; then
            echo; zplug install
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

zstyle ':completion:*' special-dirs true

#PS1="%{${fg_bold[green]}%}%(2L.+.)%n@%m %# %{${reset_color}%}"

# add vi-mode indicator to prompt
#MODE_INDICATOR="%{$fg_bold[red]%}>%{$fg[red]%}VI%{$reset_color%}"
#PROMPT="\$(vi_mode_prompt_info)$PROMPT"

. ~/.shellrc
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -d ~/.zsh/local ]] ; then
    for script in ~/.zsh/local/*.zsh ; do
        source $script
    done
fi
