alias ls='echo "" && eza --icons=auto --group-directories-first --color=always'
alias la='ls --all'
#alias tree='tree -C'
alias tree='ls --tree'
alias py='python3'
alias lg='lazygit'
alias bat='bat --style plain --theme ansi'

set -U fish_color_autosuggestion 4f4f59

fish_vi_key_bindings
fish_ssh_agent
fish_add_path $HOME/.spicetify
#pyenv init - | source

starship init fish | source
enable_transience
