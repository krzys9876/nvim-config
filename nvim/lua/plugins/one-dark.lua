-- color scheme
return {
  "olimorris/onedarkpro.nvim",
  priority = 1000, -- Ensure it loads first
  config = function()
    -- somewhere in your config:
    vim.cmd("colorscheme onedark")
  end,
}
