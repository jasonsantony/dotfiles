local function greeting()
  local hour = tonumber(vim.fn.strftime("%H"))
  -- [02:00, 10:00) - morning, [10:00, 18:00) - day, [18:00, 02:00) - evening
  local part_id = math.floor((hour + 6) / 8) + 1
  local day_part = ({ "evening", "morning", "afternoon", "evening" })[part_id]
  local username = os.getenv("USER") or os.getenv("USERNAME") or "user"
  return ("Good %s, %s"):format(day_part, username)
end

return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      width = 18,
      preset = {
        keys = {
          { icon = "", key = "f", desc = " ̲find file", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = "", key = "n", desc = " ̲new file", action = ":ene | startinsert" },
          { icon = "", key = "g", desc = " ̲grep text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = "", key = "r", desc = " ̲recent file", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = "",
            key = "c",
            desc = " ̲config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = "", key = "s", desc = " ̲session", section = "session" },
          { icon = "", key = "L", desc = " ̲Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = "", key = "q", desc = " ̲quit", action = ":qa" },
        },
        header = table.concat({
          [[
                                                                   
      ████ ██████           █████      ██                 btw
     ███████████             █████                            
     █████████ ███████████████████ ███   ███████████  
    █████████  ███    █████████████ █████ ██████████████  
   █████████ ██████████ █████████ █████ █████ ████ █████  
 ███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████
]],
          "", -- blank line for spacing
          greeting(), -- <== your function result goes here
        }, "\n"),
      },
      formats = {
        key = { "" },
      },
    },
  },
}
