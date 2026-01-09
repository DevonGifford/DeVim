return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<leader>dl", function() require("dapui").toggle() end,             desc = "DAP: toggle UI" },
      { "<leader>dc", function() require("dap").continue() end,             desc = "DAP: continue" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end,    desc = "DAP: toggle breakpoint" },
      { "<leader>dr", function() require("dap").repl.open() end,            desc = "DAP: open REPL" },
      { "<leader>ds", function() require("dap").step_over() end,            desc = "DAP: step over" },
      { "<leader>di", function() require("dap").step_into() end,            desc = "DAP: step into" },
    },
    config = function()
      require("dapui").setup()
    end,
  },
}
