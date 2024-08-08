return {
  'stevearc/quicker.nvim',
  opts = {},
  config = function()
    vim.keymap.set("n", "<leader>q", function()
      require('quicker').toggle()
    end, {
      desc = "Toggle quickfix",
    })
  end,
}
