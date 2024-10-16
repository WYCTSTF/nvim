return {
  {
    'NAlexPear/Spacegray.nvim'
  },
  {
    'projekt0n/github-nvim-theme',
    priority = 52,
    config = function()
      pcall(vim.cmd, "colorscheme github_dark")
      -- pcall(vim.cmd, "highlight Normal guifg=#000000 guibg=#FFFFFF")
      -- pcall(vim.cmd, "highlight Normal guibg=NONE ctermbg=NONE")
    end
  }
}
