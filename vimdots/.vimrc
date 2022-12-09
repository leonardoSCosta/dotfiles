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
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'chrisbra/colorizer'
Plug 'junegunn/rainbow_parentheses.vim'

" Plugins para a barra de status
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plugins de navegação
Plug 'justinmk/vim-sneak'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
" Plug 'stsewd/fzf-checkout.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
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
Plug 'octol/vim-cpp-enhanced-highlight'

" Plugin para comentar as linhas
Plug 'preservim/nerdcommenter'

" Git
Plug 'airblade/vim-gitgutter'
" <leader> hp/hu/hs para visualizar/desfazer/salvar as modificações
" :GitGutterEnable/Disable para habilitar/desabilitar

" Outros
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'andweeb/presence.nvim'

call plug#end()


" Configura o FZF
" let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
" let $FZF_DEFAULT_OPTS='--reverse'
" Atalho para abrir o FZF
" nnoremap <C-p> :FZF<Enter>
" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Configura o Telescope
" Atalho para dar checkout no repositório atual
nnoremap <C-c>b <cmd>Telescope git_branches<cr>
nnoremap <C-p> <cmd>Telescope find_files hidden=true follow=true<cr>

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

" Example config in VimScript
let g:tokyonight_style = "night"
let g:tokyonight_italic_functions = 1
let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]

" Change the "hint" color to the "orange" color, and make the "error" color bright red
let g:tokyonight_colors = {
  \ 'hint': 'orange',
  \ 'error': '#ff0000'
\ }

" Configuração do esquema de cores
set background=dark
colorscheme dracula
" colorscheme tokyonight

set termguicolors

let g:colorizer_auto_filetype='cpp,h,vim,tex,markdown,dosini,c'

if executable('rg')
    let g:rg_derive_root='true'
endif

let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/plug-config/Snippets']

let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

" Configura o plugin do LaTeX
" filetype plugin on
" filetype indent on
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
" let g:vimtex_view_general_viewer = 'okular'
" let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
" let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_quickfix_mode=0
let g:tex_conceal='abdmg'

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

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1

" Neovim Presence
let g:presence_auto_update         = 1
let g:presence_buttons             = 0
let g:presence_enable_line_number  = 1
" Rich Presence text options
let g:presence_editing_text        = "Editing %s"
let g:presence_line_number_text    = "Line %s out of %s"

set winaltkeys=no
