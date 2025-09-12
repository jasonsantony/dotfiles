-- For `plugins/markview.lua` users.
return {
  "OXY2DEV/markview.nvim",
  lazy = false,

  -- For `nvim-treesitter` users.
  priority = 49,

  -- For blink.cmp's completion
  dependencies = {
    "saghen/blink.cmp",
  },

  -- Presets
  config = function()
    local headings = require("markview.presets").headings
    local tables = require("markview.presets").tables
    local hrules = require("markview.presets").horizontal_rules

    require("markview").setup({
      html = { enable = false },

      markdown = {
        headings = headings.glow, -- preset for headings
        tables = tables.rounded, -- preset for tables
        horizontal_rules = hrules.thin, -- preset for horizontal rules
      },

      preview = {
        raw_previews = {
          -- Don’t hide Markdown symbols inside tables
          markdown = { "tables" },

          markdown_inline = {},
          html = {},
          latex = {},
          typst = {},
          yaml = {},
        },
      },
    })
  end,
}
