return {
    {
        "nvim-telescope/telescope.nvim",
        opts = function(_, opts)
            local actions = require("telescope.actions")

            opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
                path_display = { "smart" }, -- trim common prefixes so filename tail stands out
            })

            opts.pickers = vim.tbl_deep_extend("force", opts.pickers or {}, {
                buffers = {
                    sort_mru = true,
                    sort_lastused = true,
                    mappings = {
                        i = { ["<C-d>"] = actions.delete_buffer },
                        n = { ["dd"] = actions.delete_buffer },
                    },
                },
            })

            return opts
        end,

        keys = {
            -- remap <leader><leader> to buffer search
            { "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "Switch Buffer" },
        },
    },
}
