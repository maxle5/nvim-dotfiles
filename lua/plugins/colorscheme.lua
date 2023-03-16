local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- set bg transparent after colorscheme loads
vim.api.nvim_create_autocmd("ColorScheme", {
  group = augroup("user_colors"),
  callback = function()
    vim.cmd("highlight Normal ctermbg=NONE guibg=NONE")
  end
})

return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim", },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
} 
