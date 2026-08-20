return {
  "metalelf0/black-metal-theme-neovim",
  lazy = false,
  priority = 1000,
  config = function()
    require("black-metal").setup({
      -- optional configuration here, e.g.:
      theme = "venom",
      trve = true, -- switch this to false if you want light variants
    })
    require("black-metal").load()
  end,
}
