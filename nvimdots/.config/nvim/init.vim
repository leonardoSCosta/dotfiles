set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
source $HOME/.config/nvim/general/settings.vim
source $HOME/.config/nvim/keys/mappings.vim
source $HOME/.config/nvim/plug-config/coc.vim
source $HOME/.config/nvim/plug-config/rainbow.vim
source $HOME/.config/nvim/plug-config/nerdcommenter.vim
source $HOME/.config/nvim/plug-config/asciidoctor.vim
source $HOME/.config/nvim/plug-config/semshi.vim
source $HOME/.config/nvim/plug-config/ultisnips.vim

if exists("g:neovide") == 0
highlight Normal guibg=NONE
endif
