return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    require('telescope').setup {
      defaults = {
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            height = 0.9,
            preview_cutoff = 0,
            width = 0.9,
          },
        },
        file_ignore_patterns = { 
          "node_modules" 
        }
      },
      pickers = {
        find_files = {
          theme = 'ivy',
          -- no_ignore = true,
        }
      }
    }
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    -- pcall(require('telescope').load_extension, 'rest')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    -- local rest = require("telescope").extensions.rest
    -- vim.keymap.set('n', '<leader>fh', builtin.help_tags)
    -- vim.keymap.set('n', '<leader>fk', builtin.keymaps)
    vim.keymap.set('n', '<leader>ff', builtin.find_files)
    -- vim.keymap.set('n', '<leader>fs', builtin.builtin)
    -- vim.keymap.set('n', '<leader>fw', builtin.grep_string)
    vim.keymap.set('n', '<leader>fg', builtin.live_grep)
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics)
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles)
    vim.keymap.set('n', '<leader>fn', ":Telescope notify<cr>")
    -- vim.keymap.set('n', '<leader>fr', rest.select_env)
    -- vim.keymap.set('n', '<leader>fr', builtin.resume)
    -- vim.keymap.set('n', '<leader>f.', builtin.oldfiles)
    vim.keymap.set('n', '<leader><leader>', builtin.buffers)

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end)

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>f/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end)

    -- Shortcut for searching your Neovim configuration files
    -- vim.keymap.set('n', '<leader>fn', function()
    --   builtin.find_files { cwd = vim.fn.stdpath 'config' }
    -- end)
  end,
}
