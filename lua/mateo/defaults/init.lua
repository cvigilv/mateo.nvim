vim.g.mapleader = ","

-- General configuration
vim.opt.clipboard      = "unnamedplus" -- Copy paste between vim and everything else
vim.opt.fileencoding   = 'UTF-8' -- Character encoding for the file in the buffer
vim.opt.foldmethod     = 'marker' -- Automatically fold text in markers
vim.opt.mouse          = "a" -- Activate mouse
vim.opt.number         = true -- Add line numbering
vim.opt.relativenumber = true -- Add relative numbering, this is a must in my opinion
vim.opt.scrolloff      = 5 -- Leave some lines in the top and end of the file to have context
vim.opt.shortmess      = vim.opt.shortmess + 'c' -- Avoid showing message extra message when using completion
vim.opt.showmode       = false -- Don't show the ugly standard vim mode indicator at the end of the file
vim.opt.signcolumn     = "auto" -- Automatically add the sign column if necesary
vim.opt.smartcase      = true -- Smart case sensitivity for easier searching
vim.opt.splitbelow     = true -- Horizontal splitting will be automatically placed on the botom
vim.opt.splitright     = true -- Vertical splitting will be automatically placed on the right
vim.opt.wrap           = false -- Don't wrap text
vim.opt.wildmode       = 'longest,list,full' -- Completion mode used to showcase options
vim.opt.list           = true -- See whitespaces in current buffer
vim.opt.listchars      = "trail:∘,nbsp:‼,tab:│ " -- This whitespaces have an specific marker
