require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

--keymap for go to definition
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })

--manual formatting 
map("n", "<leader>cf", function() require("conform").format({ async = true, lsp_fallback = true }) end, { desc = "Format Code" })

-- Dynamic buffer-to-leader mappings based on bufferline order
local function map_buffers_to_leader_keys()
  local bufs = vim.t.bufs or {}

  for i = 1, 9 do
    pcall(vim.keymap.del, "n", "<leader>" .. i)
  end

  for i = 1, math.min(#bufs, 9) do
    local buf_id = bufs[i]
    vim.keymap.set("n", "<leader>" .. i, function()
      vim.cmd("buffer " .. buf_id)
    end, { desc = "Switch to buffer " .. i, noremap = true, silent = true })
  end
end

map_buffers_to_leader_keys()

-- Auto-update on buffer events and tab changes
local group = vim.api.nvim_create_augroup("BufferLeaderMappings", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "TabEnter", "BufAdd", "BufDelete" }, {
  group = group,
  callback = map_buffers_to_leader_keys,
})

-- Leap.nvim remapped to <leader>s and <leader>S
local leap = require("leap")

-- First, add default mappings so we can delete them
-- leap.add_default_mappings()

-- Now remove the default s/S bindings to avoid conflicts with surround
-- pcall(vim.keymap.del, { "n", "x", "o" }, "s")
-- pcall(vim.keymap.del, { "n", "x", "o" }, "S")

-- Set up custom leap mappings
vim.keymap.set({ "n", "x", "o" }, "<leader>s", function()
  leap.leap({ target_windows = { vim.fn.win_getid() } })
end, { desc = "Leap forward" })

-- vim.keymap.set({ "n", "x", "o" }, "<leader>S", function()
--   leap.leap({ target_windows = { vim.fn.win_getid() }, backward = true })
-- end, { desc = "Leap backward" })

-- Optional: Add cross-window leap
-- vim.keymap.set({ "n", "x", "o" }, "gs", function()
--   leap.leap({ target_windows = vim.tbl_map(vim.fn.win_getid, vim.fn.range(1, vim.fn.winnr('$'))) })
-- end, { desc = "Leap across windows" })
