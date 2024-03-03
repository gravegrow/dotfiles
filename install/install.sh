#/bin/bash

sudo apt update -y
sudo apt install nala -y

install_nix() {
	sh <(curl -L https://nixos.org/nix/install) --daemon
	nix-env -if $HOME/dotfiles/install/packages.nix
}

install_fish() {
	sudo apt-add-repository ppa:fish-shell/release-3
	sudo nala update -y
	sudo nala install fish -y
	sudo chsh -s $(which fish) $USER
}

install_kitty() {
	curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
	sudo ln -s ~/.local/kitty.app/bin/kitty /usr/bin/
	sudo ln -s ~/.local/kitty.app/bin/kitten /usr/bin/
}

install_neovim() {
	git clone https://github.com/neovim/neovim /tmp/neovim
	make -C /tmp/neovim CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make -C /tmp/neovim install
}

install_awesome() {
	sudo apt build-dep awesome
	git clone https://github.com/awesomewm/awesome /tmp/awesome
	make -C /tmp/awesome package
	sudo nala install /tmp/awesome/build/*.deb
}

install_nix
install_fish
install_neovim &
install_kitty &
install_awesome &
