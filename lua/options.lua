require "nvchad.options"

-- add yours here!

-- Advanced folding configuration
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = true
vim.o.foldlevel = 0  -- Keeps all folds open by default

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

-- relative line numbers
vim.o.relativenumber = true
