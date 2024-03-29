#                                     _              
#                             _______| |__  _ __ ___ 
#                            |_  / __| '_ \| '__/ __|
#                           _ / /\__ \ | | | | | (__ 
#                          (_)___|___/_| |_|_|  \___|


# IMPORTS {{{
# source ~/.bashrc
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
export PATH="/usr/local/sbin:$PATH"
# }}}


# PLUGINS {{{
# zsh-completions
fpath=($ZPLUG_HOME/repos/zsh-users/zsh-completions/src ~/.zsh/completion $fpath)

# zplug
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "b4b4r07/enhancd", use:init.sh
zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme
zplug load
setopt nonomatch

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
# }}}


# HISTORY {{{
# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=1000000

# share .zshhistory
setopt inc_append_history
setopt share_history

# cdr
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi
# }}}


# COLOR {{{
# ls_colors
if [[ -z "$SHELL" ]]; then
    export SHELL="$(which zsh)"
fi
eval `gdircolors -b`
eval `gdircolors ${HOME}/.dircolors-monokai`

# remove file mark
unsetopt list_types

# color at completion
autoload -Uz colors
colors
zstyle ':completion:*' verbose yes
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# less
export LESS='-R'

# man
export MANPAGER='less -R'
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;33m") \
        LESS_TERMCAP_md=$(printf "\e[1;36m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}
# }}}

# ALIAS {{{
# general
alias h='tldr'
alias l='gls -CF --color=auto'
alias ls='gls -CF --color=auto'
alias la='gls -A --color=auto'
alias ll='gls -l --color=auto'
alias lla='gls -la --color=auto'
alias m='mkdir'
alias reload='source ~/.zshrc'
alias ssh='TERM=xterm ssh'
alias sudo='sudo '
alias tm='terminal'

# cd
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'

# dotfiles
alias dot='cd ~/dev/src/github.com/rollo1h/dotfiles'
alias zshconfig='nvim ~/.zshrc'
alias vimconfig='nvim ~/.vimrc'

# git
alias g='git'
alias gb='git branch'
alias gl='git log --pretty=format:"%C(yellow)%h%Creset %C(magenta)%ci%Creset%n%C(cyan)%an <%ae>%Creset%n%B"'
alias glp='git log -p'
alias glg='git log --graph --pretty=format:"%C(yellow)%h%Creset %C(magenta)%ci%Creset%n%C(cyan)%an <%ae>%Creset%n%B"'
alias gco='git checkout'
alias gd='git diff'
alias gdh='git diff HEAD'
alias gds='git diff --stat'
alias gdt='git difftool'
alias gst='git status'
alias gp='git pull'

# docker
alias d='docker'
alias dps='docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}"'
alias dc='docker-compose'
alias kc='kubectl'

# brew
alias brew="env PATH=${PATH/\/Users\/rollo\/\.pyenv\/shims:/} brew"
# }}}

# Python {{{
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# pipenv
eval "$(pipenv --completion)"
# }}}

# Directory {{{
# direnv
eval "$(direnv hook bash)"
# }}}

# LOCAL {{{
# Load local setting
if [ -e ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi
# }}}
