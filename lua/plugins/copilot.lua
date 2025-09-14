return {
  "github/copilot.vim",
  config = function()
    -- Disable default Tab mapping to avoid conflict with nvim-cmp
    vim.g.copilot_no_tab_map = true
    
    -- Enable Copilot by default
    vim.g.copilot_enabled = true
    
    -- Set filetypes where Copilot should be enabled
    vim.g.copilot_filetypes = {
      ["*"] = false,
      ["javascript"] = true,
      ["typescript"] = true,
      ["lua"] = true,
      ["python"] = true,
      ["rust"] = true,
      ["go"] = true,
      ["cpp"] = true,
      ["c"] = true,
      ["java"] = true,
      ["html"] = true,
      ["css"] = true,
      ["json"] = true,
      ["yaml"] = true,
      ["markdown"] = true,
    }
  end
}
