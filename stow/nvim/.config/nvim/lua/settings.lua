-- Basic NVim Settings

if vim.fn.has('termguicolors') == 1 then
    vim.opt.termguicolors = true
end

-- Basic UI tinkering
vim.cmd('filetype plugin indent on')
vim.cmd('syntax enable')

-- Visual adjustments & ease-of-use
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.encoding = 'utf8'
vim.opt.errorbells = false
vim.opt.scrolloff = 10
vim.opt.signcolumn = 'yes'
vim.opt.hidden = true
vim.opt.timeoutlen = 500
vim.opt.showmode = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 100

-- Tabs
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- line wrapping & folding
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.opt.showbreak='+++ '
vim.opt.formatoptions:append('n')
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'


-- Open new split panes to right and below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Colorscheme options
vim.opt.background = 'dark'
vim.g.gruvbox_italic = 1
vim.g.gruvbox_contrast_dark = 'hard'
vim.cmd('colorscheme gruvbox')
