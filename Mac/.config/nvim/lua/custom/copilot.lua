return {
  "github/copilot.vim",
  event = "InsertEnter",
  config = function()
    -- IMPORTANT: do not steal <Tab>
    vim.g.copilot_no_tab_map = true

    -- Accept suggestion (clean, conflict-free)
    vim.keymap.set("i", "<C-l>", 'copilot#Accept("")', {
      expr = true,
      replace_keycodes = false,
      desc = "Copilot accept",
    })

    -- Cycle suggestions
    vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", { desc = "Copilot next" })
    vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { desc = "Copilot prev" })

    -- Dismiss suggestion
    vim.keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)", { desc = "Copilot dismiss" })

    -- Reduce noise
    vim.g.copilot_filetypes = {
      markdown = false,
      help = false,
      gitcommit = false,
      ["*"] = true,
    }
  end,
}
