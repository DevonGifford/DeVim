return {
    'stevearc/oil.nvim',
    config = function()
        local oil = require("oil")
        local nvim_tmux_nav = require("nvim-tmux-navigation")

        oil.setup({
            default_file_explorer = true,
            view_options = {show_hidden = true},
            keymaps = {
                ["g?"] = {"actions.show_help", mode = "n"},
                ["<CR>"] = "actions.select",
                ["<C-s>"] = {"actions.select", opts = {vertical = true}},
                ["<C-t>"] = {"actions.select", opts = {tab = true}},
                ["<C-p>"] = "actions.preview",
                ["<C-c>"] = {"actions.close", mode = "n"},
                -- ["<C-l>"] = "actions.refresh",
                ["<C-l>"] = nvim_tmux_nav.NvimTmuxNavigateRight,
                -- ["<C-h>"] = {"actions.select", opts = {horizontal = true}},
                ["<C-h>"] = nvim_tmux_nav.NvimTmuxNavigateLeft,
                ["<C-j>"] = nvim_tmux_nav.NvimTmuxNavigateDown,
                ["<C-k>"] = nvim_tmux_nav.NvimTmuxNavigateUp,
                ["-"] = {"actions.parent", mode = "n"},
                ["_"] = {"actions.open_cwd", mode = "n"},
                ["`"] = {"actions.cd", mode = "n"},
                ["~"] = {"actions.cd", opts = {scope = "tab"}, mode = "n"},
                ["gs"] = {"actions.change_sort", mode = "n"},
                ["gx"] = "actions.open_external",
                ["g."] = {"actions.toggle_hidden", mode = "n"},
                ["g\\"] = {"actions.toggle_trash", mode = "n"}
            }
        })
    end,
    -- Optional dependencies
    dependencies = {
        'alexghergh/nvim-tmux-navigation', {"echasnovski/mini.icons", opts = {}}
    }
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
}
