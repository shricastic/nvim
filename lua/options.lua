require "nvchad.options"

-- add yours here!

-- Advanced folding configuration
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- relative line numbers
vim.o.relativenumber = true
