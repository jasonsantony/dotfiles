-- Enable truecolor in Neovim
vim.opt.termguicolors = true

-- Transparency
vim.cmd([[
  augroup TransparentBackground
    autocmd!
    autocmd ColorScheme * highlight Normal ctermbg=none guibg=none
    autocmd ColorScheme * highlight NonText ctermbg=none guibg=none
  augroup END
]])

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
