local M = {}

function M.session_picker()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_st = require("telescope.actions.state")

  local session_dir = vim.fn.stdpath("state") .. "/sessions"
  local files = vim.fn.globpath(session_dir, "*.vim", false, true)

  local function humanize(path)
    local fname = vim.fn.fnamemodify(path, ":t")
    local stem = fname:gsub("%.vim$", "")
    local decoded = stem:gsub("%%", "/")
    local home = (vim.uv or vim.loop).os_homedir()
    if decoded:sub(1, #home) == home then
      decoded = "~" .. decoded:sub(#home + 1)
    end
    return decoded
  end

  local finder = finders.new_table({
    results = files,
    entry_maker = function(path)
      local disp = humanize(path)
      return { value = path, ordinal = disp, display = disp }
    end,
  })

  pickers
    .new({}, {
      prompt_title = "Sessions",
      finder = finder,
      sorter = conf.generic_sorter({}),
      previewer = false,
      attach_mappings = function(prompt_bufnr, map)
        local function load_session()
          local entry = action_st.get_selected_entry()
          actions.close(prompt_bufnr)
          if entry and entry.value then
            vim.cmd("silent! source " .. vim.fn.fnameescape(entry.value))
            vim.notify("Loaded session: " .. humanize(entry.value), vim.log.levels.INFO)
          end
        end
        map("i", "<CR>", load_session)
        map("n", "<CR>", load_session)

        local function delete_session()
          local entry = action_st.get_selected_entry()
          if entry and entry.value then
            vim.fn.delete(entry.value)
            vim.notify("Deleted session: " .. humanize(entry.value), vim.log.levels.INFO)
          end
          actions.close(prompt_bufnr)
        end
        map("n", "dd", delete_session)
        map("i", "<C-d>", delete_session)

        return true
      end,
    })
    :find()
end

return M
