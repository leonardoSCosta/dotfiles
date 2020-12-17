#!/bin/sh
sudo apt install -y build-essential git neovim nodejs luarocks autoconf ripgrep
mkdir ~/.config/nvim

git clone https://gitlab.com/leo_costa/my-vim-config

# Tema de ícones
cd
git clone https://github.com/horst3180/arc-icon-theme --depth 1 && cd arc-icon-theme && ./autogen.sh --prefix=/usr
sudo make install

# Vamos instalar o spotify também
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client

# Instalar estas fontes(baixar e colocar na pasta ~/.fonts e rodar o comando fc-cache -v

#**Typicons** - [github](https://github.com/fontello/typicons.font)
#**Material Design Icons** - [dropbox](https://www.dropbox.com/s/4fevs095ho7xtf9/material-design-icons.ttf?dl=0)
#**Icomoon** - [dropbox](https://www.dropbox.com/s/hrkub2yo9iapljz/icomoon.zip?dl=0)
#**Nerd Fonts** - [website](https://www.nerdfonts.com/font-downloads)
#**Scriptina** - [website](https://www.dafont.com/scriptina.font) - Handwritten font used in the lock screen
#(You only need to pick and download one Nerd Font. They all include the same icons)

mv .fonts $HOME
fc-cache -v

# Tema dracula GTK
wget https://github.com/dracula/gtk/archive/master.zip
mkdir $HOME/.themes
unzip master.zip -d ~/.themes/
gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"

# Instalando o starship
curl -fsSL https://starship.rs/install.sh | bash

echo "Adicionar: --eval '$(starship init bash)'-- no bash.rc (mudar para aspas duplas)"
mkdir -p ~/.config && touch ~/.config/starship.toml
mv starship.toml $HOME/.config/

# Instalar o alacritty
cd
git clone https://github.com/alacritty/alacritty.git
cd alacritty

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

rustup override set stable
rustup update stable


sudo apt-get install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3

cargo build --release

# Desktop entry
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

# Manual pages
sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null

# Shell completions for bash
mkdir -p ~/.bash_completion
cp extra/completions/alacritty.bash ~/.bash_completion/alacritty
echo "source ~/.bash_completion/alacritty" >> ~/.bashrc

# Setar alacritty como terminal padrão
#sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
#sudo update-alternatives --config x-terminal-emulator
