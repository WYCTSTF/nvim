return {
  "linux-cultist/venv-selector.nvim",
  ft = 'python',
  dependencies = {
    "neovim/nvim-lspconfig",
    "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
    { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
  },
  branch = "main",
  -- 不自定义 search:插件自带按 OS 区分的默认搜索
  -- (~/miniconda3、~/.virtualenvs、pyenv、poetry、项目 .venv 等),conda 装到
  -- 默认位置即可被自动发现,各平台无需硬编码路径
  config = function()
    require("venv-selector").setup({})
  end,
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>" },
  },
}
