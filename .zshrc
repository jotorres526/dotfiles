### OPTIONS ###
setopt correct                                                  # Auto correct mistakes
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt nocheckjobs                                              # Don't warn about running processes when exiting
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt autocd                                                   # if only directory path is entered, cd there.

### PROMPT ###
fpath+=$HOME/.zsh/pure                                          # Adding pure to fpath
autoload -U promptinit; promptinit
prompt pure                                                     # Pure prompt. Check https://github.com/sindresorhus/pure

zstyle :prompt:pure:git:stash show yes

export SUDO_PROMPT=$'\e[1;91mPassword:\e[0m '                                # Make the sudo prompt simpler
### Auto-completion ###
autoload -U compinit
compinit -d

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # Automatically find new executables in path

# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# History settings
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=500


### KEYBINDINGS ###
bindkey '^[[1;5C' forward-word                                  # Ctrl+→ -> Goto next word
bindkey '^[[1;5D' backward-word                                 # Ctrl+← -> Goto previous word
bindkey '^H' backward-kill-word                                 # Ctrl+backspace -> Delete previous word


#### ALIASES ###
if [ -e $HOME/.aliases ]; then
    source $HOME/.aliases
fi

### SYNTAX HIGHLIGHTING ###
source $HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
