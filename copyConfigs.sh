#!/bin/sh

# Copia todos os arquivos de configuração para a pasta do repositório
cp -rf $HOME/.config/nvim/* $PWD/neovim/
cp -rf $HOME/.vim/plugged/vim-latex/ftplugin/tex.vim $PWD/vim-latex/
cp -rf $HOME/.vim/syntax $PWD/
cp -rf $HOME/.vimrc $PWD/
cp -rf $HOME/.config/starship.toml $PWD/
cp -rf $HOME/.bash_aliases $PWD/
cp -rf $HOME/Imagens/Wallpapers/* $PWD/Wallpapers
#cp -rf $HOME/.config/alacritty $PWD/
cp -rf $HOME/.config/fish/config.fish $PWD/fish/
