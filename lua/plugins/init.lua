return {
  --Temp -> vim be good plugin
  {
    'ThePrimeagen/vim-be-good',
  },

  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
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
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
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

  {
    'smoka7/hop.nvim',
    version = "*",
    opts = {
        keys = 'etovxqpdygfblzhckisuran'
    },
    config = function ()
      require'hop'.setup()
    end,
    event = "VeryLazy",
    cmd = "HopWord"
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
          null_ls.builtins.formatting.prettier, -- Formatter for JS/TS
          null_ls.builtins.diagnostics.eslint_d, -- Linter for JS/TS
        },
      })
    end,
  },

  --for surround 
  {
    "machakann/vim-sandwich",
    event = "VeryLazy", -- Optional: Lazy load for better performance
    config = function()
      vim.g.sandwich_no_default_key_mappings = 0 -- Enables default keybindings
    end,
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
            "  "
          }),
          i(1, "// Your code here"),
          t({
            "",
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
          t({") {", "    "}),
          i(3, "// Your code here"),
          t({"", "}"})
        }),
      })

      -- Enable luasnip for all filetypes
      ls.filetype_extend("all", { "_" })
    end,
  }
}
