#!/bin/sh
#      _   _ _                 _            ____             __ _
#     | | | | |__  _   _ _ __ | |_ _   _   / ___|___  _ __  / _(_) __ _
#     | | | | '_ \| | | | '_ \| __| | | | | |   / _ \| '_ \| |_| |/ _` |
#     | |_| | |_) | |_| | | | | |_| |_| | | |__| (_) | | | |  _| | (_| |
#      \___/|_.__/ \__,_|_| |_|\__|\__,_|  \____\___/|_| |_|_| |_|\__, |
#                                                                 |___/

# ============================================================================
#                      ____                 _
#                     |  _ \ __ _  ___ ___ | |_ ___  ___
#                     | |_) / _` |/ __/ _ \| __/ _ \/ __|
#                     |  __/ (_| | (_| (_) | ||  __/\__ \
#                     |_|   \__,_|\___\___/ \__\___||___/

sudo apt install -y \
    build-essential git neovim nodejs luarocks autoconf ripgrep \
    sxiv fish curl flameshot zathura texlive-full gimp inkscape ipe npm cmake \
    clang clangd fd-find cargo asciidoctor neofetch meld kitty figlet lolcat \
    tty-clock cava dunst gnome-shell-extension-autohidetopbar playerctl \
    fontforge gucharmap libnotify-dev

sudo snap install shotcut --classic
sudo npm install -g coinmon

gem install asciidoctor-pdf

cargo install exa
# cargo install dust # Não funciona no ubuntu 20.04

# ============================================================================

# ============================================================================
#      ___                                   _____
#     |_ _|___ ___  _ __   ___  ___    ___  |_   _|__ _ __ ___   __ _ ___
#      | |/ __/ _ \| '_ \ / _ \/ __|  / _ \   | |/ _ \ '_ ` _ \ / _` / __|
#      | | (_| (_) | | | |  __/\__ \ |  __/   | |  __/ | | | | | (_| \__ \
#     |___\___\___/|_| |_|\___||___/  \___|   |_|\___|_| |_| |_|\__,_|___/

# Arc Icons
cd
git clone https://github.com/horst3180/arc-icon-theme --depth 1
cd arc-icon-theme && ./autogen.sh --prefix=/usr
sudo make install

# Flatery Icons
cd
git clone https://github.com/cbrnix/Flatery && cd Flatery && ./instal.sh
cd; rm -r Flatery
gsettings set org.gnome.desktop.interface icon-theme \'Flatery-Dark\'

# Tema dracula GTK
wget https://github.com/dracula/gtk/archive/master.zip
mkdir $HOME/.themes
unzip master.zip -d ~/.themes/
gsettings set org.gnome.desktop.interface gtk-theme "Dracula-GTK"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula-GTK"

# Tema do zathura
git clone https://github.com/dracula/zathura ~/.config/zathura/

# Spotify
# curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add
# echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
# sudo apt-get update && sudo apt-get install spotify-client

# ============================================================================
#                          _____           _
#                         |  ___|__  _ __ | |_ ___  ___
#                         | |_ / _ \| '_ \| __/ _ \/ __|
#                         |  _| (_) | | | | ||  __/\__ \
#                         |_|  \___/|_| |_|\__\___||___/

