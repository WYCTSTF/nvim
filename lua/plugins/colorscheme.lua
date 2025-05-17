return {
  {
    'NAlexPear/Spacegray.nvim'
  },
  {
    'projekt0n/github-nvim-theme',
    priority = 10,
    after = "xiyaowong/transparent.nvim",
    config = function()
      pcall(vim.cmd, "colorscheme spacegray")
      -- pcall(vim.cmd, "highlight Normal guifg=#000000 guibg=#FFFFFF")
      -- pcall(vim.cmd, "highlight Normal guibg=NONE ctermbg=NONE")
    end
  }
}
