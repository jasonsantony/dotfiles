return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      trigger = {
        show_on_insert = false,
        show_on_trigger_character = false,
        show_on_keyword = false,
      },
    },
    keymap = {
      -- Toggle menu with Ctrl+Space
      ["<C-Space>"] = {
        function(cmp)
          if cmp.is_visible() then
            return cmp.hide()
          else
            return cmp.show()
          end
        end,
      },
      -- Some terminals send Ctrl+Space as <C-@>; bind both if needed
      -- ["<C-@>"] = { function(cmp) return cmp.is_visible() and cmp.hide() or cmp.show() end },

      ["<C-n>"] = { "select_next", "fallback_to_mappings" },
      ["<C-p>"] = { "select_prev", "fallback_to_mappings" },

      ["<Tab>"] = { "accept", "snippet_forward", "fallback" },

      ["<CR>"] = false, -- unbind Enter from selecting
      ["<S-Tab>"] = false, -- unbind Shift-Tab from selecting previous
    },
  },
}
