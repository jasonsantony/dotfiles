-- Enable truecolor in Neovim
-- vim.opt.termguicolors = true

-- Transparency
-- vim.cmd([[
--   augroup TransparentBackground
--     autocmd!
--     autocmd ColorScheme * highlight Normal ctermbg=none guibg=none
--     autocmd ColorScheme * highlight NonText ctermbg=none guibg=none
--   augroup END
-- ]])

-- Esc remap
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })
vim.opt.timeoutlen = 200

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
