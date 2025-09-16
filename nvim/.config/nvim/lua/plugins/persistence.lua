return {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
        -- swap: make lowercase s run the picker
        {
            "<leader>qs",
            function()
                require("utils.session-picker").session_picker()
            end,
            desc = "Sessions",
        },
        -- swap: make uppercase S restore current dir session
        {
            "<leader>qS",
            function()
                require("persistence").load()
            end,
            desc = "Restore session for cwd",
        },
    },
}
