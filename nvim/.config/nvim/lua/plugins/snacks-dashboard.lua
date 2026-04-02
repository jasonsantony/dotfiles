return {
    "folke/snacks.nvim",
    opts = {
        dashboard = {
            width = 22,
            preset = {
                keys = {
                    { icon = "", key = "f", desc = "find file", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = "", key = "n", desc = "new file", action = ":ene | startinsert" },
                    { icon = "", key = "g", desc = "grep text", action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = "", key = "r", desc = "recent files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    {
                        icon = "",
                        key = "c",
                        desc = "config",
                        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                    },

                    {
                        icon = "",
                        key = "l",
                        desc = "lazy",
                        action = ":Lazy",
                        enabled = package.loaded.lazy ~= nil,
                    },

                    {
                        icon = "",
                        key = "x",
                        desc = "extras",
                        action = ":LazyExtras",
                    },

                    { icon = "", key = "q", desc = "quit", action = ":qa" },
                },
                header = table.concat({
                    [[
                                                                          
  I use ████ ██████           █████      ██                         
       ███████████             █████                                 
       █████████ ███████████████████ ███   ███████████       
      █████████  ███    █████████████ █████ ██████████████       
     █████████ ██████████ █████████ █████ █████ ████ █████       
   ███████████ ███    ███ █████████ █████ █████ ████ █████      
  ██████  █████████████████████ ████ █████ █████ ████ ██████ btw 
]],
                    "", -- blank line for spacing
                    '"Man fears the darkness, and so he scrapes away at the edges of it with fire"',
                    "「人は闇を恐れ、火を使い、闇を削って生きてきたわ」",
                }, "\n"),
            },
            formats = {
                key = { " %s " },
            },
        },
    },
}
