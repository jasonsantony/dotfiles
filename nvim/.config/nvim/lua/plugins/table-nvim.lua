-- lua/plugins/table-nvim.lua
return {
  {
    "kdheepak/table-nvim",
    ft = { "markdown" },
    opts = {
      mappings = {
        next = "<C-n>", -- was <Tab>
        prev = "<C-p>", -- was <S-Tab>
      },
    },
  },
}
