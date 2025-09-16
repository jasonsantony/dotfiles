-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- General indentation settings
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Markdown-specific overrides (2 spaces for lists)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

-- normal mode timeout delay
vim.opt.timeout = true
vim.opt.timeoutlen = 200

-- insert mode timeout delay
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 200

-- Enable truecolor in Neovim
vim.opt.termguicolors = true

-- Cursor settings
vim.opt.guicursor = table.concat({
    "a:blinkon0", -- default: no blinking
    "n-v-c-sm:block", -- block in normal/visual/command
    "i-ci-ve:ver35-blinkwait200-blinkon500-blinkoff300", -- blink in insert
    "r-cr:hor20-blinkwait200-blinkon500-blinkoff300", -- blink in replace
    "t:ver25-blinkwait200-blinkon500-blinkoff300", -- blink in :terminal
}, ",")
