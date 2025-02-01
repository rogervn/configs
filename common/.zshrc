# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=130000
SAVEHIST=130000
PATH=$PATH:/home/rogervn/go/bin:/home/rogervn/bin
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY
setopt appendhistory beep nomatch notify
unsetopt autocd extendedglob
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/rogervn/.zshrc'

autoload -Uz compinit promptinit
compinit
promptinit
# End of lines added by compinstall

# VI style
set -o vi

# Theme (need prezto)
prompt powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add wal sequences if file exist
[ -f ~/.cache/wal/sequences ] && (cat ~/.cache/wal/sequences &)

# Completion additions
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' rehash true
setopt COMPLETE_ALIASES

# xterm-like title
autoload -Uz add-zsh-hook
function xterm_title_precmd () {
	print -Pn '\e]2;%n@%m %1~\a'
}

function xterm_title_preexec () {
	print -Pn '\e]2;%n@%m %1~ %# '
	print -n "${(q)1}\a"
}
if [[ "$TERM" == (screen*|xterm*|rxvt*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

# fzf key-bindings
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh

# default editor
EDITOR=vim

# Ctrl-backspace kill word
bindkey '^H' backward-kill-word

# Home and End for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line

# Ctrl-backspace delete word backwards
bindkey '^H' backward-kill-word

# Kitty terminfo fix on ssh
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# Uses a single tmux session everytime if tmux is installed and
# shell is interactive
#if [[ $- == *i* ]] && which tmux >/dev/null 2>&1; then
#
#    # Sets TERM to screen-256color to work with tmux
#    export TERM=screen-256color
#
#    if [[ -z "$TMUX" ]] ;then
#        ID="`tmux ls | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
#        if [[ -z "$ID" ]] ;then # if not available create a new one
#            tmux -2 new-session
#        else
#            tmux -2 attach-session -t "$ID" # if available attach to it
#        fi
#    fi
#fi
