return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>n",
      function()
        if Snacks.config.picker and Snacks.config.picker.enabled then
          -- Word wrap in preview
          Snacks.picker.notifications({ win = { preview = { wo = { wrap = true } } } })
        else
          Snacks.notifier.show_history()
        end
      end,
      desc = "Notification History",
    },
  },
}
