#!/bin/bash
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  exit 0
fi

width=${2:-90%}
height=${2:-90%}
if [ "$(tmux display-message -p -F "#{session_name}")" = "popup" ];then
  tmux detach-client
else
  pkm_path="~/code/github.com/gwagner/pkm"
  git pull $pkm_path
  nvim_cmd="cd $pkm_path/notes/ && nvim `date +%Y-%m-%d`.md"
  tmux popup -d '#{pane_current_path}' -xC -yC -w$width -h$height -E  "tmux attach -t popup || tmux new -s popup -E '$nvim_cmd'"
fi

