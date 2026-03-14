return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    -- Project-wide search & replace with preview
    require("spectre").setup({
      replace_engine = {
        ["sed"] = {
          cmd = "sed",
          args = { "-i", "", "-E" }, -- in-place, extended regex
        },
      },
    })

    vim.keymap.set("n", "<leader>sw", function()
      require("spectre").toggle()
    end, { desc = "[S]earch project [W]ide & replace" })
  end,
}
