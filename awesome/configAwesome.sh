#!/bin/sh
sudo apt install -y build-essential git neovim nodejs luarocks autoconf 
mkdir ~/.config/nvim


git clone https://gitlab.com/leo_costa/my-vim-config

#sudo apt install -y awesome awesome-extra

# Agora vamos baixar o rep com os widgets para o awesome
#cd ~/.config/awesome
#git clone https://github.com/streetturtle/awesome-wm-widgetshttps://github.com/streetturtle/awesome-wm-widgets

# Widget do spotify
# Vamos instalar o pacote de ícones necessário para o widget do spotify
cd
git clone https://github.com/horst3180/arc-icon-theme --depth 1 && cd arc-icon-theme && ./autogen.sh --prefix=/usr
sudo make install

# Agora vamos instalar o spotifi-CLI
#cd
#git clone -y https://gist.github.com/fa6258f3ff7b17747ee3.git
#cd ./fa6258f3ff7b17747ee3 
#chmod +x sp
#sudo cp ./sp /usr/local/bin/

# Vamos instalar o spotify também
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client

# Widget de brilho do monitor
# Utilizando o brightnessctl: 
# Comando para captar o brilho atual do monitor: 
# brightnessctl info | grep "Current" | cut -d"(" -f2 | cut -d")" -f1
# Este comando deve ser colocado no widget de brilho do monitor
#sudo apt install -y brightnessctl

#sudo apt install -y light

# Widget de internet
#git clone -y https://github.com/pltanton/net_widgets.git ~/.config/awesome/net_widgets

# Para mudar o tema do Gtk
#sudo apt install -y lxappearance

# Para ativar a transparência das janelas
#sudo apt install -y compton

# Para que o compton seja executado ao inicar devemos editar o arquivo
# /etc/X11/xinit/xinitrc e adiconar as seguintes linhas no inicio do arquivo
# (depois do #!/bin/sh):
#[ -f /etc/xprofile ] && source /etc/xprofile
#[ -f ~/.xprofile ] && source ~/.xprofile

#echo compton -b > $HOME/.xprofile
#echo xrandr -s 1680x1050 >> $HOME/.xprofile

# Agora adicione o seguinte comando no arquivo .xprofile 
# compton -b

# Instalar estas fontes(baixar e colocar na pasta ~/.fonts e rodar o comando fc-cache -v
#**Typicons** - [github](https://github.com/fontello/typicons.font)
#**Material Design Icons** - [dropbox](https://www.dropbox.com/s/4fevs095ho7xtf9/material-design-icons.ttf?dl=0)
#**Icomoon** - [dropbox](https://www.dropbox.com/s/hrkub2yo9iapljz/icomoon.zip?dl=0)
#**Nerd Fonts** - [website](https://www.nerdfonts.com/font-downloads)
#(You only need to pick and download one Nerd Font. They all include the same icons)
#**Scriptina** - [website](https://www.dafont.com/scriptina.font) - Handwritten font used in the lock screen

mv awesomeConfig/awesome/.fonts $HOME
fc-cache -v

wget https://github.com/dracula/gtk/archive/master.zip
mkdir $HOME/.themes
unzip master.zip -d ~/.themes/
gsettings set org.gnome.desktop.interface gtk-theme "Dracula"
gsettings set org.gnome.desktop.wm.preferences theme "Dracula"

# Seta o layout do teclado
#setxkbmap -v -layout us -variant intl

# Instalando o starship
curl -fsSL https://starship.rs/install.sh | bash

echo "Adicionar: eval '$(starship init bash)' no bash.rc (mudar para aspas duplas)"
mv ../starship.toml $HOME/.config/
