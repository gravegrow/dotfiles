#/bin/bash

sudo apt update -y
sudo apt install nala -y
sudo nala upgrade -y

install_nix() {
	sh <(curl -L https://nixos.org/nix/install) --daemon
	nix-env -if $HOME/dotfiles/install/packages.nix
	nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl && nix-channel --update
	nix-env -iA nixgl.auto.nixGLDefault
}

install_fish() {
	sudo apt-add-repository ppa:fish-shell/release-3 -y
	sudo nala install fish -y
	sudo chsh -s $(which fish) $USER
}

install_kitty() {
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
	sudo ln -s ~/.local/kitty.app/bin/kitty /usr/bin/
	sudo ln -s ~/.local/kitty.app/bin/kitten /usr/bin/
}

install_neovim() {
	sudo nala install ninja-build gettext cmake unzip curl -y
	git clone https://github.com/neovim/neovim /tmp/neovim
	make -C /tmp/neovim CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make -C /tmp/neovim install
}

install_awesome() {
	sudo apt build-dep awesome
	sudo nala install libxcb-xfixes0-dev xterm -y
	git clone https://github.com/awesomewm/awesome /tmp/awesome
	make -C /tmp/awesome package
	sudo nala install /tmp/awesome/build/*.deb -y
}

install_other() {
	sudo nala install xdotool -y
}

install_nix
install_fish
install_other

install_neovim
install_kitty
install_awesome
