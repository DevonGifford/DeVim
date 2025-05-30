return {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
        local dapui = require("dapui")

        dapui.setup()

        vim.keymap.set("n", "<leader>dl",
                       "<cmd>lua require('dapui').toggle()<CR>",
                       {noremap = true, desc = "Toggle DAP UI"})

        vim.keymap.set("n", "<leader>dc",
                       "<cmd>lua require('dap').continue()<CR>",
                       {noremap = true})
        vim.keymap.set("n", "<leader>db",
                       "<cmd>lua require('dap').toggle_breakpoint()<CR>",
                       {noremap = true})
        vim.keymap.set("n", "<leader>dr",
                       "<cmd>lua require('dap').repl.open()<CR>",
                       {noremap = true})
        vim.keymap.set("n", "<leader>ds",
                       "<cmd>lua require('dap').step_over()<CR>",
                       {noremap = true})
        vim.keymap.set("n", "<leader>di",
                       "<cmd>lua require('dap').step_into()<CR>",
                       {noremap = true})
    end
}
