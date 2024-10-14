return {
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
      highlight = {
        enable = true,
      },
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

  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      ls.add_snippets("cpp", {
        s("cpmain", {
          t({
            "#include <bits/stdc++.h>",
            "using namespace std;",
            "",
            "int main() {",
            "    ios_base::sync_with_stdio(false);",
            "    cin.tie(nullptr);",
            "    // Your code here",
            "    return 0;",
            "}"
          }),
        }),
        s("func", {
          t("void "), i(1, "functionName"), t("("), i(2, "args"), t({") {", "    "}), i(0, "// code here"), t({"", "}"})
        }),
      })
    end,
  },

}
