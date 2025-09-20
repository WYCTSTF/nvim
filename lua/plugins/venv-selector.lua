return {
  "linux-cultist/venv-selector.nvim",
  ft = 'python',
  dependencies = {
    "neovim/nvim-lspconfig", 
    "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  -- branch = "regexp", -- This is the regexp branch, use this for the new version
  branch = "main",
  config = function()
    require("venv-selector").setup( {
      settings = {
        search = {
          my_envs = {
            command = "fd python$ /opt/homebrew/Caskroom/miniconda/base"
          },
        },
      },
    })
  end,
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>" },
  },
}
