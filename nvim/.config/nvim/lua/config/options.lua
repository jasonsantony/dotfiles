-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- normal mode timeout delay
vim.o.timeout = true
vim.o.timeoutlen = 300

-- insert mode timeout delay
vim.o.ttimeout = true
vim.o.ttimeoutlen = 300

vim.opt.guicursor = table.concat({
  "a:blinkon0", -- default: no blinking
  "n-v-c-sm:block", -- block in normal/visual/command
  "i-ci-ve:ver35-blinkwait200-blinkon500-blinkoff300", -- blink in insert
  "r-cr:hor20-blinkwait200-blinkon500-blinkoff300", -- blink in replace
  "t:ver25-blinkwait200-blinkon500-blinkoff300", -- blink in :terminal
}, ",")
