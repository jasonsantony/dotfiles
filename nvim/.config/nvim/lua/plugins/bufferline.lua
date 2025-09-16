return {
    {
        "akinsho/bufferline.nvim",
        opts = {
            options = {
                numbers = "none", -- no numbers
                indicator = { style = "underline" }, -- active buffer underlined
                show_buffer_close_icons = false, -- no per-buffer ❌
                show_close_icon = false, -- redundant in buffers mode
                diagnostics = "nvim_lsp", -- show LSP diagnostics
            },
        },
    },
}
