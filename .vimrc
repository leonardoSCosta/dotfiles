" Instalar o gerenciador de plugins automaticamente caso ainda não esteja
" instalado
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if empty(glob('~/.config/nvim'))
    silent !mkdir ~/.config/nvim; touch ~/.config/nvim/init.vim
endif

call plug#begin('~/.vim/plugged')

" Plugins de temas de cor
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'arcticicestudio/nord-vim'
"Plug 'itchyny/lightline.vim'
Plug 'chrisbra/colorizer'
Plug 'junegunn/rainbow_parentheses.vim'

" Plugins para a barra de status
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plugins de navegação
Plug 'justinmk/vim-sneak'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'jremmen/vim-ripgrep'

" Plugins para LaTeX
Plug 'vim-latex/vim-latex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Asciidoctor
Plug 'habamax/vim-asciidoctor'

" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Plugin para comentar as linhas
Plug 'preservim/nerdcommenter'

" Git
Plug 'airblade/vim-gitgutter'
" <leader> hp/hu/hs para visualizar/desfazer/salvar as modificações
" :GitGutterEnable/Disable para habilitar/desabilitar

" Outros
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'
Plug 'mbbill/undotree'

call plug#end()


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

" Configuração do airline
let g:airline_theme='dracula'

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
let g:airline_right_sep = ''
let g:airline_symbols.spell = '暈'
let g:airline_symbols.branch = ' '
let g:airline#extensions#coc#warning_symbol = ' '
let g:airline#extensions#coc#error_symbol = '碌'

set laststatus=2

" Configuração do esquema de cores
set background=dark
colorscheme dracula

if g:colors_name == 'nord'
    let g:nord_bold_vertical_split_line=1
    let g:nord_italic=1
    let g:nord_italic_comments=1
    let g:nord_uniform_diff_background = 1
endif

" Customização do tema dracula
if g:colors_name == 'dracula'
    "let g:dracula#palette.bg        = ['#282A36FA',  61]
    "let g:dracula#palette.purple    = ['#855AF9', 141]
    "let g:dracula#palette.color_4   =  '#855AF9'
endif

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
let g:livepreview_previewer = 'zathura'
let g:Tex_CustomTemplateDirectory = '~/.config/nvim/plug-config/TemplatesLatex/,~/.vim/plugged/vim-latex/ftplugin/latex-suite/templates/'
let g:Tex_FoldedSections=""
let g:Tex_FoldedEnvironments=""
let g:Tex_FoldedMusic=""
let g:Tex_MultipleCompileFormats='pdf'
let g:Tex_AdvancedMath = 1
let g:Tex_UseMakefile = 0
" Mudar para 'biber' caso for compilar utilizando ele
"let g:Tex_BibtexFlavor = 'biber'
let g:Tex_BibtexFlavor = 'bibtex'

set winaltkeys=no
