-- lua/plugins/lualine-rounded.lua
return {
    {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
            ------------------------------------------------------------------+
            -- 1. Global lualine options (remove all built-in separators)     |
            ------------------------------------------------------------------+
            opts.options = {
                theme = "auto",
                globalstatus = true, -- one bar for all windows
                section_separators = { "", "" },
                component_separators = { "", "" },
            }

            ------------------------------------------------------------------+
            -- 2. Normal buffers: only outer edges get rounded glyphs         |
            ------------------------------------------------------------------+
            opts.sections = {
                lualine_a = {
                    { "mode", separator = { left = "" }, right_padding = 1 },
                },
                lualine_b = { "branch" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "filetype" },
                lualine_y = { "progress" },
                lualine_z = {
                    {
                        function()
                            return " " .. os.date("%R")
                        end,
                        separator = { right = "" },
                        left_padding = 1,
                    },
                },
            }

            ------------------------------------------------------------------+
            -- 3. Lazy-UI screen: keep its “Lazy … loaded” block,             |
            --    just wrap outer edges with the same rounded glyphs          |
            ------------------------------------------------------------------+
            opts.extensions = {
                {
                    filetypes = { "lazy" },
                    section_separators = { "", "" },
                    component_separators = { "", "" },
                    sections = {
                        lualine_a = {
                            { "lazy", separator = { left = "" }, right_padding = 1 },
                        },
                        lualine_z = {
                            {
                                function()
                                    return " " .. os.date("%R")
                                end,
                                separator = { right = "" },
                                left_padding = 1,
                            },
                        },
                    },
                },
            }
        end,
    },
}
