return {
  'lewis6991/gitsigns.nvim',
  config = function()
    require("gitsigns").setup({
      current_line_blame = true,
      on_attach = function(_) end,
    })

    -- Global keybinding: toggle inline blame
    vim.keymap.set("n", "<leader>gt", function()
      require("gitsigns").toggle_current_line_blame()
    end, { desc = "[G]it [T]oggle blame" })
  end,
}
