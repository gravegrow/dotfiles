alias ls='echo "" && eza --icons=auto --group-directories-first --color=always'
alias la='ls --all'
alias ll='ls -l'
#alias tree='tree -C'
alias tree='ls --tree'
alias py='python3'
alias lg='lazygit'
alias bat='bat --style plain --theme ansi'

alias proton='/home/gravegrow/.steam/steam/compatibilitytools.d/GE-Proton9-20/proton'

set -gx MANPAGER "nvim +Man!"
set -U fish_color_autosuggestion 4f4f59

fish_vi_key_bindings
fish_ssh_agent
fish_add_path $HOME/.spicetify

starship init fish | source
enable_transience
