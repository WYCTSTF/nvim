return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "moll/vim-bbye",
  },
  event = "VeryLazy",
  keys = {
    { "<C-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<C-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "<C-]>", ":b#<cr>", desc = "Last Buffer" },
    { "<C-w>", ":Bdelete!<cr>", desc = "close current Buffer" },
  },
  opts = {
    options = {
      -- close_command = function(n) vim.ui.bufremove(n) end,
      -- right_mouse_command = function(n) vim.ui.bufremove(n) end,
      close_command = "Bdelete! %d",
      right_mouse_command = "Bdelete! %d",
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
  -- config = function(_, opts)
  --   require("bufferline").setup(opts)
  --   vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
  --     callback = function()
  --       vim.schedule(function()
  --         pcall(nvim_bufferline)
  --       end)
  --     end,
  --   })
  -- end,
}
