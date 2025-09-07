-- ~/.config/nvim/lua/plugins/persistence.lua
return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},

  keys = {
    {
      "<leader>qS",
      function()
        require("utils.session-picker").session_picker()
      end,
      desc = "Select/Delete session",
    },
  },
}
