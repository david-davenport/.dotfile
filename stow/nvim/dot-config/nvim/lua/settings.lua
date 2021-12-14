local o = vim.o -- global option
local wo = vim.wo -- window option
local bo = vim.bo -- buffer option


wo.number = true
wo.rnu = true
o.encoding = utf8
-- tabs
bo.expandtab = true
bo.shiftwidth = 2
bo.tabstop = 2
bo.softtabstop = 2
bo.autoindent = true
bo.smartindent = true
-- line wrapping
wo.wrap = true -- Wrap lines
wo.linebreak = true
wo.textwidth = 0
wo.wrapmargin = 0
wo.showbreak = +++\ 
set fo-=t
set fo+=n
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

set nolist
set noerrorbells
set scrolloff=10
set signcolumn=yes
set hidden

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
