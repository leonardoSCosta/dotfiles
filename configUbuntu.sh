#!/bin/sh
sudo apt install -y build-essential git neovim nodejs luarocks autoconf 
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
mv starship.toml $HOME/.config/
