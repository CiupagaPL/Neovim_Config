" Made By CiupagaPL
filetype on
filetype plugin on
filetype indent on
syntax on
set number
set relativenumber
set cursorline
set shiftwidth=2
set expandtab
set tabstop=2
set softtabstop=0
set nobackup
set nowrap
set incsearch
set ignorecase
set smartcase
set showcmd
set showmode
set showmatch
set hlsearch
set history=512
set wildmenu
set wildmode=list:longest
set noshowmode

nnoremap <space> :
nnoremap o o<esc>
nnoremap O O<esc>

call plug#begin("~/.vim/plugins")
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'romgrk/barbar.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'rcarriga/nvim-notify'
  Plug 'shaunsingh/nord.nvim'
  Plug 'neoclide/coc.nvim'
  Plug 'jiangmiao/auto-pairs'
  Plug 'terrortylor/nvim-comment'
  Plug 'MattesGroeger/vim-bookmarks'
  Plug 'sheerun/vim-polyglot'
  Plug 'farmergreg/vim-lastplace'
  Plug 'junegunn/goyo.vim'
  Plug 'itchyny/lightline.vim'
call plug#end()

let g:goyo_width = 175
let g:goyo_height = 50

nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <silent>    <C-a> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <C-d> <Cmd>BufferNext<CR>
nnoremap <silent>    <C-,> <Cmd>BufferMovePrevious<CR>
nnoremap <silent>    <C-.> <Cmd>BufferMoveNext<CR>
nnoremap <silent>    <C-q> <Cmd>BufferClose<CR>
nnoremap <C-l> :BookmarkToggle<CR>
nnoremap <C-;> :BookmarkNext<CR>
nnoremap <C-/> :BookmarkPrev<CR>
nnoremap <C-g> :Goyo<CR>
nnoremap <C-f> <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>lua require('telescope.builtin').find_files()<cr>

let g:lightline = {
  \ 'colorscheme': 'nord',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'readonly', 'filename', 'modified', 'cube' ] ],
  \   'right': [ [ 'lineinfo' ],
  \              [ 'percent' ],
  \              [ 'info', 'filetype' ] ]
  \ },
  \ 'component': {
  \   'cube': '[^^]',
  \   'info': 'nvim on void linux',
  \ },
  \ }

let g:NERDTreeFileLines = 1
let g:bookmark_sign = ''

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

lua << EOF
  require("ibl").setup()

  require('nvim_comment').setup({comment_empty = false})

  require("barbar").setup {
    animation = false,
  }

  require("notify").setup({
    icons = {
      ERROR = " ",
      WARN = " ",
      INFO = " ",
      DEBUG = " ",
      TRACE = " ✎",
    },
    render = "compact",
    stages = "static",
    timeout = 3000,
  })
EOF

colorscheme nord

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
  \ coc#pum#visible() ? coc#pum#next(1) :
  \ CheckBackspace() ? "\<Tab>" :
  \ coc#refresh()

