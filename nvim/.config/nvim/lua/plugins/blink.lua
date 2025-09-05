return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = {
          auto_show = false, -- Never auto-popup in any file
        },
      },
    },
    config = function(_, opts)
      local blink = require("blink.cmp")
      blink.setup(opts)

      -- Manual trigger with <C-Space>
      vim.keymap.set("i", "<C-Space>", function()
        blink.show()
      end, { desc = "Manual Blink completion trigger" })
    end,
  },
}
