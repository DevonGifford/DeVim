-- OPTIONS
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_perl_provider = 0
vim.opt.relativenumber = false
vim.opt.scrolloff = 12
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.winborder = "rounded"
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.cmd("set iskeyword+=-")

-- KEYMAPS
local map = vim.keymap.set
-- Basic movement
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })
-- Scroll with center
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
-- File and buffer navigation (Tab management)
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "New tab" })
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close tab" })
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Next tab" })
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Prev tab" })
-- Custom  Misc actions/commands
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })

-- BOOTSTRAP lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
-- Add lazy.nvim to the runtime path so Neovim can find it.
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- LazyVim provides default plugins (telescope, treesitter, lualine, etc.)
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  -- Fallback colorscheme used during initial install before custom theme is available.
  install = { colorscheme = { "tokyonight", "habamax" } },
  -- Silently check for plugin updates in the background; no popup on every launch.
  checker = { enabled = true, notify = false },
  performance = {
    rtp = {
      -- Disable built-in Neovim plugins we never use to shave startup time.
      disabled_plugins = { "gzip", "tarPlugin", "tohtml", "tutor", "zipPlugin" },
    },
  },
})

