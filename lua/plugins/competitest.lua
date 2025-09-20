return {
  'xeluxee/competitest.nvim',
  lazy = false,
  dependencies = { 'MunifTanjim/nui.nvim' },
  config = function()
    local function get_header_include()
      -- 获取当前文件目录并拼接 '/header'
      local fname = vim.fn.expand("%:p")
      local dir = vim.fn.fnamemodify(fname, ":h")
      return "-I" .. dir .. "/header"
    end

    require('competitest').setup({
      compile_command = {
        c = {
          exec = "clang",
          args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT)", "-std=c++17", "-DLOCAL", get_header_include() }
        },
        cpp = {
          exec = "clang++",
          args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT)", "-std=c++17", "-DLOCAL", get_header_include() }
        },
      },
    })
  end,
}
