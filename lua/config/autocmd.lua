-- 设置 jq 作为 JSON 文件的格式化程序
vim.api.nvim_exec([[
  autocmd FileType json setlocal formatprg=jq\ .
]], false)

-- 使用js-beautify进行格式化
vim.api.nvim_exec([[
  autocmd FileType javascript,typescript,json setlocal formatprg=js-beautify\ --stdin
]], false)
