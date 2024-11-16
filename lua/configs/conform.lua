local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" }, -- Add JavaScript formatter
    javascriptreact = { "prettier" }, -- For JSX
    typescript = { "prettier" }, -- For TypeScript
    typescriptreact = { "prettier" }, -- For TSX
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
