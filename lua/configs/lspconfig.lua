-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls" }
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


local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-q>"] = function(prompt_bufnr)
          local picker = action_state.get_current_picker(prompt_bufnr)
          if #picker:get_multi_selection() > 0 then
            actions.send_selected_to_qflist(prompt_bufnr)
          else
            actions.send_to_qflist(prompt_bufnr)
          end
          actions.open_qflist(prompt_bufnr)
        end,
      },
      n = {
        ["<C-q>"] = function(prompt_bufnr)
          local picker = action_state.get_current_picker(prompt_bufnr)
          if #picker:get_multi_selection() > 0 then
            actions.send_selected_to_qflist(prompt_bufnr)
          else
            actions.send_to_qflist(prompt_bufnr)
          end
          actions.open_qflist(prompt_bufnr)
        end,
      },
    },
  },
})

--custom lsp config
lspconfig.rust_analyzer.setup {
  filetypes = { "rust" },
  root_dir = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json"),

  on_attach = function(client, bufnr)
    -- Call the original on_attach function if it exists
    if nvlsp and nvlsp.on_attach then
      nvlsp.on_attach(client, bufnr)
    end

    -- Enable inlay hints if supported
    if client.server_capabilities.inlayHintProvider then
      vim.defer_fn(function()
        pcall(function()
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end)
      end, 500)
    end
  end,

  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,

  settings = {
    ["rust-analyzer"] = {
      assist = {
        importMergeBehavior = "last",
        importGranularity = "module",
        importPrefix = "by_self",
      },
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      },
      inlayHints = {
        enable = true,
        showParameterHints = true,
        typeHints = {
          enable = true,
          hideNamedConstructor = false,
        },
        chainingHints = { enable = true },
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

-- Updated TypeScript / JavaScript LSP configuration using vtsls
-- lspconfig.vtsls.setup({
--   on_attach = function(client, bufnr)
--     nvlsp.on_attach(client, bufnr)
--     local bufopts = { noremap = true, silent = true, buffer = bufnr }
--     vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", bufopts, { desc = "Goto Definition" }))
--     vim.keymap.set("n", "gr", function()
--       require("telescope.builtin").lsp_references()
--     end, vim.tbl_extend("force", bufopts, { desc = "File References" }))
--   end,
--   capabilities = nvlsp.capabilities,
--   filetypes = {
--     "javascript",
--     "javascriptreact",
--     "javascript.jsx",
--     "typescript",
--     "typescriptreact",
--     "typescript.tsx",
--   },
--   root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
--   settings = {
--     complete_function_calls = true,
--     vtsls = {
--       enableMoveToFileCodeAction = true,
--       autoUseWorkspaceTsdk = true,
--       experimental = {
--         maxInlayHintLength = 30,
--         completion = {
--           enableServerSideFuzzyMatch = true,
--         },
--       },
--     },
--     typescript = {
--       updateImportsOnFileMove = { enabled = "always" },
--       suggest = { completeFunctionCalls = true },
--       inlayHints = {
--         enumMemberValues = { enabled = true },
--         functionLikeReturnTypes = { enabled = true },
--         parameterNames = { enabled = "literals" },
--         parameterTypes = { enabled = true },
--         propertyDeclarationTypes = { enabled = true },
--         variableTypes = { enabled = false },
--       },
--     },
--   },
-- })

lspconfig.tailwindcss.setup({
  on_attach = nvlsp.on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = {
    "html",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "css",
    "scss",
    "less",
    "svelte",
  },
  root_dir = lspconfig.util.root_pattern(
    "tailwind.config.js",
    "tailwind.config.ts",
    "postcss.config.js",
    "postcss.config.ts",
    "package.json",
    ".git"
  ),
  settings = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          { "cn\\(([^)]*)\\)",   "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        },
      },
    },
  },
})

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
      importmodulespecifierpreference = "non-relative", -- prefer non-relative import paths
    },
    typescript = {
      suggestionactions = { enabled = false },
      autoclosingtags = true,
      suggest = {
        autoimport = true,
        completefunctioncalls = true,
      },
      importmodulespecifierpreference = "non-relative", -- prefer non-relative import paths
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
      venvPath = "~/.virtualenvs",     -- Example: specify a directory for virtual environments
      pythonPath = "/usr/bin/python3", -- Path to the Python interpreter
    },
  },
})

-- Configure gopls for Go development
require 'lspconfig'.gopls.setup({
  capabilities = nvlsp.capabilities,                                  -- Ensure your custom LSP capabilities are set correctly
  filetypes = { "go", "gomod" },                                      -- Enable Go and Go modules filetypes
  root_dir = require 'lspconfig'.util.root_pattern("go.mod", ".git"), -- Set root directory based on go.mod or .git
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,     -- Enable unused parameters analysis
        shadow = true,           -- Enable shadowed variables analysis
      },
      staticcheck = true,        -- Enable staticcheck for additional checks
      usePlaceholders = true,    -- Enable placeholders for completions
      completeUnimported = true, -- Complete unimported symbols
      gofumpt = true,            -- Enable gofmt with stricter rules
    },
  },
})
