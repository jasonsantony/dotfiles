-- Always default to light unless the picked theme says otherwise
vim.o.background = "light"

-- 1) All installed theme plugins (current three). Add more later as new files.
return {
  require("themes.solarized"),
  require("themes.rose_pine"),
  require("themes.catppuccin"),

  -- 2) Easy picking/cycling (supports light/dark)
  {
    "LazyVim/LazyVim",
    opts = (function()
      -- define all presets (light + dark) here
      local THEMES = {
        solarized_light = { scheme = "solarized", background = "light" },
        solarized_dark = { scheme = "solarized", background = "dark" },

        rose_pine_dawn = { scheme = "rose-pine-dawn" }, -- light variant name
        rose_pine_moon = { scheme = "rose-pine-moon" }, -- dark variant name

        catppuccin_latte = { scheme = "catppuccin-latte" }, -- light
        catppuccin_frappe = { scheme = "catppuccin-frappe" }, -- dark
      }

      -- choose your default here (one line)
      local DEFAULT_KEY = "rose_pine_moon"
      local default = THEMES[DEFAULT_KEY]

      -- runtime commands
      vim.api.nvim_create_user_command("ThemePick", function(opts)
        local t = THEMES[opts.args]
        if not t then
          vim.notify("Unknown theme: " .. opts.args, vim.log.levels.ERROR)
          return
        end
        if t.background then
          vim.o.background = t.background
        end
        vim.cmd.colorscheme(t.scheme)
        vim.g._theme_key = opts.args
        vim.notify("Theme: " .. opts.args, vim.log.levels.INFO)
      end, {
        nargs = 1,
        complete = function()
          local keys = {}
          for k, _ in pairs(THEMES) do
            table.insert(keys, k)
          end
          table.sort(keys)
          return keys
        end,
      })

      vim.api.nvim_create_user_command("ThemeCycle", function()
        local order = {
          "solarized_light",
          "rose_pine_dawn",
          "catppuccin_latte",
          "solarized_dark",
          "rose_pine_moon",
          "catppuccin_frappe",
          -- add new keys here to include them in cycling order
          -- "gruvbox_dark",
          -- "tokyonight_night",
        }
        local cur = vim.g._theme_key or DEFAULT_KEY
        local idx = 1
        for i, k in ipairs(order) do
          if k == cur then
            idx = i
            break
          end
        end
        local nextkey = order[(idx % #order) + 1]
        vim.cmd("ThemePick " .. nextkey)
      end, {})

      -- LazyVim default on startup (applies before UI plugins)
      if default.background then
        vim.o.background = default.background
      end
      return { colorscheme = default.scheme }
    end)(),
  },
}
