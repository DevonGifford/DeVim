return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
  },
  keys = {
    { "<c-h>", "<cmd>TmuxNavigateLeft<cr>",  desc = "Navigate left (tmux/nvim)" },
    { "<c-j>", "<cmd>TmuxNavigateDown<cr>",  desc = "Navigate down (tmux/nvim)" },
    { "<c-k>", "<cmd>TmuxNavigateUp<cr>",    desc = "Navigate up (tmux/nvim)" },
    { "<c-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate right (tmux/nvim)" },
  },
}
