# emacs style
set -o emacs

# Fixes cedilla in GTK
export GTK_IM_MODULE=cedilla

# Uses a single tmux session everytime if tmux is installed and
# shell is interactive
if [[ $- == *i* ]] && which tmux >/dev/null 2>&1; then

    # Sets TERM to screen-256color to work with tmux
    export TERM=screen-256color

    if [[ -z "$TMUX" ]] ;then
        ID="`tmux ls | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
        if [[ -z "$ID" ]] ;then # if not available create a new one
            tmux -2 new-session
        else
            tmux -2 attach-session -t "$ID" # if available attach to it
        fi
    fi
fi

