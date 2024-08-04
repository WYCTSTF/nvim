return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<C-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<C-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "<C-w>", ":bdelete!<cr>", desc = "close current Buffer" },
  },
  opts = {
    options = {
      close_command = function(n) vim.ui.bufremove(n) end,
      right_mouse_command = function(n) vim.ui.bufremove(n) end,
      always_show_bufferline = false,
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-Tree",
          highlight = "Directory",
          text_align = "left",
        },
      },
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)
    vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
