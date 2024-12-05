require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

--custom keymap for hop
map('n', '<leader>hw', ':HopWord<CR>', { noremap = true, silent = true })

--free up 's' for nvim-sandwich
vim.keymap.set("n", "s", "<nop>")
vim.keymap.set("x", "s", "<nop>")

--keymap for go to definition
vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

--manual formatting 
map("n", "<leader>cf", function() require("conform").format({ async = true, lsp_fallback = true }) end, { desc = "Format Code" })

-- Dynamic buffer-to-leader mappings
local function map_buffers_to_leader_keys()
  local buffers = vim.fn.getbufinfo({ buflisted = true })

  for i = 1, 9 do
    pcall(vim.keymap.del, "n", "<leader>" .. i)
  end

  for i = 1, math.min(#buffers, 9) do
    local buffer_id = buffers[i].bufnr -- Get the buffer number
    vim.keymap.set("n", "<leader>" .. i, function()
      vim.cmd("buffer " .. buffer_id)
    end, { desc = "Switch to buffer " .. i, noremap = true, silent = true })
  end
end

-- Call the function to set the mappings initially
map_buffers_to_leader_keys()

-- Create an autocmd group for dynamic updates
local group = vim.api.nvim_create_augroup("BufferLeaderMappings", { clear = true })

-- Update mappings dynamically on buffer events
vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  callback = map_buffers_to_leader_keys,
})

