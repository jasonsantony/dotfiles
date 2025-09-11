-- Enable truecolor in Neovim
vim.opt.termguicolors = true

-- Esc remap
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode with jk" })
vim.opt.timeoutlen = 200

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
