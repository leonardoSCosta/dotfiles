#!/bin/sh

# Copia todos os arquivos de configuração para a pasta do repositório
cp -rf $HOME/.config/nvim/* $PWD/neovim/
cp -f $HOME/.vim/plugged/vim-latex/ftplugin/tex.vim $PWD/vim-latex/
cp -f $HOME/.vimrc $PWD/
cp -f $HOME/.config/starship.toml $PWD/
cp -f $HOME/.bash_aliases $PWD/
cp -rf $HOME/Imagens/Papéis\ de\ parede/* $PWD/Wallpapers
