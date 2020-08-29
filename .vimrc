call plug#begin('~/.vim/plugged')

" Plugins de temas de cor
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'itchyny/lightline.vim'
Plug 'chrisbra/colorizer'

" Plugins para a barra de status
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plugins de navegação
Plug 'justinmk/vim-sneak'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

" Plugins para LaTeX
Plug 'vim-latex/vim-latex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Plugin para comentar as linhas
Plug 'preservim/nerdcommenter'

" Outros
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'
"Plug 'git@github.com:ycm-core/YouCompleteMe.git'
Plug 'mbbill/undotree'

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

" Configura o plugin sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
"highlight Sneak ctermfg=255 ctermbg=20 guifg=20 guibg=#00C7DF 
"highlight SneakScope ctermfg=255 ctermbg=20 guifg=20 guibg=#00C7DF 
"highlight SneakLabel ctermfg=255 ctermbg=20 guifg=20 guibg=#00C7DF 

" Configuração do airline
let g:airline_theme='deus'

let g:airline_detect_spelllang = 1
let g:airline_powerline_fonts = 1
let g:airline_section_y = ''

let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#fzf#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.spell = '📖'
let g:airline_symbols.branch = ''

set laststatus=2

" Configuração do esquema de cores
set background=dark
colorscheme gruvbox

" Customização do tema dracula
let g:dracula#palette.fg        = ['#FFFFFF',  61]
let g:dracula#palette.purple    = ['#855AF9', 141]
let g:dracula#palette.color_4   =  '#855AF9'
"let g:dracula#palette.comment   = ['#54F4EC',  61]
"let g:dracula#palette.bg        = ['#00264D', 236]
"let g:dracula_colorterm = 1

set termguicolors

let g:colorizer_auto_filetype='cpp,h,vim,tex,markdown'

if executable('rg')
    let g:rg_derive_root='true'
endif

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

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
