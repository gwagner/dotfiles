# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/gwagner/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="nord-extended/nord"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(ansible git vscode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias yt="mpv --autofit=\"25%x25%\""
alias kb="/bin/bash ~/.xsessionrc"

## Setup Editors
export EDITOR='nvim'
export VISUAL='nvim'
alias vi="nvim"
alias vim="nvim"
alias nano="nvim"

## Virtualization Configs
export VIRSH_DEFAULT_CONNECT_URI='qemu:///system'

## Runtime env vars
export PATH=$PATH:/home/gwagner/.bin
export PATH=$PATH:/home/gwagner/go/bin
export JAVA_HOME=/usr/lib/jvm/default-runtime/bin/
export GOPATH=$HOME/go/
export GOBIN=$GOPATH/bin/
export GOPROXY=direct

# work aliases
alias dowork="ffplay -f v4l2 -framerate 60  -fflags nobuffer -flags low_delay -sync ext -input_format mjpeg -video_size 1920x1080 -i /dev/video0 -vf \"tblend\" -vf framerate=fps=60 -stats -infbuf -loglevel error"

# Setup node for global install
export npm_config_prefix="$HOME/.local"
PATH="$HOME/.local/bin:$PATH"

#ZSH aliases
alias reload="source ~/.zshrc"

#TMUX aliases
alias ta="tmux attach"
function exit {
  if [ ${TMUX} ]; then
      tmux detach
  else 
      builtin exit
  fi
}

# Productivity Aliases
alias ls='ls -hal --color=auto'

## fzf specific
export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/\.git/*"' # Find files (excludes hidden files)
alias fa="fzf-tmux -p 80%,80% --preview 'bat --style=numbers --color=always --line-range :500 {}' --preview-window=right:70%:wrap | xargs -r nvim"
function f {
  ag -g "" --silent | fzf-tmux -p 80%,80% --preview 'bat --style=numbers --color=always --line-range :500 {}' --preview-window=right:70%:wrap | xargs -r nvim
}
#alias sd='cd ~ && cd $(find . -type d ! -path "*/\.*" ! -path "./Games/*" ! -path "./go/*" ! -path "./Downloads/*" ! -path "./Desktop/*" ! -path "./yay/*" ! -path "./.cache/*" ! -path "*/VSCodium/*" 2>&1 | grep -v "Permission denied" | fzf-tmux -p 80%,80%)'
alias sd='cd ~ && cd $(fd --type d --ignore-file ~/.config/search_ignore | fzf-tmux -p 80%,80%)'

tts() {
  echo "$@" | festival --tts
}

if command -v pyenv &> /dev/null
then
	export PYENV_ROOT="$HOME/.pyenv"
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
	export PATH="$HOME/.pyenv/bin:$PATH"
fi

if [ -n "$TMUX" ]; then                                                                               
  function refresh { 
    TMUX_HYPRLAND_INSTANCE_SIGNATURE=$(tmux show-environment | grep "^HYPRLAND_INSTANCE_SIGNATURE" | cut -f2 -d=)
    
    if [ "$HYPRLAND_INSTANCE_SIGNATURE" != "$TMUX_HYPRLAND_INSTANCE_SIGNATURE" ]; then
      export $(tmux show-environment | grep "^HYPRLAND_INSTANCE_SIGNATURE")                                       
      export $(tmux show-environment | grep "^WAYLAND_DISPLAY")
      echo "hyprland env vars refreshed"
    fi
  }  

  function hyprctl {
    refresh

    /usr/bin/hyprctl $@
  }
else                                                                                                  
  function refresh { }                                                                              
fi


# Startup TMUX
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  tmux attach -t "primary" || tmux new-session -t "primary"
fi

fastfetch


