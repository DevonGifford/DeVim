-- VIM SETUP
local global_options = {
    mapleader = ' ',
    loaded_perl_provider = 0,
    maplocalleader = ' ',
    netrw_keepdir = 1,
    netrw_winsize = 17,
    netrw_banner = '0',
    netrw_sizestyle = 'H',
    netrw_localmkdir = 'mkdir -p',
    netrw_localcopycmd = 'cp -r',
    netrw_localrmdir = 'rm -rf',
    netrw_list_hide = [['\(^\|\s\s\)\zs\.\S\+']]
}

for k, v in pairs(global_options) do vim.g[k] = v end

local o_options = {
    autoindent = true,
    breakindent = true,
    clipboard = 'unnamedplus',
    completeopt = 'menuone,noselect',
    cursorline = false,
    expandtab = true,
    fillchars = { fold = ' ' },
    foldenable = false,
    foldlevel = 99,
    foldmethod = 'indent',
    hlsearch = true,
    ignorecase = true,
    mouse = 'a',
    scrolloff = 12,
    shiftwidth = 4,
    smartcase = true,
    smartindent = true,
    softtabstop = 4,
    tabstop = 4,
    termguicolors = true,
    timeoutlen = 300,
    updatetime = 250,
    wrap = true,
}

for k, v in pairs(o_options) do vim.opt[k] = v end

local wo_options = {number = true, signcolumn = 'yes', relativenumber = true}

for k, v in pairs(wo_options) do vim.wo[k] = v end

vim.api.nvim_command("set iskeyword+=-")

vim.diagnostic.config({
    underline = true,
    virtual_text = {source = 'if_many', spacing = 2},
    signs = true,
    update_in_insert = false,
    severity_sort = true
})


-- NVIM SETUP
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git', 'clone', '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath
    }
end
vim.opt.rtp:prepend(lazypath)



-- CUSTOM KEYBINDINGS
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
-- Basic movement
keymap.set("n", "n", "nzzzv", { desc = "Move to next search result and center" })
keymap.set("n", "N", "Nzzzv", { desc = "Move to previous search result and center" })
-- Scroll with center
keymap.set("n", "<c-d>", "<c-d>zz", { desc = "Scroll down half screen" })
keymap.set("n", "<c-u>", "<c-u>zz", { desc = "Scroll up half screen" })
-- Increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })
-- File management (NvimTree and Oil integration)
keymap.set("n", "<leader>f", ":NvimTreeFindFile<CR>", { desc = "Find file in NvimTree" })
keymap.set("n", "<c-b>", ":Oil<CR>", { silent = true, desc = "Open Oil file explorer" })
-- File and buffer navigation (Tab management)
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<Tab>", ":tabnext<CR>", { desc = "Go to next tab" })
keymap.set("n", "<S-Tab>", ":tabprev<CR>", { desc = "Go to previous tab" })
-- Window splitting
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
-- Resize windows
keymap.set("n", "<leader>+", ":exe 'vertical resize ' . (winwidth(0) * 3/2)<CR>", { silent = true })
keymap.set("n", "<leader>-", ":exe 'vertical resize ' . (winwidth(0) * 2/3)<CR>", { silent = true })
-- Window navigation (Shift to be more natural for movement)
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize split sizes" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close the current split" })
-- Additional diagnostic handling
keymap.set("n", "<leader>t", vim.diagnostic.open_float, { desc = "Show diagnostic in floating window" })
-- Diagnostic navigation
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
-- Custom  Misc actions/commands
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all in the current buffer" }) -- Select all text
keymap.set("i", "<S-Tab>", "<C-D>", { desc = "Decrease indentation in insert mode" }) -- Enables using shift TAB to decrease indentation 
keymap.set({"n", "v"}, "<Space>", "<Nop>", { silent = true }) -- Disable <Space> in normal and visual mode to avoid conflicts
keymap.set("n", "<leader>w", ":w<CR>", opts) -- Save file (same as <Leader>w)
keymap.set("n", "<leader>q", ":q<CR>", opts) -- Quit file (same as <Leader>q)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts) -- Quit all open windows (custom action)


-- CUSTOM PLUGINS
require 'custom.formatting'
require 'custom.hex_to_rgb'
require 'custom.tmux-navigation'

require('lazy').setup({
    { import = "custom.dashboard" },
    'tpope/vim-sleuth',
    require 'custom.autopairs',
    require 'custom.autotag',
    require 'custom.comment',
    require 'custom.copilot',
    require 'custom.flash',
    require 'custom.gitsigns',
    require 'custom.lsp',
    require 'custom.nvim-cmp',
    require 'custom.telescope',
    require 'custom.treesitter',
    require 'custom.dap',
    require 'custom.fugitive',
    require 'custom.gleam',
    require 'custom.oil',
    require 'custom.mdx',
    require 'custom.highlight-colors',
    require 'custom.lualine',
    require 'custom.tokyonight',
    require 'custom.conflict-marker',
    require 'custom.spectre',
    require 'custom.refactoring',
    require 'custom.tree',
    require 'custom.bufferline',
    require 'custom.lazygit',
    require 'custom.which-key',
    -- require 'custom.theme'
}, {})
