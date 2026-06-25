return {
  "sindrets/diffview.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    local diffview = require("diffview")

    diffview.setup({
      use_icons = true,
      icons = { folder_closed = "", folder_open = "" },
      view = {
        default = { winbar_info = true },
      },
      file_panel = {
        win_config = { height = 20 },
      },
    })

    -- Custom Interactive Diffview launcher (using Telescope)
    -- 1. Pick BASE branch (what you're comparing *from*)
    -- 2. Pick COMPARE branch (what you're comparing *to*)
    -- 3. Opens :Diffview `base...compare`
    vim.keymap.set("n", "<leader>do", function()
      local telescope = require("telescope.builtin")
      local actions = require("telescope.actions")
      local state = require("telescope.actions.state")
      telescope.git_branches({
        prompt_title = "Diffview: Select BASE branch",
        attach_mappings = function(_, map)
          map("i", "<CR>", function(prompt_bufnr)
            local base = state.get_selected_entry().value
            actions.close(prompt_bufnr)
            telescope.git_branches({
              prompt_title = "Diffview: Select COMPARE branch",
              attach_mappings = function(_, map2)
                map2("i", "<CR>", function(prompt_bufnr2)
                  local compare = state.get_selected_entry().value
                  actions.close(prompt_bufnr2)
                  vim.cmd("DiffviewOpen " .. base .. "..." .. compare)
                end)
                return true
              end,
            })
          end)
          return true
        end,
      })
    end, { desc ="[D]iffview [O]pen (pick base → compare)"})

    -- Diffview keymaps
    vim.keymap.set('n', '<leader>df', '<cmd>DiffviewFileHistory %<cr>', { desc = '[D]iffview [F]ile history (focused-file)' })
    vim.keymap.set('n', '<leader>dr', '<cmd>DiffviewFileHistory<cr>', { desc = '[D]iffview [R]epo history (project-wide)' })
    vim.keymap.set('n', '<leader>dt', '<cmd>DiffviewToggleFiles<cr>', { desc = '[D]iffview [T]oggle file (GUI)' })
    vim.keymap.set('n', '<leader>dc', '<cmd>DiffviewClose<cr>', { desc = '[D]iffview [C]lose diff (GUI)' })
  end,
}
