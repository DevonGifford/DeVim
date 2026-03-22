return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    local dashboard = require("dashboard")

    local logo = [[
        ██████╗     ███████╗    ██╗   ██╗    ██╗    ███╗   ███╗
        ██╔══██╗    ██╔════╝    ██║   ██║    ██║    ████╗ ████║
        ██║  ██║    █████╗      ██║   ██║    ██║    ██╔████╔██║
        ██║  ██║    ██╔══╝      ╚██╗ ██╔╝    ██║    ██║╚██╔╝██║
        ██████╔╝    ███████╗     ╚████╔╝     ██║    ██║ ╚═╝ ██║
        ╚═════╝     ╚══════╝      ╚═══╝      ╚═╝    ╚═╝     ╚═╝
    ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = { statusline = false },
      config = {
        header = vim.split(logo, "\n"),
        center = {
          { action = "Telescope find_files",      desc = "Search", icon = " ", key = "f" },
          { action = "ene | startinsert",         desc = "Create", icon = " ", key = "n" },
          { action = "Telescope oldfiles",        desc = "Recent", icon = " ", key = "r" },
          { action = "Telescope live_grep",       desc = "Grep", icon = " ", key = "g" },
          { action = "Telescope find_files cwd=~/.config/nvim", desc = "Config", icon = " ", key = "c" },
          { action = 'lua require("persistence").load()', desc = "Restore Session", icon = " ", key = "s" },
          { action = "LazyExtras", desc = "Lazy Extras", icon = " ", key = "x" },
          { action = "Lazy", desc = "Lazy", icon = "󰒲 ", key = "l" },
          { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = "Quit", icon = " ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "", "", "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }

    -- Add a gap between the description and key
    -- Adjust the width of the description and add spacing between the text and key
    local max_desc_length = 35 -- maximum length for the description text
    for _, button in ipairs(opts.config.center) do
      -- Pad the description to have a gap before the key
      local padding = string.rep(" ", max_desc_length - #button.desc + 5) -- Add extra padding
      button.desc = button.desc .. padding
    end

    -- open dashboard after closing lazy
    if vim.o.filetype == "lazy" then
      vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
          end)
        end,
      })
    end

    return opts
  end,
}

-- return {
--   "nvimdev/dashboard-nvim",
--   event = "VimEnter",
--   config = function()
--     local dashboard = require("dashboard")
--
--     local logo = [[
--         ██████╗     ███████╗    ██╗   ██╗    ██╗    ███╗   ███╗
--         ██╔══██╗    ██╔════╝    ██║   ██║    ██║    ████╗ ████║
--         ██║  ██║    █████╗      ██║   ██║    ██║    ██╔████╔██║
--         ██║  ██║    ██╔══╝      ╚██╗ ██╔╝    ██║    ██║╚██╔╝██║
--         ██████╔╝    ███████╗     ╚████╔╝     ██║    ██║ ╚═╝ ██║
--         ╚═════╝     ╚══════╝      ╚═══╝      ╚═╝    ╚═╝     ╚═╝
--     ]]
--
--     logo = string.rep("\n", 8) .. logo .. "\n\n"
--
--     dashboard.setup({
--       theme = 'doom',  -- Example theme, feel free to change this
--       config = {
--         header = vim.split(logo, "\n"),  -- Custom header with ASCII art
--         center = {
--           { action = "Telescope find_files", desc = "Search", icon = "     ", key = "f" },
--           { action = "Telescope live_grep", desc = "Grep", icon = "     ", key = "g" },
--           { action = "Telescope oldfiles", desc = "Recent", icon = "     ", key = "r" },
--           { action = "ene | startinsert", desc = "Create", icon = "     ", key = "n" },
--           { action = "Telescope find_files cwd=~/.config/nvim", desc = "Config", icon = "     ", key = "c" },
--           { action = "Lazy", desc = "Lazy", icon = "󰒲     ", key = "l" },
--           { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = "Quit", icon = "     ", key = "q" },
--         },
--         footer = function()
--           local stats = require("lazy").stats()
--           local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
--           return { "", "", "", "", "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
--         end,
--       }
--     })
--   end,
--   dependencies = { "nvim-tree/nvim-web-devicons" }
-- }
