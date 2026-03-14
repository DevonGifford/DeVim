return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    local dashboard = require("dashboard")

    local logo = [[
        ██████╗   ███████╗  ██╗   ██╗  ██╗  ███╗   ███╗
        ██╔══██╗  ██╔════╝  ██║   ██║  ██║  ████╗ ████║
        ██║  ██║  █████╗    ██║   ██║  ██║  ██╔████╔██║
        ██║  ██║  ██╔══╝    ╚██╗ ██╔╝  ██║  ██║╚██╔╝██║
        ██████╔╝  ███████╗   ╚████╔╝   ██║  ██║ ╚═╝ ██║
        ╚═════╝   ╚══════╝    ╚═══╝    ╚═╝  ╚═╝     ╚═╝
    ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = { statusline = false },
      config = {
        header = vim.split(logo, "\n"),
        center = {
          { action = "Telescope find_files", desc = "Search", icon = " ", key = "f" },
          { action = "Telescope live_grep", desc = "Grep", icon = " ", key = "g" },
          { action = "Telescope oldfiles", desc = "Recent", icon = " ", key = "r" },
          { action = "ene | startinsert", desc = "Create", icon = " ", key = "n" },
          { action = "Telescope find_files cwd=~/.config/nvim", desc = "Config", icon = " ", key = "c" },
          { action = "Lazy", desc = "Lazy", icon = "󰒲 ", key = "l" },
          { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = "Quit", icon = " ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return {
            "",
            "",
            "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
            "",
            "- Linux edition 🐧-"
          }
        end,
      },
    }

    -- Padding between desc and key
    for _, button in ipairs(opts.config.center) do
      local padding = string.rep(" ", 35 - #button.desc + 5)
      button.desc = button.desc .. padding
    end

    -- Auto-show dashboard after lazy closes
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

    dashboard.setup(opts)
  end,
}
