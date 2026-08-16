-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Esc remap
vim.keymap.set("i", "jk", "<Esc>")

-- Normal mode: indent/unindent but keep cursor in place
vim.keymap.set("n", "<Tab>", ">>_", { noremap = true, silent = true, desc = "Indent line" })
vim.keymap.set("n", "<S-Tab>", "<<_", { noremap = true, silent = true, desc = "Unindent line" })

-- Make <leader><space> open Snacks buffer picker
vim.keymap.set("n", "<leader><space>", function()
  Snacks.picker.buffers()
end, { desc = "Buffers" })

-- WinShift
vim.keymap.set("n", "<C-S-h>", "<Cmd>WinShift left<CR>", { desc = "Move window left" })
vim.keymap.set("n", "<C-S-j>", "<Cmd>WinShift down<CR>", { desc = "Move window down" })
vim.keymap.set("n", "<C-S-k>", "<Cmd>WinShift up<CR>", { desc = "Move window up" })
vim.keymap.set("n", "<C-S-l>", "<Cmd>WinShift right<CR>", { desc = "Move window right" })
