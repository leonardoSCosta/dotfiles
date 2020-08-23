#!/bin/sh

# Copia todos os arquivos de configuração para a pasta do repositório
cp -rf $HOME/.config/nvim/* $PWD/neovim/
cp -f $HOME/.vim/plugged/vim-latex/ftplugin/tex.vim $PWD/vim-latex/
cp -f $HOME/.vimrc $PWD/
