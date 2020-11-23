# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

autoload -Uz compinit
compinit

##### THEME #######
fpath+=$HOME/.zsh/pure

autoload -U promptinit; promptinit
prompt pure

zstyle :prompt:pure:git:stash show yes

# End of lines added by compinstall
##### ALIASES #####

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias ls='ls -lah --color=auto'

source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
