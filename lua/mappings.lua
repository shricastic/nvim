require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

--custom keymap for hop
map('n', '<leader>hw', ':HopWord<CR>', { noremap = true, silent = true })

--manual formatting 
map("n", "<leader>cf", function() require("conform").format({ async = true, lsp_fallback = true }) end, { desc = "Format Code" })
