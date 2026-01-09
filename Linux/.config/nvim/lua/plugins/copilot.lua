return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    vim.g.copilot_no_tab_map = true

    vim.keymap.set("i", "<C-l>", 'copilot#Accept("")', {
      expr = true,
      replace_keycodes = false,
      desc = "Copilot: accept suggestion",
    })
    vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)",     { desc = "Copilot: next suggestion" })
    vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { desc = "Copilot: prev suggestion" })
    vim.keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)",  { desc = "Copilot: dismiss" })

    vim.g.copilot_filetypes = {
      markdown  = false,
      help      = false,
      gitcommit = false,
      ["*"]     = true,
    }
  end,
}
