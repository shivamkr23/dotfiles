#!/usr/bin/env bash
selected=`cat ~/.local/scripts/tmux-cht-languages ~/.local/scripts/tmux-cht-command | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

$tmux_running = $(pgrep tmux)
if [[ -z $tmux_running ]]; then
    tmux new-session -ds "temp"
fi

if grep -qs "$selected" ~/.local/scripts/tmux-cht-languages; then
    query=`echo $query | tr ' ' '+'`
    tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi

if [[ -z $TMUX ]]; then
    tmux a
fi
