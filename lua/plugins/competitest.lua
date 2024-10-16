return {
  'xeluxee/competitest.nvim',
  lazy = false,
  dependencies = 'MunifTanjim/nui.nvim',
  config = function()
    require('competitest').setup({
      compile_command = {
        c = { exec = "clang", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT)", "-std=c++17", "-DLOCAL" } },
        cpp = { exec = "clang++", args = { "-Wall", "$(FNAME)", "-o", "$(FNOEXT)", "-std=c++17", "-DLOCAL" } },
      },
    })
  end,
}
