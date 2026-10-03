return {
  -- ★ 仍然需要 nvim-lspconfig 提供默认配置
  "neovim/nvim-lspconfig",

  dependencies = {
    { "mason-org/mason.nvim",          opts = {} }, -- v2+
    "hrsh7th/cmp-nvim-lsp", -- 供下方 vim.lsp.config("*") 合并 capabilities 用
    { "mason-org/mason-lspconfig.nvim", opts = {} }, -- 自动 enable LSP
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} },
  },

  config = function()
    ------------------------------------------------------------------
    -- 1. Mason —— 安装服务器 / 工具
    ------------------------------------------------------------------
    require("mason").setup()

    require("mason-tool-installer").setup {
      ensure_installed = {
        -- LSP
        "lua_ls",
        "jdtls",
        -- 其他 CLI 工具
        "stylua",
      },
    }

    ------------------------------------------------------------------
    -- 2. 全局 LSP 覆写（对所有服务器生效）
    ------------------------------------------------------------------
    vim.lsp.config("*", {
      -- 合并 cmp 的 capabilities:不合并的话服务器认为客户端不支持 snippet/labelDetails,
      -- 补全会降级成纯文本(上方已声明 cmp-nvim-lsp 依赖,保证此刻可 require)
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })    ------------------------------------------------------------------
    -- 3. 逐服务器配置
    ------------------------------------------------------------------
    -- 操作系统检测函数
    local function is_windows()
      return vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1
    end

    local function is_mac()
      return vim.fn.has('macunix') == 1
    end

    -- clangd：优先取 PATH 里的(自动适配各平台),PATH 上没有时
    -- 再退回各平台已知的安装位置
    local clangd_config = {
      root_markers = { ".clangd", "compile_commands.json", ".git" },
    }

    local clangd_exe = vim.fn.exepath("clangd")
    if clangd_exe ~= "" then
      clangd_config.cmd = { clangd_exe }
    elseif is_windows() then
      clangd_config.cmd = {
        "D:/Program Files/llvm-mingw-20250528-ucrt-x86_64/bin/clangd.exe",
        "--query-driver=D:/Program Files/llvm-mingw-20250528-ucrt-x86_64/bin/clang*.exe",
        "--header-insertion=never", -- 禁用自动插入头文件
      }
    elseif is_mac() then
      -- homebrew 的 llvm 是 keg-only,不在 PATH 上,需要显式路径
      clangd_config.cmd = {
        "/opt/homebrew/opt/llvm/bin/clangd",
        "--query-driver=/opt/homebrew/opt/llvm/bin/clang*",
      }
    else
      clangd_config.cmd = { "clangd" }
    end

    vim.lsp.config("clangd", clangd_config)

    -- lua-language-server：让 'vim' 不再被诊断为未定义
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          completion = { callSnippet = "Replace" },
          diagnostics = { globals = { "vim" } },
        },
      },
    })

    -- pyright → delance（Pylance）替身
    vim.lsp.config("pyright", {
      cmd = { "delance-langserver", "--stdio" },
      root_dir = vim.fn.getcwd(), -- 简单粗暴：始终使用当前目录
    })

    -- 其余服务器可继续追加...
    ------------------------------------------------------------------
    -- 4. 启用服务器
    --    * 若只想手动控制，关闭 mason-lspconfig 的自动启用：
    --        require("mason-lspconfig").setup { automatic_enable = false }
    --      然后改用 vim.lsp.enable({...}) 自己启用
    ------------------------------------------------------------------
    -- 这里交给 mason-lspconfig 自动处理，无须再写 vim.lsp.enable()

    ------------------------------------------------------------------
    -- 5. LspAttach：按需绑定按键 / 特性
    ------------------------------------------------------------------
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("vim-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func)
          vim.keymap.set("n", keys, func, { buffer = event.buf })
        end
        local builtin = require("telescope.builtin")
        map("gd", builtin.lsp_definitions)
        map("gD", vim.lsp.buf.declaration)
        map("gr", builtin.lsp_references)
        map("gI", builtin.lsp_implementations)
        map("<leader>rn", vim.lsp.buf.rename)
        map("<leader>ca", vim.lsp.buf.code_action)
        -- vim.diagnostic.goto_prev/goto_next 已弃用(0.13 移除),统一用 jump
        map("gk", function() vim.diagnostic.jump({ count = -1, float = true }) end)
        map("gj", function() vim.diagnostic.jump({ count = 1, float = true }) end)

        ----------------------------------------------------------------
        -- documentHighlight / inlay hints
        ----------------------------------------------------------------
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method("textDocument/documentHighlight") then
          local hl = vim.api.nvim_create_augroup("vim-lsp-highlight", { clear = true })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            group = hl,
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            group = hl,
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end

        if client and client:supports_method("textDocument/inlayHint") then
          map("<leader>th", function()
            local bufnr = event.buf
            vim.lsp.inlay_hint.enable(
              not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr },
              { bufnr = bufnr }
            )
          end)
        end
      end,
    })
  end,
}
