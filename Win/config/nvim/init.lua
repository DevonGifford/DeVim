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
keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
-- Scroll with center
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
-- Increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "[+] Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "[-] Decrement number" })
-- File management (NvimTree and Oil integration)
keymap.set("n", "<leader>f", ":NvimTreeFindFile<CR>", { desc = "[F]ind file in [N]vimTree" })
keymap.set("n", "<c-b>", ":Oil<CR>", { silent = true, desc = "Open [O]il file explorer" })
-- File and buffer navigation (Tab management)
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "[T]ab [O]pen new" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "[T]ab e[X]it current" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "[T]ab [N]ext" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "[T]ab [P]revious" })
keymap.set("n", "<Tab>", ":tabnext<CR>", { desc = "Next tab" })
keymap.set("n", "<S-Tab>", ":tabprev<CR>", { desc = "Previous tab" })
-- Window splitting
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "[S]plit [V]ertical" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "[S]plit [H]orizontal" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "[S]plit [E]qual size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "[S]plit e[X]it current" })
-- Resize windows
keymap.set("n", "<leader><leader>+", ":exe 'vertical resize ' . (winwidth(0) * 3/2)<CR>", { desc = "[+] Resize wider", silent = true })
keymap.set("n", "<leader><leader>-", ":exe 'vertical resize ' . (winwidth(0) * 2/3)<CR>", { desc = "[-] Resize narrower", silent = true })
-- Diagnostics
keymap.set("n", "<leader>t", vim.diagnostic.open_float, { desc = "[T]oggle diagnostic float" })
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev [D]iagnostic" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next [D]iagnostic" })
keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "[E]rror float window" })
keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "[Q]uickfix diagnostics list" })
-- Git (Telescope)
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "[G]it [S]tatus" })
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "[G]it [C]ommits (project)" })
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "[G]it [B]ranches" })
keymap.set("n", "<leader>gl", "<cmd>Telescope git_bcommits<CR>", { desc = "[G]it [L]og (buffer)" })
-- Misc
keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all in buffer" })
keymap.set("i", "<S-Tab>", "<C-D>", { desc = "Decrease indent (Insert mode)" })
keymap.set({ "n", "v" }, "<Space>", "<Nop>", { desc = "Disable Space", silent = true })
-- File ops
keymap.set("n", "<leader>w", ":w<CR>", { desc = "[W]rite/save file", noremap = true, silent = true })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "[Q]uit file", noremap = true, silent = true })
keymap.set("n", "<Leader>Q", ":qa<CR>", { desc = "[Q]uit [A]ll", noremap = true, silent = true })


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
