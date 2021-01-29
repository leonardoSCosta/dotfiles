#!/bin/sh
sudo apt install -y \
    build-essential git neovim nodejs luarocks autoconf ripgrep \
    sxiv fish curl flameshot zathura texlive-full gimp inkscape ipe npm cmake \
    clang clangd fd-find cargo
mkdir ~/.config/nvim

cargo install exa
cp ~/.cargo/bin/exa ~/.local/bin/

# git clone https://gitlab.com/leo_costa/my-vim-config

# Tema de ícones
cd
git clone https://github.com/horst3180/arc-icon-theme --depth 1 && cd arc-icon-theme && ./autogen.sh --prefix=/usr
sudo make install

# Vamos instalar o spotify também
#curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add
#echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
#sudo apt-get update && sudo apt-get install spotify-client

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
gsettings set org.gnome.desktop.interface gtk-theme "Gtk-master"
gsettings set org.gnome.desktop.wm.preferences theme "Gtk-master"

# Instalando o starship
curl -fsSL https://starship.rs/install.sh | bash

# Configurando ele no bash
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# Copiando as configs
mkdir -p ~/.config && touch ~/.config/starship.toml
cd; cd my-vim-config
mv starship.toml $HOME/.config/

cp fish/config.fish ~/.config/fish/

cp ./.vimrc ~/
cp -rf ./Wallpapers ~/Imagens/

# Instalar o alacritty
#cd
#git clone https://github.com/alacritty/alacritty.git
#cd alacritty

#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

#rustup override set stable
#rustup update stable


#sudo apt-get install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev python3

#cargo build --release

# Desktop entry
#sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
#sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
#sudo desktop-file-install extra/linux/Alacritty.desktop
#sudo update-desktop-database

# Manual pages
#sudo mkdir -p /usr/local/share/man/man1
#gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null

# Shell completions for bash
#mkdir -p ~/.bash_completion
#cp extra/completions/alacritty.bash ~/.bash_completion/alacritty
#echo "source ~/.bash_completion/alacritty" >> ~/.bashrc

# Deixa o fish como shell padrão
echo /usr/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/bin/fish

# Fisher plugin manager
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
# Dracula theme para fish
fisher install dracula/fish

# Instala shell colors
git clone https://gitlab.com/dwt1/shell-color-scripts.git
cd shell-color-scripts
rm -rf /opt/shell-color-scripts
sudo mkdir -p /opt/shell-color-scripts/colorscripts
sudo cp -rf colorscripts/* /opt/shell-color-scripts/colorscripts
sudo cp colorscript.sh /usr/bin/colorscript

# Setar alacritty como terminal padrão
#sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/alacritty 50
#sudo update-alternatives --config x-terminal-emulator

sudo adduser $USER dialout

# Evitar popping sound
# Adicionar a linha
options snd-hda-intel power_save=0 power_save_controller=N
# no arquivo
/etc/modprobe.d/alsa-base.conf
