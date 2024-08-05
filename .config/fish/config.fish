alias ls='exa --icons --group-directories-first --color=always'
alias la='exa -all  --icons --group-directories-first --color=always'
alias tree="tree -C"
alias py='python3'
alias lg='lazygit'

if type -q bat
    alias cat='bat'
end

set -U fish_color_autosuggestion '#555555'

set --export EDITOR 'nvim'

set --export GOPATH $HOME/.local/src/go/bin/
set --export PATH $PATH $GOPATH
set --export PATH $PATH ~/.local/bin/
set --export PATH $PATH ~/.cargo/bin/

set --export LOCALE_ARCHIVE "$(nix-env --installed --no-name --out-path --query glibc-locales)/lib/locale/locale-archive"

set -U FZF_COMPLETE 2


fish_vi_key_bindings
fish_ssh_agent
fish_add_path $HOME/.spicetify
pyenv init - | source

starship init fish | source
enable_transience

