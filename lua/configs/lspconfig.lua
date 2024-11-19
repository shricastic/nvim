-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls"}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

--custom lsp config

require('lspconfig').rust_analyzer.setup{
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importMergeBehavior = "last",
        importGranularity = "module",
      },
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
    },
  },
}

lspconfig.ts_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    settings = {
      javascript = {
        suggestionActions = { enabled = false },
        autoClosingTags = true,
        suggest = {
          completeFunctionCalls = true,
        },
      },
      typescript = {
        suggestionActions = { enabled = false },
        autoClosingTags = true,
        suggest = {
          completeFunctionCalls = true,
        },
      },
    },
})

lspconfig.emmet_ls.setup({
    capabilities = capabilities,
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "javascript", "typescript", "markdown" },
    init_options = {
      html = {
        options = {
          ["bem.enabled"] = true,
        },
      },
      jsx = {
        options = {
          ["output.selfClosingStyle"] = "xhtml",
        },
      }
    }
})


lspconfig.pyright.setup({
    capabilities = capabilities,
    filetypes = { "python" },
    root_dir = lspconfig.util.root_pattern(".git", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt"),
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace", -- Options: "workspace", "openFilesOnly"
            },
        },
    },
    init_options = {
        python = {
            venvPath = "~/.virtualenvs", -- Example: specify a directory for virtual environments
            pythonPath = "/usr/bin/python3", -- Path to the Python interpreter
        },
    },
})

-- Configure gopls for Go development
require'lspconfig'.gopls.setup({
  capabilities = nvlsp.capabilities,  -- Ensure your custom LSP capabilities are set correctly
  filetypes = { "go", "gomod" },  -- Enable Go and Go modules filetypes
  root_dir = require'lspconfig'.util.root_pattern("go.mod", ".git"),  -- Set root directory based on go.mod or .git
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,  -- Enable unused parameters analysis
        shadow = true,        -- Enable shadowed variables analysis
      },
      staticcheck = true,  -- Enable staticcheck for additional checks
      usePlaceholders = true,  -- Enable placeholders for completions
      completeUnimported = true,  -- Complete unimported symbols
      gofumpt = true,  -- Enable gofmt with stricter rules
    },
  },
})

