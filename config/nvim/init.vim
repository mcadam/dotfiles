call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'
Plug 'tomtom/tcomment_vim'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

let mapleader=','

syntax on
silent! color onedark

set history=1000

" Turn off vi compatibility
"   This should always be set by default anyway but some distros might muck it up.
set shellpipe=>
set nocompatible
set clipboard=unnamed
set completeopt-=preview
set modelines=3
set nobackup
set noshowmode
set noswapfile
set nowrap
set nowritebackup
set number
set shiftwidth=2
set tabstop=2
set termguicolors
set virtualedit=block
set selection=inclusive
set undofile   " Maintain undo history between sessions
set undodir=$HOME/.cache/vim/undo
set hidden     "allow buffer switching without saving
set autowrite


set list       "highlight whitespace
set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮

let &colorcolumn=80

" searching
set nohlsearch  "highlight searches
set incsearch   "incremental searching
set ignorecase  "ignore case for searching
set smartcase   "do case-sensitive if there's a capital letter

nnoremap <space>p :TagbarToggle<cr>

" format the entire file
nnoremap <leader>fef :normal! gg=G``<CR>

" Esc from insert mode
inoremap jj <esc>

" U: Redos since 'u' undos
nnoremap U <c-r>

" p: Paste
nnoremap p gp

" \: Toggle comment
nmap \ gcc

" \: Toggle comment
xmap \ gcc<esc>

" d: Delete into the blackhole register to not clobber the last yank
nnoremap d "_d

" dd: I use this often to yank a single line, retain its original behavior
nnoremap dd dd

" y: Yank and go to end of selection
xnoremap y y`]

" p: Paste in visual mode should not replace the default register with the
" deleted text
xnoremap p "_dP

" c: Change into the blackhole register to not clobber the last yank
nnoremap c "_c

" c: Change into the blackhole register to not clobber the last yank
nnoremap C "_C

" n: Next, keep search matches in the middle of the window
nnoremap n nzzzv

" <Leader>p: Toggle between paste mode
nnoremap <silent> <Leader>p :set paste!<cr>

" Tab navigation
map <leader>; :bnext<cr>
map <leader>l :bprev<cr>

map <C-c> <C-W>w

" <Leader>d: Delete the current buffer
nnoremap <Leader>d :bdelete<CR>

" save file
nnoremap <silent> <leader>w :silent w<cr>

" sane regex
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
nnoremap :s/ :s/\v

" golang
let g:go_fmt_command = "goimports"
" let g:go_metalinter_autosave = 1
let g:go_def_mode = 'godef'
" let g:go_list_type = "quickfix"

autocmd FileType go nmap <Leader>i <Plug>(go-info)

let $FZF_DEFAULT_OPTS = '--height 40% --color=dark --color=fg:-1,bg:-1,hl:#c678dd,fg+:#ffffff,bg+:#4b5263,hl+:#d858fe --color=info:#98c379,prompt:#61afef,pointer:#be5046,marker:#e5c07b,spinner:#61afef,header:#61afef'
nnoremap <silent> <space><space> :Files<cr>
nnoremap <silent> <space>f :BTags<cr>
nnoremap <silent> <space>t :Tags<cr>
nnoremap <silent> <space>h :History<cr>
nnoremap <space>/ :Rg<space>

command! -bang -nargs=* Rg
			\ call fzf#vim#grep(
			\   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
			\   fzf#vim#with_preview(), <bang>0)

if has('nvim') && !exists('g:fzf_layout')
	autocmd! FileType fzf
	autocmd  FileType fzf set laststatus=0 noshowmode noruler
				\| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
endif

" arrows
function! s:MoveLineUp()
  call <SID>MoveLineOrVisualUp(".", "")
endfunction

function! s:MoveLineDown()
  call <SID>MoveLineOrVisualDown(".", "")
endfunction

function! s:MoveVisualUp()
  call <SID>MoveLineOrVisualUp("'<", "'<,'>")
  normal gv
endfunction

function! s:MoveVisualDown()
  call <SID>MoveLineOrVisualDown("'>", "'<,'>")
  normal gv
endfunction

function! s:MoveLineOrVisualUp(line_getter, range)
  let l_num = line(a:line_getter)
  if l_num - v:count1 - 1 < 0
    let move_arg = "0"
  else
    let move_arg = a:line_getter." -".(v:count1 + 1)
  endif
  call <SID>MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
endfunction

function! s:MoveLineOrVisualDown(line_getter, range)
  let l_num = line(a:line_getter)
  if l_num + v:count1 > line("$")
    let move_arg = "$"
  else
    let move_arg = a:line_getter." +".v:count1
  endif
  call <SID>MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
endfunction

function! s:MoveLineOrVisualUpOrDown(move_arg)
  let col_num = virtcol(".")
  execute "silent! ".a:move_arg
  execute "normal! ".col_num."|"
endfunction

" Arrow key remapping:
" Up/Dn = move line up/dn
" Left/Right = indent/unindent

" Normal mode
nnoremap <silent> <Left>   <<
nnoremap <silent> <Right>  >>
nnoremap <silent> <Up>     <Esc>:call <SID>MoveLineUp()<CR>
nnoremap <silent> <Down>   <Esc>:call <SID>MoveLineDown()<CR>

" Visual mode
vnoremap <silent> <Left>   <gv
vnoremap <silent> <Right>  >gv
vnoremap <silent> <Up>     <Esc>:call <SID>MoveVisualUp()<CR>
vnoremap <silent> <Down>   <Esc>:call <SID>MoveVisualDown()<CR>

function! s:StripWhiteSpaces()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  silent! undojoin
  :%s/\s\+$//e

  silent! undojoin
  :%s#\($\n\s*\)\+\%$##e

  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction

autocmd BufWritePre * StripWhiteSpace
command! -range=% StripWhiteSpaces :silent call <SID>StripWhiteSpaces()
