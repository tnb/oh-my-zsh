# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="nico"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(zsh-syntax-highlighting sudo git svn gradle command-not-found nyan extract sublime colored-man taskwarrior github history-substring-search fuck)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# Autocorrection
#setopt correctall
setopt nocorrectall
setopt autocd correct

# Gestion de l'historique
export HISTFILE=~/.histfile
export HISTSIZE=2000
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_ignore_space

# Mode d'édition des lignes
bindkey -e

# Activation des glob etendu
setopt extendedglob

# Style de l'autocompletion
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache
zmodload zsh/complist
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

# Filtre elements dans autocompletion
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:mv:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes

# Autocompletion avec le sudo
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# Alias
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -lh'
alias la='ll -A'
alias l='ls -CF'
alias lt='ll -t'
alias gphistory='history | grep'

export MANPAGER="/usr/bin/most -s"
export TERM=xterm-256color

export PATH=$HOME/usr/bin:$PATH

export EDITOR="vim"

# Pour les one-liner de git
V1=lts-2015.5
V2=2015.5
DOUBLE_MERGE="echo -e '\n-- Pull last version --' && git checkout $V1 && git pull && git checkout master && git pull && echo -e '\n-- Merge of $V1 on $V2 --' && git checkout $V2 && git pull && git merge $V1 -m 'merge $V1' && echo -e '\n-- Merge $V2 on master --' && git checkout master && git pull && git merge $V2 -m 'merge $V2' && echo -e '\n-- Push branches --' && git push && git checkout $V2 && git push && git checkout $V1 && git push"

SIMPLE_MERGE="echo -e '\n-- Pull last version --' && git checkout $V2 && git pull && git checkout master && git pull && echo -e '\n-- Merge of $V2 on master --' && git merge $V2 -m 'merge $V2' && git push && git checkout $V2 && git push"
alias simplemerge="eval $SIMPLE_MERGE"
alias doublemerge="eval $DOUBLE_MERGE"

[[ -e ~/.zshopt ]] && emulate sh -c 'source ~/.zshopt'

[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'
