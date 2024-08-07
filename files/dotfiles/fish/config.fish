alias ls='exa --icons --group-directories-first --color=always'
alias la='exa --all  --icons --group-directories-first --color=always'
alias tree='tree -C'
alias py='python3'
alias lg='lazygit'

if type -q bat
    alias cat='bat'
end

fish_vi_key_bindings
fish_ssh_agent
fish_add_path $HOME/.spicetify
pyenv init - | source

starship init fish | source
enable_transience

