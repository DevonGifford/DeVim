return {
  -- adding marks to gutter
  {
    "chentoast/marks.nvim",
    config = function()
      require("marks").setup()
    end,
  },
}
