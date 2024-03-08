#/bin/bash

sudo apt update -y
sudo apt install nala curl git -y
sudo nala upgrade -y

install_nix() {
	sh <(curl -L https://nixos.org/nix/install) --daemon
}

install_fish() {
	sudo apt-add-repository ppa:fish-shell/release-3 -y
	sudo nala install fish -y
	sudo chsh -s $(which fish) $USER
}

install_wezterm() {
	curl -LO https://github.com/wez/wezterm/releases/download/20240203-110809-5046fc22/wezterm-20240203-110809-5046fc22.Ubuntu22.04.deb
	sudo nala install -y ./wezterm-20240203-110809-5046fc22.Ubuntu22.04.deb
	rm wezterm-20240203-110809-5046fc22.Ubuntu22.04.deb
}

install_neovim() {
	sudo nala install ninja-build gettext cmake unzip curl -y
	git clone https://github.com/neovim/neovim /tmp/neovim
	make -C /tmp/neovim CMAKE_BUILD_TYPE=RelWithDebInfo
	sudo make -C /tmp/neovim install
}

install_awesome() {
	sudo apt build-dep awesome
	sudo nala install libxcb-xfixes0-dev -y
	git clone https://github.com/awesomewm/awesome /tmp/awesome
	make -C /tmp/awesome package
	sudo nala install /tmp/awesome/build/*.deb -y
}

install_other() {
	sudo nala install xdotool -y
}

install_nix
install_wezterm
install_neovim
install_awesome
install_fish
