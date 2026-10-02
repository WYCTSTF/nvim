vim.g.mapleader = ';'
vim.g.localmapleader = ';'

local set = vim.opt
-- cursor can be positioned where there is no actual character.
-- set.virtualedit = 'all'
set.showbreak = '↪'
set.nu = true
set.rnu = true
set.ts = 2
set.sw = 2
set.scrolloff = 5
set.autoread = true
set.incsearch = true
set.whichwrap = '<,>,[,]'
set.backspace = { 'indent', 'eol', 'start' }
set.backup = false
set.writebackup = false
set.swapfile = false
set.mouse = ""
set.termguicolors = true
set.wildmenu = true
set.showmode = false
set.pumheight = 10
set.splitbelow = true
set.splitright = true
set.expandtab = true
set.ignorecase = true
set.guicursor = "n-v-c-sm:block,i-ci-ve:hor20,r-cr-o:hor20"

set.timeout = true
-- Time in milliseconds to wait for a mapped sequence to complete.
set.timeoutlen = 400
--  Time in milliseconds to wait for a key code sequence to complete. Also
-- 	used for CTRL-\ CTRL-N and CTRL-\ CTRL-G when part of a command has
-- 	been typed.
set.ttimeoutlen = 400

set.undofile = true

-- 检测操作系统并设置相应的路径
local function is_windows()
  return vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
end

local function is_mac()
  return vim.fn.has('macunix') == 1
end

-- undodir:各平台统一用家目录下的通用位置
local undodir = vim.fn.expand("~/.vim/undodir")
set.undodir = undodir
vim.fn.mkdir(undodir, "p") -- 目录不存在则创建

-- Python 路径:优先取 PATH 里的 python(自动适配 conda/venv 等当前环境),
-- 找不到再退回各平台的 conda 默认安装位置;都没有就不设置,交给 nvim 自行发现
do
  local py = vim.fn.exepath("python3")
  if py == "" then
    py = vim.fn.exepath("python")
  end

  if py == "" then
    local fallbacks = {}
    if is_windows() then
      fallbacks = { vim.fn.expand("~/miniconda3/python.exe") }
    elseif is_mac() then
      fallbacks = { "/opt/homebrew/Caskroom/miniconda/base/bin/python" }
    else
      fallbacks = { vim.fn.expand("~/miniconda3/bin/python") }
    end
    for _, path in ipairs(fallbacks) do
      if vim.fn.executable(path) == 1 then
        py = path
        break
      end
    end
  end

  if py ~= "" then
    vim.g.python3_host_prog = py
  end
end

-- set.clipboard='unnamedplus'
