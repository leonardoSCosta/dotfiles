" Muda a leader key para ' '
let g:mapleader = " "

syntax enable              " Enables syntax highlighting

set noerrorbells

set hidden                 " Required to keep multiple buffers open multiple buffers
set nowrap                 " Display long lines as just one line
set encoding=utf-8         " The encoding displayed
set pumheight=10           " Makes pop-up menu smaller
set fileencoding=utf-8     " The encoding written to file
set ruler              	   " Show the cursor position all the time
set iskeyword+=-           " treat dash separated words as a word text object"
set mouse=a                " Enable your mouse

set splitbelow             " Horizontal splits will automatically be below
set splitright             " Vertical splits will automatically be to the right

set t_Co=256               " Support 256 colors
set conceallevel=0         " So that I can see `` in markdown files

set tabstop=4              " Insert 4 spaces for a tab
set softtabstop=4
set shiftwidth=4           " Change the number of space characters inserted for indentation
set smarttab               " Makes tabbing smarter
set expandtab              " Converts tabs to spaces

" set smartcase
" set ignorecase
set smartindent            " Makes indenting smart
set autoindent             " Good auto indent


set incsearch
set nohlsearch

set relativenumber " Ativa a numeração relativa das linhas
set nu  " Ativa a numeração das linhas

set noshowmode             " We don't need to see things like -- INSERT -- anymore

set noswapfile
set nobackup               " This is recommended by coc
set nowritebackup          " This is recommended by coc
set undodir=~/.vim/undodir
set undofile

"set scrolloff=8

set colorcolumn=80 " Configura a  coluna limite em 80 caracteres
set signcolumn=yes

set updatetime=50         " Faster completion
set timeoutlen=1000         " By default timeout Len is 1000 ms
set formatoptions-=cro     " Stop newline continuation of comments
set clipboard=unnamedplus  " Copy paste between Vim and everything else

autocmd FileType tex setlocal spell
autocmd FileType tex set spelllang=pt,en
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

autocmd FileType c inoremap {{ <Enter>{<Enter>}<Esc>O
autocmd FileType cpp inoremap {{ <Enter>{<Enter>}<Esc>O

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup LEONARDO
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
