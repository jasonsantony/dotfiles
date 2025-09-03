return {
  "akinsho/bufferline.nvim",
  version = "*",
  opts = {
    options = {
      numbers = "ordinal",
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_buffer_icons = false, -- ⬅ disables icons
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)

    -- VS Code–style navigation
    for i = 1, 8 do
      vim.keymap.set("n", "<C-" .. i .. ">", "<Cmd>BufferLineGoToBuffer " .. i .. "<CR>", { silent = true })
    end
    vim.keymap.set("n", "<C-9>", "<Cmd>BufferLineGoToBuffer -1<CR>", { silent = true })

    -- Ctrl+Tab / Ctrl+Shift+Tab cycling
    vim.keymap.set("n", "<C-Tab>", "<Cmd>BufferLineCycleNext<CR>", { silent = true })
    vim.keymap.set("n", "<C-S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { silent = true })
  end,
}
