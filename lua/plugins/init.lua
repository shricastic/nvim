return {
  --Temp -> vim be good plugin
  {
    'ThePrimeagen/vim-be-good',
  },

  -- formatting conf
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- surround etc
  {
    "kylechui/nvim-surround",
    version = "^3.0.0",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },


  -- Folding plugin: nvim-ufo
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { "%s" },                  click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc },      click = "v:lua.ScLa" },
              { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
            },
          })
        end,
      },
    },
    event = "VeryLazy",

    config = function(_, opts)
      -- Simple, clean fold handler without symbols
      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (' 󰁂 %d '):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, 'MoreMsg' })
        return newVirtText
      end

      opts = opts or {}
      opts.fold_virt_text_handler = handler
      -- opts.provider_selector = function(_, _, _) return { "treesitter", "indent" } end

      require("ufo").setup(opts)
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        -- Add other languages you commonly use, for example:
        "python",
        "javascript",
        "typescript",
        "c",
        "cpp",
        "tsx",
        -- ... add more as needed
      },
      highlight = { enable = true },
      fold = { enable = true }
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = function()
      return require("configs.indent-blankline")
    end,
    config = function(_, opts)
      require("ibl").setup(opts)
    end,
  },

  -- leap to jump
  {
    "ggandor/leap.nvim",
    config = function()
      local leap = require("leap")
      -- leap.add_default_mappings()
    end,
  },

  --linter and formatting
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,  -- Formatter for JS/TS
          null_ls.builtins.diagnostics.eslint_d, -- Linter for JS/TS
        },
      })
    end,
  },


  -- nvim commnets for ts
  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },

  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")

      elixir.setup {
        nextls = { enable = true },
        elixirls = {
          enable = true,
          settings = elixirls.settings {
            dialyzerEnabled = false,
            enableTestLenses = false,
          },
          on_attach = function(client, bufnr)
            vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
            vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          end,
        },
        projectionist = {
          enable = true
        }
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  --snippet for cp
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      require("luasnip.loaders.from_vscode").lazy_load()

      ls.add_snippets("cpp", {
        s("cpmain", {
          t({
            "#include <bits/stdc++.h>",
            "#define ll long long",
            "#define MOD 1000000007",
            "",
            "using namespace std;",
            "",
            "void run() {",
            "  ",
            "  // Shri's code here",
            "  int t;",
            "  cin >> t;",
            "",
            "  while(t--) {"
          }),
          i(1, ""),
          t({
            "",
            "  }",
            "}",
            "",
            "int main() {",
            "  ios_base::sync_with_stdio(false);",
            "  cin.tie(nullptr);",
            "  run();",
            "  return 0;",
            "}"
          }),
        }),
        s("func", {
          t("void "),
          i(1, "functionName"),
          t("("),
          i(2, "args"),
          t({ ") {", "    " }),
          i(3, "// Your code here"),
          t({ "", "}" })
        }),
      })

      -- Enable luasnip for all filetypes
      ls.filetype_extend("all", { "_" })
    end,
  }
}
