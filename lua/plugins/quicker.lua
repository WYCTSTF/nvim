return {
  'stevearc/quicker.nvim',
  opts = {},
  config = function()
    vim.keymap.set("n", "<leader>q", function()
      vim.diagnostic.setloclist()
    end, {
      desc = "Toggle quickfix",
    })
  end,
}
