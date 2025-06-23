return {
  "olimorris/codecompanion.nvim",
  event = "VimEnter",
  opts = {
    strategies = {
      chat = {
        adapter = "copilot",
      },
      inline = {
        adapter = "copilot",
      },
    }
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    { "<leader>cc", "<cmd>CodeCompanion<cr>", desc = "Code Companion" },
    { "<leader>ci", "<cmd>CodeCompanionInline<cr>", desc = "Code Companion Inline" },
    { "<C-I>", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Code Companion Chat" },
  }
}
