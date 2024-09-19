return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()

    -- DAP namespace: <leader>dap
    vim.keymap.set("n", "<leader>dap t", dapui.toggle, { desc = "[DAP] [T]oggle debug UI", })
    vim.keymap.set("n", "<leader>dap c", dap.continue, { desc = "[DAP] [C]ontinue / start debugging", })
    vim.keymap.set("n", "<leader>dap b", dap.toggle_breakpoint, { desc = "[DAP] Toggle [B]reakpoint", })
    vim.keymap.set("n", "<leader>dap s", dap.step_over, { desc = "[DAP] [S]tep over", })
    vim.keymap.set("n", "<leader>dap i", dap.step_into, { desc = "[DAP] step [I]nto", })
    vim.keymap.set("n", "<leader>dap r", dap.repl.open, { desc = "[DAP] Open debug [R]epl", })
  end,
}
