return {
  -- Surround: cs"' to change, ds" to delete, ysiw" to add
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Inline color preview (#fff, rgb(), hsl(), etc.)
  {
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPre",
    opts = {
      render = "background",
      enable_tailwind = true,
    },
  },

  -- Highlight and navigate git conflict markers
  {
    "rhysd/conflict-marker.vim",
    event = "BufReadPre",
  },

  -- Refactoring operations (extract function/variable, etc.)
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    keys = {
      {
        "<leader>r",
        function()
          require("refactoring").select_refactor()
        end,
        mode = "v",
        desc = "Refactor",
      },
    },
    config = function()
      require("refactoring").setup()
    end,
  },

  -- Oil: edit the filesystem like a buffer (complement to neo-tree)
  {
    "stevearc/oil.nvim",
    keys = {
      { "<C-b>", "<cmd>Oil<CR>", desc = "Oil: open parent dir" },
    },
    opts = {
      default_file_explorer = false, -- keep neo-tree as default
      keymaps = {
        ["<C-h>"] = false, -- don't override tmux nav
        ["<C-l>"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
      },
    },
  },
}
