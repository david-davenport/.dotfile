set nocompatible

" AUTO COMMANDS
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }


augroup md_to_markdown
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
augroup END

" turn off relative numbers when in INSERT mode
augroup numbertoggle "{
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END "}

if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif

" Create scratch buffer
function! s:ScratchBuffer()
    noswapfile hide enew
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal nobuflisted
    file scratch
endfunction
command! ScratchBuffer call s:ScratchBuffer()

" Add char to end of line
function! s:AppendCharToEndOfLine()
    let c = getchar()
    if c =~  '^\d\+$'
        let c = nr2char(c)
    endif
    execute ':normal! A' . c
    "setline('.', getline('.') . c)
endfunction
command! AppendCharToEndOfLine call s:AppendCharToEndOfLine()

" Zoom windows
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()

" TODO: move this to a function and turn it on only for `ft != 'dashboard'
" highlight traling whitespace
match ErrorMsg '\s\+$'

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/vim/plugged')

" useful additions
" Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-commentary'

" Code reviews
Plug 'pwntester/octo.nvim'

" making things a little easier to work with
Plug 'junegunn/vim-peekaboo'
Plug 'folke/which-key.nvim'
Plug 'norcalli/nvim-colorizer.lua'

" making things look nice
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-signify'
Plug 'folke/todo-comments.nvim'

" focus for prose
" Plug 'junegunn/goyo.vim'
" Plug 'junegunn/limelight.vim'
Plug 'folke/zen-mode.nvim'
Plug 'folke/twilight.nvim'

" colorschemes
Plug 'dguo/blood-moon', {'rtp': 'applications/vim'}
Plug 'rktjmp/lush.nvim'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'logico/typewriter-vim'

" treesitter/LSP packages and other extras
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'
Plug 'onsails/lspkind-nvim'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-neorg/neorg'

" Completions
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp'

call plug#end()

" set up color schemes
if (has("termguicolors"))
	set termguicolors
endif

" Basic UI tinkering
filetype plugin indent on
syntax enable

set number
set rnu
set encoding=utf8
" tabs
set expandtab
set shiftwidth=4
set tabstop=4
set autoindent
set smartindent
" line wrapping
set wrap "Wrap lines
set linebreak
set nolist
set textwidth=0
set wrapmargin=0
set showbreak=+++\
set fo-=t
set fo+=n
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

set noerrorbells
set scrolloff=10
set signcolumn=yes
set hidden
set timeoutlen=500

"statusline
"set statusline=%<\ %n:%f\ \ %m%r%y%=%-35.(line:\ %l\ of\ %L\ col:\ %c%V\ (%P)%)
set noshowmode

set updatetime=100
set background=dark
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox

" open new split panes to right and below
set splitright
set splitbelow

" undo/redo


" Key Maps

"" Set leader keys
let mapleader = ","

""""""""""""""""""""""""
" Useful maps
"""""""""""""""""""""""""

nnoremap <leader>rtw :%s/\s\+$//e<CR>
nnoremap <silent><leader>, :AppendCharToEndOfLine<CR>
nnoremap <leader>s :ScratchBuffer<CR>
nnoremap <leader>z :ZoomToggle<CR>

" capitalize word
noremap <leader><c-u> viwUe
inoremap <leader><c-u> <esc>viwUea
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>

" edit my vimrc/init.vim
nnoremap <leader>sv :split $MYVIMRC<CR>
nnoremap <leader>ev :edit $MYVIMRC<CR>

" Remap <ESC> for easier exit from INSERT mode
inoremap jk <ESC>

" Use dot repetition in visual mode
vnoremap . :norm.<CR>

" move lines
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" inoremap <C-j> <ESC>:m .+1<CR>==
" inoremap <C-K> <ESC>:m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==

" Map <C-L> (redraw screen) to also turn off search highlighting until the
nnoremap <C-L> :nohl<CR><C-L>
nnoremap <silent> <ESC><ESC> :noh<CR>

" Run ack against the visually selected text
nmap <Leader>A vaw"ay:Ack <C-R>a

" Search
noremap ;; :%s:::g<Left><Left><Left>
noremap ;' :%s:::gc<Left><Left><Left><Left>


" Select previously pasted text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

" Reload vimrc
nnoremap <leader>r :source $MYVIMRC<cr>

" Maps for Telescope
" Using Lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fm <cmd>lua require('telescope.builtin').marks()<cr>

""" Maps for LSP functions {{{
" NOT WORKING
"nnoremap <silent>K :Lspsaga hover_doc<CR>
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" scroll up hover doc
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
" }}}

lua require'colorizer'.setup()

let g:mapleader="\<Space>"
let g:dashboard_default_executive ='telescope'
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>

" clipboard using win32yank.exe
let g:clipboard = {
            \ 'name': 'win32yank-wsl',
            \ 'copy': {
                \ '+': 'win32yank.exe -i --crlf',
                \ '*': 'win32yank.exe -i --crlf',
                \ },
            \ 'paste': {
                \ '+': 'win32yank.exe -o --lf',
                \ '*': 'win32yank.exe -o --lf',
                \ },
                \ 'cache-enabled': 0,
                \ }

lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

-- Enable completion triggered by <c-x><c-o>
buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
local opts = { noremap=true, silent=true }

-- See `:help vim.lsp.*` for documentation on any of the below functions
buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'vimls', 'phpactor', 'vuels', 'tsserver', 'rust_analyzer'}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
            }
        }
end
EOF
lua << EOF
    require('neorg').setup {
        -- Tell Neorg what modules to load
        load = {
            ["core.defaults"] = {}, -- Load all the default modules
            ["core.norg.concealer"] = {}, -- Allows for use of icons
            ["core.norg.dirman"] = { -- Manage your directories with Neorg
                config = {
                    workspaces = {
                        my_workspace = "~/neorg",
                        reports = "~/work/qsrsoft/reports/notes"
                    }
                }
            }
        },
    }
    local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

    require('nvim-treesitter.configs').setup {
        ensure_installed = { "vim", "norg", "vue", "javascript", "json", "html", "css", "php", "rust", "lua" },
        highlight = {
            enabled = true
        },
        indent = {
            enable = true
        }
    }
EOF
