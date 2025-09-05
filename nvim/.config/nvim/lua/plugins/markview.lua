return {
  {
    "OXY2DEV/markview.nvim",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter", lazy = false },
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
      require("markview").setup({
        experimental = {
          check_rtp_message = false,
        },
        code_blocks = {
          enable_highlighting = true,
        },
      })
    end,
  },
}
