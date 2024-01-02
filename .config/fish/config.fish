alias vim='nvim'
alias vi='nvim'
alias ls='exa -l --icons --group-directories-first'
alias la='exa -l --icons --group-directories-first -a'
alias py='python3'
alias python='python3'
alias godot="/media/storage/software/godot/Godot_v4.2-stable_linux.x86_64"

alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"


fish_vi_key_bindings

# set -x VIRTUAL_ENV_DISABLE_PROMPT 1
set --export EDITOR 'nvim'
# set --export TERM 'kitty'

set --global tide_git_icon 
set --global tide_os_icon ''

set --export XDG_DATA_HOME $HOME/.local/share
set --export XDG_CONFIG_HOME $HOME/.config
set --export XDG_STATE_HOME $HOME/.local/state
set --export XDG_CACHE_HOME $HOME/.cache

set --export HISTFILE $XDG_STATE_HOME/bash/history

set --export GOPATH $HOME/.local/src/go/bin/
set --export PATH $PATH $GOPATH
set --export PATH $PATH ~/.local/bin/
set --export PATH $PATH ~/.cargo/bin/


set --export PATH $PATH /usr/autodesk/maya/bin
set --export PYTHONPATH ""
set --export PYTHONPATH $PYTHONPATH /media/storage/dev/maya/tools/
set --export PYTHONPATH $PYTHONPATH /media/storage/dev/maya/toolset/
set --export PYTHONPATH $PYTHONPATH /media/storage/development/maya/MayaKit/
set --export TMPDIR /tmp

fish_ssh_agent

fish_add_path /home/gravegrow/.spicetify

function mkcd
    mkdir -p -- $argv && cd -- $argv
end

function starship_transient_prompt_func
  starship module character
end

starship init fish | source
enable_transience

