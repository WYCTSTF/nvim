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

-- 根据操作系统设置undodir
if is_windows() then
  set.undodir = vim.fn.expand("~/.vim/undodir")
else
  set.undodir = "/home/syh/.vim/undodir"
end

-- 根据操作系统设置Python路径
if is_windows() then
  -- Windows系统，尝试常见的Python路径
  local python_paths = {
    vim.fn.expand("D:/Program Files/miniconda/python.exe"),
  }
  
  for _, path in ipairs(python_paths) do
    if vim.fn.executable(path) == 1 then
      vim.g.python3_host_prog = path
      break
    end
  end
elseif is_mac() then
  -- macOS系统
  local python_paths = {
    "/opt/homebrew/Caskroom/miniconda/base/bin/python",  -- 如果使用相同的conda环境
  }
  
  for _, path in ipairs(python_paths) do
    if vim.fn.executable(path) == 1 then
      vim.g.python3_host_prog = path
      break
    end
  end
else
  -- Linux系统
  vim.g.python3_host_prog = '/home/syh/miniconda3/bin/python'
end

-- set.clipboard='unnamedplus'
