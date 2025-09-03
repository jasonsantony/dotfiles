return {
  {
    "ishan9299/nvim-solarized-lua",
    lazy = false, -- load immediately
    priority = 1000, -- make sure it loads before other colorschemes
    config = function()
      vim.opt.termguicolors = true
      vim.o.background = "light" -- choose the light variant
      vim.cmd.colorscheme("solarized") -- apply solarized
    end,
  },
}
