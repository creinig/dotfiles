# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export SHELL=$(which zsh)
export DISABLE_AUTO_TITLE=true

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="babun"
ZSH_THEME="kardan"
#ZSH_THEME="terminalparty"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git gitfast kubectl mosh scd vi-mode)

# zplug configuration

if [[ -f ~/.zsh/zplug/init.zsh ]] ; then
    export ZPLUG_HOME=~/.zsh/zplug
    . $ZPLUG_HOME/init.zsh

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
    zplug load --verbose
fi


# User configuration

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"

ZSH_DISABLE_COMPFIX=true

source $ZSH/oh-my-zsh.sh

setopt no_complete_aliases

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# useful when having parallel sessions, each dedicated
# to its own tasks
setopt no_share_history
alias share_history="setopt share_history"

zstyle ':completion:*' special-dirs true

#PS1="%{${fg_bold[green]}%}%(2L.+.)%n@%m %# %{${reset_color}%}"

# add vi-mode indicator to prompt
MODE_INDICATOR="%{$fg_bold[red]%}>%{$fg[red]%}VI%{$reset_color%}"
PROMPT="\$(vi_mode_prompt_info)$PROMPT"

. ~/.shellrc
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -d ~/.zsh/local ]] ; then
    for script in ~/.zsh/local/*.zsh ; do
        source $script
    done
fi
