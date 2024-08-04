return { 
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = function()
    return {
      indent = {
        highlight = highlight
      },
      scope = {
        show_start = false,
        show_end = false
      },
      exclude = {
        filetypes = {
          "help",
          "dashboard",
          "neo-tree",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
        },
      },
    }
  end,
}