mv .fonts $HOME
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
unzip JetBrainsMono.zip -d JetBrainsMono/
mv JetBrainsMono/* ~/.fonts
fc-cache -v

# ============================================================================
#                      _____                   _             _
#                     |_   _|__ _ __ _ __ ___ (_)_ __   __ _| |
#                       | |/ _ \ '__| '_ ` _ \| | '_ \ / _` | |
#                       | |  __/ |  | | | | | | | | | | (_| | |
#                       |_|\___|_|  |_| |_| |_|_|_| |_|\__,_|_|

# Instalando o starship
curl -fsSL https://starship.rs/install.sh | bash

# Configurando ele no bash
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# Deixa o fish como shell padrão
echo /usr/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/bin/fish

# Fisher plugin manager
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

# Dracula theme para o fish
fisher install dracula/fish

# Setar kitty como terminal padrão
sudo update-alternatives --install /usr/bin/x-terminal-emulator \
        kitty-terminal /usr/bin/kitty 50

# ============================================================================
#              ____  _          _ _  ____      _
#             / ___|| |__   ___| | |/ ___|___ | | ___  _ __ ___
#             \___ \| '_ \ / _ \ | | |   / _ \| |/ _ \| '__/ __|
#              ___) | | | |  __/ | | |__| (_) | | (_) | |  \__ \
#             |____/|_| |_|\___|_|_|\____\___/|_|\___/|_|  |___/
#

git clone https://gitlab.com/dwt1/shell-color-scripts.git
cd shell-color-scripts
rm -rf /opt/shell-color-scripts
sudo mkdir -p /opt/shell-color-scripts/colorscripts
sudo cp -rf colorscripts/* /opt/shell-color-scripts/colorscripts
sudo cp colorscript.sh /usr/bin/colorscript

# ============================================================================
#               ____            _        ____             __ _
#              / ___|_ __ _   _| |__    / ___|___  _ __  / _(_) __ _
#             | |  _| '__| | | | '_ \  | |   / _ \| '_ \| |_| |/ _` |
#             | |_| | |  | |_| | |_) | | |__| (_) | | | |  _| | (_| |
#              \____|_|   \__,_|_.__/   \____\___/|_| |_|_| |_|\__, |
#                                                              |___/

cd
sudo mkdir -p /usr/share/grub/themes
git clone https://github.com/dracula/grub.git
sudo mv grub/dracula /usr/share/grub/themes/
sudo echo "GRUB_GFXMODE=1920x1080" >> /etc/default/grub
sudo echo "GRUB_THEME=\"/usr/share/grub/themes/dracula/theme.txt\"" >> /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
# ============================================================================
#                            _       _
#                _ __   ___ | |_   _| |__   __ _ _ __
#               | '_ \ / _ \| | | | | '_ \ / _` | '__|
#               | |_) | (_) | | |_| | |_) | (_| | |
#               | .__/ \___/|_|\__, |_.__/ \__,_|_|
#               |_|            |___/

echo "Instal Gmail module"
pip3 install --upgrade google-api-python-client google-auth-httplib2 google-auth-oauthlib
cd ~/.config/polybar
curl -LO https://github.com/crabvk/polybar-gmail/archive/master.tar.gz
tar zxf master.tar.gz && rm master.tar.gz
mv polybar-gmail-master gmail
python3 ~/.config/polybar/gmail/auth.py

# ============================================================================
#       ____             __ _
#      / ___|___  _ __  / _(_) __ _ _   _ _ __ __ _  ___ ___   ___  ___
#     | |   / _ \| '_ \| |_| |/ _` | | | | '__/ _` |/ __/ _ \ / _ \/ __|
#     | |__| (_) | | | |  _| | (_| | |_| | | | (_| | (_| (_) |  __/\__ \
#      \____\___/|_| |_|_| |_|\__, |\__,_|_|  \__,_|\___\___/ \___||___/
#                             |___/

# Adicionar usuário ao grupo dialout
sudo adduser $USER dialout

# Evitar popping sound
sudo echo "options snd-hda-intel power_save=0 power_save_controller=N" >> /etc/modprobe.d/alsa-base.conf

# Corrigir travamento ao usar multimedia keys
# sudo vim /usr/share/X11/xkb/symbols/br
# Comentar a linha \/
# modifier_map Mod4 { Scroll_Lock };
# Usar o comando \/
# setxkbmap

# ============================================================================

mkdir ~/.config/nvim

# Copiando as configs
mkdir -p ~/.config && touch ~/.config/starship.toml
cd; cd my-vim-config
mv starship.toml $HOME/.config/

mkdir -p ~/.config/fish
cp fish/config.fish ~/.config/fish/

cp ./.vimrc ~/
cp -rf ./Wallpapers ~/Imagens/
