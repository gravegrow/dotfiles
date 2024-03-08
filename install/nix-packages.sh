#/usr/bin/env bash

nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl && nix-channel --update
nix-env -iA nixgl.auto.nixGLDefault
nix-env -if $HOME/dotfiles/install/packages.nix
