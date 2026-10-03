return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main", -- nvim 0.12+ 配套的新分支(旧 configs.setup/ensure_installed API 已移除)
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")
    ts.setup() -- 解析器默认装到 stdpath("data")/site

    -- 补装缺失的解析器(异步,已装的自动跳过)
    ts.install({
      "bash",
      "c",
      "cpp",
      "java",
      "lua",
      "json",
      "asm",
      "cmake",
      "css",
      "csv",
      "cuda",
      "fish",
      "gitignore",
      "go",
      "haskell",
      "html",
      "javascript",
      "llvm",
      "luadoc",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "sql",
      "ssh_config",
      "vim",
      "vimdoc",
      "vue",
      "yaml",
      "xml",
    })

    -- main 分支不再有 highlight.enable / indent.enable:
    -- 对有解析器的文件类型启用 treesitter 高亮 + 实验性缩进
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        -- get_parser 在 0.12 改为返回 nil 而非抛错,守卫要包在 start 上
        if lang and pcall(vim.treesitter.start, args.buf, lang) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
