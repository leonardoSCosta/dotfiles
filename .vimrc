call plug#begin('~/.vim/plugged')

" Plugins de temas de cor
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'itchyny/lightline.vim'

" Plugins de navegação
Plug 'justinmk/vim-sneak'
"Plug 'git@github.com:kien/ctrlp.vim.git'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

" Plugins para LaTeX
Plug 'vim-latex/vim-latex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Outros
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'
"Plug 'git@github.com:ycm-core/YouCompleteMe.git'
Plug 'mbbill/undotree'
Plug 'preservim/nerdcommenter'

call plug#end()

" Configura a  coluna limite em 80 caracteres
set colorcolumn=80

" Configura o FZF
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
" Atalho para dar checkout no repositório atual
nnoremap <leader>gc :GCheckout<CR>
" Atalho para abrir o FZF
nnoremap <C-p> :FZF<Enter>

" Configuração do esquema de cores
set background=dark
colorscheme gruvbox
syntax on

" Configura o plugin sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
highlight Sneak ctermfg=255 ctermbg=20 guifg=20 guibg=#00C7DF 
highlight SneakScope ctermfg=255 ctermbg=20 guifg=20 guibg=#00C7DF 
highlight SneakLabel ctermfg=255 ctermbg=20 guifg=20 guibg=#00C7DF 


let g:lightline = {
    \ 'colorscheme': 'deus',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'FugitiveHead'
    \ },
    \ }

set laststatus=2

if executable('rg')
    let g:rg_derive_root='true'
endif

let g:netrw_browse_split=2
let g:netrw_banner = 0
let g:netrw_winsize = 25

"let g:ctrlp_use_caching = 0

" Configura o plugin do LaTeX
filetype plugin on
filetype indent on 
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:livepreview_previewer = 'evince'
let g:Tex_FoldedSections=""
let g:Tex_FoldedEnvironments=""
let g:Tex_FoldedMusic=""
let g:Tex_MultipleCompileFormats='pdf'
let g:Tex_AdvancedMath = 1
" Mudar para 'biber' caso for compilar utilizando ele
let g:Tex_BibtexFlavor = 'bibtex'

set winaltkeys=no

" Configura o YouCompleteMe
"let g:ycm_use_clangd = 0
"let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
"let g:ycm_add_preview_to_completeopt = 1
"let g:ycm_autoclose_preview_window_after_insertion = 1
"let g:ycm_autoclose_preview_window_after_completion = 1

