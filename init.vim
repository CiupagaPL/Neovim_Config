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
set statusline=
set statusline+=\ [^^]\ %F\ Nvim\ on\ Void\ Linux
set statusline+=%=
set statusline+=\ row:\ %l\ col:\ %c\ percent:\ %p%%
set laststatus=2

nnoremap <space> :
nnoremap o o<esc>
nnoremap O O<esc>

call plug#begin("~/.vim/plugins")
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'norcalli/nvim-colorizer.lua'
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
call plug#end()

nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-y> :ColorizerToggle<CR>
nnoremap <silent>    <C-a> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <C-d> <Cmd>BufferNext<CR>
nnoremap <silent>    <C-,> <Cmd>BufferMovePrevious<CR>
nnoremap <silent>    <C-.> <Cmd>BufferMoveNext<CR>
nnoremap <silent>    <C-p> <Cmd>BufferPin<CR>
nnoremap <silent>    <C-q> <Cmd>BufferClose<CR>
nnoremap <C-g> :BookmarkToggle<CR>
nnoremap <C-h> :BookmarkNext<CR>
nnoremap <C-f> <cmd>Telescope find_files<cr>
nnoremap <C-f> <cmd>lua require('telescope.builtin').find_files()<cr>

autocmd VimEnter * NERDTree
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
  \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif
let g:NERDTreeFileLines = 1

highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_sign = ''
let g:bookmark_highlight_lines = 1

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

  require("notify")("Simple text here.")
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

