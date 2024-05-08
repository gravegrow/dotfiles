alias ls='exa -l --icons --group-directories-first'
alias la='exa -la --icons --group-directories-first'
alias tree="tree -C"
alias py='python3'
alias lg='lazygit'


set -U fish_color_autosuggestion '#555555'


set --export EDITOR 'nvim'

set --export GOPATH $HOME/.local/src/go/bin/
set --export PATH $PATH $GOPATH
set --export PATH $PATH ~/.local/bin/
set --export PATH $PATH ~/.cargo/bin/
set --export TMPDIR /tmp
set --export LOCALE_ARCHIVE "$(nix-env --installed --no-name --out-path --query glibc-locales)/lib/locale/locale-archive"

fish_vi_key_bindings
fish_ssh_agent
fish_add_path $HOME/.spicetify
pyenv init - | source

starship init fish | source
enable_transience

