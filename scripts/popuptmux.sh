#!/bin/bash
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  exit 0
fi


width=${2:-80%}
height=${2:-80%}
if [ "$(tmux display-message -p -F "#{session_name}")" = "popup" ];then
  tmux detach-client
else
  tmux popup -d '#{pane_current_path}' -xC -yC -w$width -h$height -E  "tmux attach -t popup || tmux new -s popup"
fi

