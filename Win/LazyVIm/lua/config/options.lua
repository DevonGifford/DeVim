-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set the leader key to a space
vim.g.mapleader = " "

-- Set encoding settings
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Display line numbers
vim.opt.number = true

-- Show the title of the window
vim.opt.title = true

-- Indentation and formatting settings
vim.opt.autoindent = true -- Automatically indent new lines based on the indentation of the previous line.
vim.opt.smartindent = true -- Smart indentation that adjusts based on the syntax of the file being edited.
vim.opt.hlsearch = true -- Highlight search matches as you type.
vim.opt.backup = false -- Disable backup files.
vim.opt.showcmd = true -- Show partial commands in the last line of the screen.
-- vim.opt.cmdheight = 0 -- Height of the command line.
-- vim.opt.laststatus = 0 -- Hide the status line if there is only one window.
vim.opt.expandtab = true -- Use spaces instead of tabs.
vim.opt.scrolloff = 10 -- Number of lines to keep visible when scrolling.
vim.opt.inccommand = "split" -- Show live preview of substitute command in a split window.
vim.opt.ignorecase = true -- Ignore case when searching.
vim.opt.smarttab = true -- Use smart tabs, meaning tabs are used for indentation and spaces for alignment.
vim.opt.breakindent = true -- Indent wrapped lines visually by two characters.
vim.opt.shiftwidth = 2 -- Number of spaces for each level of indentation.
vim.opt.tabstop = 2 -- Width of a tab character.
vim.opt.wrap = false -- Disable line wrapping.
vim.opt.backspace = { "start", "eol", "indent" } -- Allow backspacing over autoindent, line breaks, and start of insert.
vim.opt.path:append({ "**" }) -- Add recursive wildcard to the search path.
vim.opt.wildignore:append({ "*/node_modules/*" }) -- Ignore node_modules directories when using file wildcards.
vim.opt.splitbelow = true -- Open new split windows below the current window.
vim.opt.splitright = true -- Open new split windows to the right of the current window.
vim.opt.splitkeep = "cursor" -- Keep the cursor in the same position when splitting windows.
-- vim.opt.mouse = ""

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })
