-- 设置 jq 作为 JSON 文件的格式化程序
vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function()
    vim.opt_local.formatprg = "jq ."
  end,
})

-- 使用js-beautify进行格式化
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript" },
  callback = function()
    vim.opt_local.formatprg = "js-beautify --stdin"
  end,
})
