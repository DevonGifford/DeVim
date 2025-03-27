return {
    'nvim-pack/nvim-spectre',
    dependencies = {'nvim-lua/plenary.nvim'},
    config = function()
        require("spectre").setup({
            replace_engine = {["sed"] = {cmd = "sed", args = {"-i", "", "-E"}}}
        })

        vim.keymap.set('n', '<leader>sw',
                       '<cmd>lua require("spectre").toggle()<CR>')
    end
}
