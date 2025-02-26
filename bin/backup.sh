#!/bin/bash
SOURCE=$HOME
DEST=backblaze:valewood-linux-backups
HOSTNAME=`hostname`

rclone sync $SOURCE ${DEST}/${HOSTNAME} \
    --fast-list \
    --skip-links \
    --exclude "**/node_modules/**" \
    --exclude "**/vendor/**" \
    --exclude "**/*.archive/**" \
    --exclude "**/cache/**" \
    --exclude "**/.git/**" \
    --exclude "**/.zig-cache/**" \
    --exclude "**/tailwindcss" \
    --exclude "**/*.deb" \
    --exclude "**/*.exe" \
    --exclude "**/*.iso" \
    --exclude "Arduino/**" \
    --exclude ".arduino*/**" \
    --exclude "Audio/**" \
    --exclude ".bash_history" \
    --exclude ".cache/**" \
    --exclude ".calc_history" \
    --exclude ".cargo/**" \
    --exclude ".codeium/**" \
    --exclude "code/nwillc/**" \
    --exclude "code/github.com/Ash*/**" \
    --exclude "code/github.com/comfy*/**" \
    --exclude "code/github.com/ell*/**" \
    --exclude "code/github.com/gg*/**" \
    --exclude "code/github.com/gh*/**" \
    --exclude "code/github.com/go*/**" \
    --exclude "code/github.com/gwagner/dotfiles/**" \
    --exclude "code/github.com/gwagner/kube-cluster/**" \
    --exclude "code/github.com/gwagner/laravel-*/**" \
    --exclude "code/github.com/gwagner/obs-studio/**" \
    --exclude "code/github.com/gwagner/unity-*/**" \
    --exclude "code/github.com/i*/**" \
    --exclude "code/github.com/k*/**" \
    --exclude "code/github.com/m*/**" \
    --exclude "code/github.com/n*/**" \
    --exclude "code/github.com/o*/**" \
    --exclude "code/github.com/R*/**" \
    --exclude ".config/**" \
    --exclude "Desktop/**" \
    --exclude "Downloads/addons/**" \
    --exclude "Downloads/zelda/**" \
    --exclude "dictation/**" \
    --exclude "dictation-recordings/**" \
    --exclude ".dotnet/**" \
    --exclude ".electron-gyp/**" \
    --exclude ".festival_history" \
    --exclude ".festivalrc" \
    --exclude ".fltk/**" \
    --exclude "Games/**" \
    --exclude ".gnupg" \
    --exclude "go/**" \
    --exclude ".hyprland/**" \
    --exclude ".idlerc" \
    --exclude ".ipython/**" \
    --exclude ".java/**" \
    --exclude ".kerbas/**" \
    --exclude ".kube/**" \
    --exclude ".lemminx/**" \
    --exclude ".lesshst" \
    --exclude ".lldb/**" \
    --exclude ".local/**" \
    --exclude ".motion-canvas/**" \
    --exclude ".mozilla/**" \
    --exclude ".npm/**" \
    --exclude ".nuget/**" \
    --exclude ".oh-my-zsh/**" \
    --exclude ".openshot_qt/**" \
    --exclude ".plastic4/**" \
    --exclude ".polybar.logs" \
    --exclude ".pyenv/**" \
    --exclude ".pylint.d/**" \
    --exclude ".python_history" \
    --exclude ".steam/**" \
    --exclude ".ScreamingFrogSEOSpider/**" \
    --exclude ".tmux/plugins/**" \
    --exclude ".vim/plugged/**" \
    --exclude "virtual-machines/**" \
    --exclude ".vnc/**" \
    --exclude ".vscode-oss/**" \
    --exclude ".vscode-server/**" \
    --exclude ".vscodium-server/**" \
    --exclude ".wine/**" \
    --exclude ".wrangler/**" \
    --exclude "yay/**" \
    --exclude ".zoom/**" \
    --exclude ".zsh_history" \
    --exclude "*.mkv" \
    --exclude "*.wav" \
    --exclude ".var/**" \
    --exclude "valewood.org/**" \
    --delete-excluded \
    --progress \
    -v 

if [ -d "/opt/scanner/" ]; then

rclone sync /opt/scanner/ ${DEST}/scanned_documents \
    --fast-list \
    --skip-links \
    --progress \
    -v 
fi
