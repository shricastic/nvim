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
lspconfig.rust_analyzer.setup {
  on_attach = function(client, bufnr)
    -- Call the original on_attach function if it exists
    if nvlsp and nvlsp.on_attach then
      nvlsp.on_attach(client, bufnr)
    end

    -- Check if inlay hints are supported and enable them
    if client.server_capabilities.inlayHintProvider then
      -- Use vim.defer_fn to ensure the buffer is fully loaded
      vim.defer_fn(function()
        pcall(function()
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end)
      end, 500)
    end
  end,

  -- maintain your existing on_init and capabilities
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,

  settings = {
    ["rust-analyzer"] = {
      assist = {
        importmergebehavior = "last",
        importgranularity = "module",
        importprefix = "by_self",
      },
      cargo = {
        loadoutdirsfromcheck = true,
      },
      procmacro = {
        enable = true,
      },
      inlayhints = {
        enable = true,
        showparameterhints = true,
        typehints = { 
          enable = true,
          hidenamedconstructor = false 
        },
        chaininghints = { enable = true },
        auto = true,
      },
      completion = {
        autoimport = {
          enable = true,
        },
      },
    },
  },
}

lspconfig.ts_ls.setup({
    on_attach = nvlsp.on_attach,
    capabilities = nvlsp.capabilities,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    settings = {
      javascript = {
        suggestionactions = { enabled = false },
        autoclosingtags = true,
        suggest = {
          autoimport = true,
          completefunctioncalls = true,
        },
        importmodulespecifierpreference = "non-relative",  -- prefer non-relative import paths
      },
      typescript = {
        suggestionactions = { enabled = false },
        autoclosingtags = true,
        suggest = {
          autoimport = true,
          completefunctioncalls = true,
        },
        importmodulespecifierpreference = "non-relative",  -- prefer non-relative import paths
      },
    },
})

lspconfig.emmet_ls.setup({
    capabilities = nvlsp.capabilities,
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "javascript", "typescript", "markdown", "svelte" },
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
    capabilities = nvlsp.capabilities,
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

