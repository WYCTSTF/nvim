return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  keys = {
    {
      "<A-m>",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.fn.getcwd() })
      end,
      desc = "Explorer NeoTree (Root Dir)",
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
      desc = "Start Neo-tree with directory",
      once = true,
      callback = function()
        if package.loaded["neo-tree"] then
          return
        end

        local path = vim.fn.argv(0)
        if path == "" then
          path = vim.fn.getcwd()
        end

        local stats = vim.uv.fs_stat(path)
        if stats and stats.type == "directory" then
          local status, neo_tree = pcall(require, "neo-tree")
          if not status then
            vim.notify("无法加载 neo-tree: " .. neo_tree, vim.log.levels.ERROR)
            return
          end
          neo_tree.setup({
            sources = { "filesystem", "buffers", "git_status" },
            open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
            filesystem = {
              bind_to_cwd = false,
              follow_current_file = { enabled = true },
              use_libuv_file_watcher = true,
            },
            default_component_configs = {
              indent = {
                with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
              },
              git_status = {
                symbols = {
                  unstaged = "󰄱",
                  staged = "󰱒",
                },
              },
            },
          })
        end
      end,
    })
  end,
}
