return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
    },
    config = function(_, opts)
      local cmp = require("cmp")

      -- Keep LazyVim’s defaults
      cmp.setup(opts)

      -- Enable path + cmdline completion for ":"
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path", option = { trailing_slash = true } },
        }, {
          { name = "cmdline", option = { treat_trailing_slash = false } },
        }),
      })
    end,
  },
}
