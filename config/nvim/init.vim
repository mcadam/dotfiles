" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-slash'
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-fnr'
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
" Plug 'easymotion/vim-easymotion'
Plug 'jiangmiao/auto-pairs'
Plug 'dense-analysis/ale'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries' }
Plug 'mhinz/vim-startify'

call plug#end()

let mapleader=' '

syntax on
color one
let g:one_allow_italics = 1
if strftime('%H') >= 7 && strftime('%H') < 17
  set background=light
else
  set background=dark
endif

set ttyfast
set backspace=indent,eol,start
set history=1000
set ruler         " show the cursor position all the time
set clipboard=unnamed
set completeopt-=preview
set modelines=3
set nobackup
set noshowmode
set noshowcmd
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
set list       "highlight whitespace
set listchars=tab:│\ ,trail:•,extends:❯,precedes:❮

" Esc from insert mode
inoremap jj <esc>

" U: Redos since 'u' undos
nnoremap U <c-r>

" p: Paste
nnoremap p gp

" Toggle comment
nmap \ gcc
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

" Toggle paste mode
nnoremap <silent> <leader>p :set paste! number! list!<cr>

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


" search
if has('timers')
  " Blink 2 times with 50ms interval
  noremap <expr> <plug>(slash-after) 'zz'.slash#blink(2, 100)
endif

" golang
let g:go_fmt_command = "goimports"
" let g:go_metalinter_autosave = 1
" let g:go_list_type = "quickfix"

autocmd FileType go nmap <leader>i <Plug>(go-info)

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

command! Ctrlp execute (len(system('git rev-parse'))) ? ':Files' : ':GFiles'
nnoremap <silent> <leader><space> :Ctrlp<cr>
nnoremap <silent> <leader>f :BTags<cr>
nnoremap <silent> <leader>t :Tags<cr>
nnoremap <silent> <leader>h :History<cr>
nnoremap <leader>/ :Rg<space>

" Rg command search with preview
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview(), <bang>0)

if has('nvim') && !exists('g:fzf_layout')
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noruler
        \| autocmd BufLeave <buffer> set laststatus=2 ruler
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

" Status Function
function! Status(winnr)
  let stat = '%='
  let active = winnr() == a:winnr
  let buffer = winbufnr(a:winnr)

  let modified = getbufvar(buffer, '&modified')
  let readonly = getbufvar(buffer, '&ro')
  let fname = bufname(buffer)

  function! Color(active, num, content)
    if a:active
      return '%' . a:num . '*' . a:content . '%*'
    else
      return a:content
    endif
  endfunction

  " syntastic warning
  " let stat .= Color(active, 5, '%{validator#get_status_string()}     ')

  " percent file context
  " let stat .= '%2*' . (col(".") / 100 >= 1 ? '  %p%% ' : '   %2p%% ') . '%*'

  " paste
  if active && &paste
    let stat .= ' %2*' . '' . '%*'
  endif

  " file name
  if readonly
    let stat .= Color(active, 5, '   פּ  %f')
  elseif modified
    let stat .= Color(active, 3, '   פּ  %f')
  else
    let stat .= '   פּ  %f'
  endif
  return stat
endfunction


" Status AutoCMD
function! SetStatus()
  for nr in range(1, winnr('$'))
    call setwinvar(nr, '&statusline', '%!Status('.nr.')')
  endfor
endfunction

augroup status
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter,BufUnload * call SetStatus()
augroup END

hi StatusLine ctermbg=none guibg=none
hi User1 ctermfg=0  guifg=#5daef2 ctermbg=none guibg=none gui=bold
hi User2 ctermfg=125 guifg=#5D636F  ctermbg=none  guibg=none gui=bold
hi User3 ctermfg=64  guifg=#d19a66  ctermbg=none  guibg=none gui=bold
hi User4 ctermfg=37  guifg=#5daef2  ctermbg=none  guibg=none gui=bold
hi User5 ctermfg=1  guifg=#e06c75  ctermbg=none  guibg=none gui=bold
