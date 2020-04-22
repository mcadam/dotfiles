" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()

Plug '~/.fzf'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-slash'
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-fnr'
Plug 'junegunn/goyo.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries' }

call plug#end()

let mapleader=' '

syntax on
color onedark

set ttyfast
set ttimeout
set ttimeoutlen=10
set backspace=indent,eol,start
set history=1000
set laststatus=2  " Always display the status line
set statusline=%=%m\ %P\ %f
set ruler         " show the cursor position all the time
set clipboard=unnamed
set completeopt-=preview
set modelines=3
set nobackup
set noshowmode
set noswapfile
set nowrap
set nowritebackup
set number
set shiftwidth=4
set tabstop=4
set termguicolors
set virtualedit=block
set selection=inclusive
set undofile   " Maintain undo history between sessions
set undodir=$HOME/.cache/vim/undo
set hidden     "allow buffer switching without saving
set autowrite
set nohlsearch  "highlight searches
set incsearch   "incremental searching
set ignorecase  "ignore case for searching
set smartcase   "do case-sensitive if there's a capital letter

" Tagbar toggle
nnoremap <leader>p :TagbarToggle<cr>

" Esc from insert mode
inoremap jj <esc>

" U: Redos since 'u' undos
nnoremap U <c-r>

" Toggle comment
nmap \ gcc
xmap \ gcc<esc>

" Toggle paste mode
nnoremap <silent> <leader>p :set paste!<cr>

" Tab navigation
map <Tab> :bnext<cr>
map <S-Tab> :bprev<cr>

" Change pane
map <C-c> <C-W>w

" Delete
nnoremap <leader>d :bdelete<CR>

" Save
nnoremap <silent> <leader>w :silent w<cr>

" Quit
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :qa!<cr>


" golang
let g:go_fmt_command = "goimports"
" let g:go_metalinter_autosave = 1
let g:go_def_mode = 'godef'
" let g:go_list_type = "quickfix"

autocmd FileType go nmap <leader>i <Plug>(go-info)

let $FZF_DEFAULT_OPTS = '--height 40% --color=dark --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe --color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef'
nnoremap <silent> <leader><space> :Files<cr>
nnoremap <silent> <leader>f :BTags<cr>
nnoremap <silent> <leader>t :Tags<cr>
nnoremap <silent> <leader>h :History<cr>
nnoremap <leader>/ :Rg<space>

command! -bang -nargs=* Rg
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
			\   fzf#vim#with_preview(), <bang>0)

if has('nvim') && !exists('g:fzf_layout')
	autocmd! FileType fzf
	autocmd  FileType fzf set laststatus=0 noshowmode noruler
				\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endif

" Arrow key remapping:
" Up/Dn = move line up/dn
" Left/Right = indent/unindent

" Normal mode
nmap <silent> <Left>   <<
nmap <silent> <Right>  >>
nmap <silent> <Up>     [e
nmap <silent> <Down>   ]e

" Visual mode
vmap <silent> <Left>   <gv
vmap <silent> <Right>  >gv
vmap <silent> <Up>     [egv
vmap <silent> <Down>   ]egv
