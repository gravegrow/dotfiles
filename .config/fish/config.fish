alias ls='exa -l --icons --group-directories-first'
alias la='exa -la --icons --group-directories-first'
alias tree="tree -C"
alias py='python3'
alias lg='lazygit'


set -U fish_color_autosugestion '#232120'

fish_vi_key_bindings

set --export EDITOR 'nvim'

set --export XDG_DATA_HOME $HOME/.local/share
set --export XDG_CONFIG_HOME $HOME/.config
set --export XDG_STATE_HOME $HOME/.local/state
set --export XDG_CACHE_HOME $HOME/.cache
set --export HISTFILE $XDG_STATE_HOME/bash/history

set --export GOPATH $HOME/.local/src/go/bin/
set --export PATH $PATH $GOPATH
set --export PATH $PATH ~/.local/bin/
set --export PATH $PATH ~/.cargo/bin/
set --export TMPDIR /tmp

set --export  LOCALE_ARCHIVE "$(nix-env --installed --no-name --out-path --query glibc-locales)/lib/locale/locale-archive"

fish_ssh_agent
fish_add_path $HOME/.spicetify

function mkcd
    mkdir -p -- $argv && cd -- $argv
end

function mkfile
    mkdir -p $(dirname $argv) && touch $argv
end

function starship_transient_prompt_func
  starship module character
end

starship init fish | source
enable_transience


fish_add_path /home/gravegrow/.spicetify
pyenv init - | source

