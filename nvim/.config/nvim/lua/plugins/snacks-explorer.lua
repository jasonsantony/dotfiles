return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true, -- show dotfiles
          ignored = true, -- include gitignored files
          layout = { preview = true },
          win = {
            list = {
              keys = {
                ["."] = "tcd",
              },
            },
          },
        },
      },
    },
  },
}
