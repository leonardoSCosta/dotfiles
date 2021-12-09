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
Plug 'dracula/vim', { 'as': 'dracula' }
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
" Plug 'vim-latex/vim-latex'
Plug 'lervag/vimtex'
" Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Asciidoctor
Plug 'habamax/vim-asciidoctor'

" Snippets
Plug 'sirver/ultisnips'

" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'dag/vim-fish'
Plug 'vim-syntastic/syntastic'

" Plugin para comentar as linhas
Plug 'preservim/nerdcommenter'

" Git
Plug 'airblade/vim-gitgutter'
" <leader> hp/hu/hs para visualizar/desfazer/salvar as modificações
" :GitGutterEnable/Disable para habilitar/desabilitar

" Outros
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'

call plug#end()


" Configura o FZF
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'
" Atalho para dar checkout no repositório atual
nnoremap <C-c>b :GBranches<CR>
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
" Remove o contador de linhas em formato de porcentagem
" Original = '%p%% %#__accent_bold#%{g:airline_symbols.linenr}%l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__#:%v'
let g:airline_section_z = '%#__accent_bold#%{g:airline_symbols.linenr}%l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__#:%v'
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#fzf#enabled = 1
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#syntastic#enabled = 0

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols.spell = ''
let g:airline_symbols.branch = ' '
let g:airline_symbols.readonly = ' '
let g:airline_symbols.linenr = ' '
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'
let g:airline#extensions#coc#warning_symbol = ' '
let g:airline#extensions#coc#error_symbol = ' '
let g:airline_symbols.notexists = 'Ɇ'

set laststatus=1

" Configuração do esquema de cores
set background=dark
colorscheme dracula

if g:colors_name == 'nord'
    let g:nord_bold_vertical_split_line=1
    let g:nord_italic=1
    let g:nord_italic_comments=1
    let g:nord_uniform_diff_background = 1
endif

set termguicolors

let g:colorizer_auto_filetype='cpp,h,vim,tex,markdown,dosini'

if executable('rg')
    let g:rg_derive_root='true'
endif

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

" Configura o plugin do LaTeX
filetype plugin on
filetype indent on
set conceallevel=2
let g:tex_flavor='latex'
" let g:Tex_DefaultTargetFormat='pdf'
" let g:livepreview_previewer = 'zathura'
" let g:Tex_CustomTemplateDirectory = '~/.config/nvim/plug-config/TemplatesLatex/,~/.vim/plugged/vim-latex/ftplugin/latex-suite/templates/'
" let g:Tex_FoldedSections=""
" let g:Tex_FoldedEnvironments=""
" let g:Tex_FoldedMusic=""
" let g:Tex_MultipleCompileFormats='pdf'
" let g:Tex_AdvancedMath = 1
" let g:Tex_UseMakefile = 0
" Mudar para 'biber' caso for compilar utilizando ele
" let g:Tex_BibtexFlavor = 'biber'
" let g:Tex_BibtexFlavor = 'bibtex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0

if empty(v:servername) && exists('*remote_startserver')
  call remote_startserver('VIM')
endif

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_loc_list_height = 3

" let g:syntastic_quiet_messages = {
"     \ "!level":  "warnings",
"     \ "type":    "style",
"     \ "regex":   '\ccommand terminated',
"     \ "file:p":  ['\m\c\.tex$'] }

" C, C++, etc LSP
let g:lsp_cxx_hl_use_text_props = 1

set winaltkeys=no
