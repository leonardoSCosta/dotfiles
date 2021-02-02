# Cria os links simbólicos para tudo que está no repositório

# Git
ln -s $PWD/.gitconfig $HOME/.gitconfig

# Shell e terminal
ln -s $PWD/starship.toml $HOME/.config/starship.toml
ln -s $PWD/fish/config.fish $HOME/.config/fish/config.fish
ln -s $PWD/.bash_aliases $HOME/.bash_aliases

# Vim
ln -s $PWD/.vimrc $HOME/.vimrc
ln -s $PWD/plugin $HOME/.vim/plugin
ln -s $PWD/syntax $HOME/.vim/syntax
ln -s $PWD/neovim $HOME/.config/nvim
ln -s $PWD/vim-latex/tex.vim $HOME/.vim/plugged/vim-latex/ftplugin/tex.vim
