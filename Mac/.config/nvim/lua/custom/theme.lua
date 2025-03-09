return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        local catppuccin = require("catppuccin")
        catppuccin.setup({
            flavour = "mocha",
            styles = {
                comments = {"italic"},
                functions = {"italic"},
                keywords = {"bold"}
            },
            custom_highlights = function(colors)
                local u = require("catppuccin.utils.colors")
                return {
                    Cursorline = {
                        bg = u.vary_color({
                            mocha = u.lighten(colors.crust, 0.70, colors.base)
                        }, u.darken(colors.crust, 0.64, colors.base))
                    }
                }
            end,
            integrations = {
                cmp = true,
                gitsigns = true,
                nvimtree = true,
                treesitter = true,
                notify = false,
                mini = {enabled = true, indentscope_color = ""}
            }
        })

        vim.cmd.colorscheme "catppuccin"
    end
}
