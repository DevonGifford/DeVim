return {
  "kdheepak/lazygit.nvim",
  keys = {
    {
      ";g",
      ":LazyGit<Return>",
      silent = true,
      noremap = true,
    },
  },
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}

