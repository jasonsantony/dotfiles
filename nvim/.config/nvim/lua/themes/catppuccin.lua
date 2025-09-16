return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
        integrations = {
            bufferline = true, -- enable bufferline integration
        },
    },

    -- Bufferline fix
    config = function(_, opts)
        require("catppuccin").setup(opts)

        -- Shim: make LazyVim's colorscheme.lua happy
        local ok, bufferline = pcall(require, "catppuccin.groups.integrations.bufferline")
        if ok and bufferline.get_theme and not bufferline.get then
            bufferline.get = bufferline.get_theme
        end
    end,
}
