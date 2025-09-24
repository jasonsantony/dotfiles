return {
    "xiyaowong/transparent.nvim",
    lazy = false, -- load early so it applies to highlights
    config = function()
        require("transparent").setup({
            groups = { -- default groups
                "Normal",
                "NormalNC",
                "Comment",
                "Constant",
                "Special",
                "Identifier",
                "Statement",
                "PreProc",
                "Type",
                "Underlined",
                "Todo",
                "String",
                "Function",
                "Conditional",
                "Repeat",
                "Operator",
                "Structure",
                "LineNr",
                "NonText",
                "SignColumn",
                "CursorLine",
                "CursorLineNr",
                -- "StatusLine",
                "EndOfBuffer",
            },
            extra_groups = {
                -- plugin UIs you want transparent
                "NeoTreeNormal",
                "NeoTreeNormalNC",
                "NvimTreeNormal",
                "NvimTreeNormalNC",
                "NormalFloat",
                "FloatBorder",
                "NormalFloat",
                "FloatBorder",
                "WhichKeyNormal",
                "WhichKeyBorder",
                "WhichKeyFloat",
            },
            exclude_groups = {}, -- you can keep some groups opaque
        })
    end,
}
