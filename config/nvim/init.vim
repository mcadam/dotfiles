" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'
Plug 'hrsh7th/nvim-cmp', { 'branch': 'dev' }
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'onsails/lspkind-nvim'
Plug 'navarasu/onedark.nvim'
Plug 'olimorris/onedarkpro.nvim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/vim-slash'
Plug 'junegunn/vim-pseudocl'
Plug 'junegunn/vim-fnr'
Plug 'editorconfig/editorconfig-vim'
Plug 'sheerun/vim-polyglot'
Plug 'rakr/vim-one'
Plug 'windwp/nvim-autopairs'
Plug 'honza/vim-snippets'
Plug 'rafamadriz/friendly-snippets'
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries' }
Plug 'mhinz/vim-startify'
Plug 'terryma/vim-expand-region'
Plug 'phaazon/hop.nvim'


call plug#end()

let mapleader=' '

syntax on
" color onedarkpro
let g:one_allow_italics = 1
if strftime('%H') >= 7 && strftime('%H') < 18
  set background=light
else
  set background=dark
endif

set ttyfast
set backspace=indent,eol,start
set history=1000
set ruler         " show the cursor position all the time
set clipboard=unnamed
set completeopt=menu,menuone,noselect
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
set mouse-=a

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
nnoremap <silent> <leader><space> :Telescope find_files<cr>
nnoremap <silent> <leader>f :Telescope lsp_document_symbols<cr>
nnoremap <silent> <leader>t :Telescope diagnostics<cr>
nnoremap <silent> <leader>h :Telescope search_history<cr>
nnoremap <leader>/ :Telescope live_grep<cr>

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
    let stat .= ' %1*' . '' . '%*'
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


lua << EOF

  require('telescope').load_extension('fzf')
  require('gitsigns').setup()
  require('nvim-autopairs').setup{}

  require 'telescope-config'
  local actions = require("telescope.actions")
  require("telescope").setup{
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close
        },
      },
    }
  }

  vim.api.nvim_set_keymap("n", "<Leader><Space>", "<CMD>lua require'telescope-config'.project_files()<CR>", {noremap = true, silent = true})

  require('hop').setup({
    case_insensitive = true,
    char2_fallback_key = '<CR>',
  })

  vim.api.nvim_set_keymap('n', 'f', "<cmd>lua require'hop'.hint_char2()<cr>", {noremap = true})
  vim.api.nvim_set_keymap('n', 'F', "<cmd>lua require'hop'.hint_words()<cr>", {noremap = true})

  local onedarkpro = require("onedarkpro")
  onedarkpro.setup({
    hlgroups = {
      User1 = { fg = "#5daef2", bg = "none", style = "bold" },
      User2 = { fg = "#5D636F", bg = "none", style = "bold" },
      User3 = { fg = "#d19a66", bg = "none", style = "bold" },
      User4 = { fg = "#5daef2", bg = "none", style = "bold" },
      User5 = { fg = "#e06c75", bg = "none", style = "bold" }
    },
    styles = {
      strings = "NONE", -- Style that is applied to strings
      comments = "italic", -- Style that is applied to comments
      keywords = "NONE", -- Style that is applied to keywords
      functions = "NONE", -- Style that is applied to functions
      variables = "NONE", -- Style that is applied to variables
    },
    options = {
      bold = true, -- Use the themes opinionated bold styles?
      italic = true, -- Use the themes opinionated italic styles?
      underline = true, -- Use the themes opinionated underline styles?
      undercurl = true, -- Use the themes opinionated undercurl styles?
      cursorline = true, -- Use cursorline highlighting?
      transparency = false, -- Use a transparent background?
      terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
      window_unfocussed_color = true, -- When the window is out of focus, change the normal background?
    }
  })
  onedarkpro.load()

  local lsp_installer = require("nvim-lsp-installer")

  -- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
  -- or if the server is already installed).
  lsp_installer.on_server_ready(function(server)
      local opts = {}

      -- (optional) Customize the options passed to the server
      -- if server.name == "tsserver" then
      --     opts.root_dir = function() ... end
      -- end

      -- This setup() function will take the provided server configuration and decorate it with the necessary properties
      -- before passing it onwards to lspconfig.
      -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
      opts.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      server:setup(opts)
  end)


  -- Setup nvim-cmp.
  local cmp = require'cmp'

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      completion = {
        border = 'rounded',
        scrollbar = '║',
      },
      documentation = {
        border = 'rounded',
        scrollbar = '║',
      },
    },
    formatting = {
      format = require("lspkind").cmp_format()
    },
    mapping = {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end, { "i", "s" }),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  local cmp_autopairs = require('nvim-autopairs.completion.cmp')

  cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

  -- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
  cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"

EOF
