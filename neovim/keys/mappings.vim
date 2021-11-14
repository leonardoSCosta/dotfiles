" Usar alt + hjkl para redimensionar as janelas
nnoremap <M-j>    :resize +2<CR>
nnoremap <M-k>    :resize -2<CR>
nnoremap <M-h>    :vertical resize +2<CR>
nnoremap <M-l>    :vertical resize -2<CR>

" Utiliza jk para sair do insert mode e já salvar automaticamente
imap jk <Esc><Leader>w

" Use control-c instead of escape
nnoremap <C-c> <Esc>
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Usar Q para formatar o parágrafo
vnoremap Q gq
nnoremap Q gqap

" Salvar mais rápido
nnoremap <leader>w :w<CR>

" Contar número de palavras no parágrafo
nnoremap <leader>tc vipg<C-g><Esc>

" Usar o ripgrep na palavra sob o cursor
nnoremap <leader>rg yiw:Rg <C-r>"<CR>
