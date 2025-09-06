return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      trigger = {
        -- never show while typing
        show_on_insert = false,
        -- never show when typing trigger chars like "." or ":"
        show_on_trigger_character = false,
        -- never show on keywords
        show_on_keyword = false,
      },
    },
    keymap = {
      ["<C-Space>"] = { "show" }, -- only way to open menu
      ["<C-n>"] = { "select_next" },
      ["<C-p>"] = { "select_prev" },

      ["<Tab>"] = { "accept", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<CR>"] = {}, -- unbind Enter
    },
  },
}
