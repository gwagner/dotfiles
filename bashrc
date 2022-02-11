#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -hal --color=auto'
alias vi="nvim"
alias vim="nvim"
alias nano="nvim"
alias qtile_log="tail -n 200 ~/.local/share/qtile/qtile.log"
alias cam-loopback="~/.bin/process-watcher -config ~/.config/process-watcher-configs/loopback.yaml"

export EDITOR=nvim
export VISDUAL=nvim
