local M = {}

-- Turn "%Users%me%proj.vim" into "~/proj"
local function humanize(path)
  if type(path) == "table" and path.value then
    path = path.value
  end
  local fname = vim.fn.fnamemodify(path, ":t")
  local stem = fname:gsub("%.vim$", "")
  local decoded = stem:gsub("%%", "/")
  local home = (vim.uv or vim.loop).os_homedir()
  if decoded:sub(1, #home) == home then
    decoded = "~" .. decoded:sub(#home + 1)
  end
  return decoded
end

-- Collect all session files
local function list_sessions()
  local session_dir = vim.fn.stdpath("state") .. "/sessions"
  return vim.fn.globpath(session_dir, "*.vim", false, true)
end

-- The actual Telescope picker
function M.session_picker()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_st = require("telescope.actions.state")

  local function open_picker(files)
    if #files == 0 then
      vim.notify("No sessions found", vim.log.levels.WARN)
      return
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

          -- ⌥N / ⌥P (Option/Alt) to move selection in insert mode
          map("i", "<M-n>", function()
            actions.move_selection_next(prompt_bufnr)
          end)
          map("i", "<M-p>", function()
            actions.move_selection_previous(prompt_bufnr)
          end)
          -- (Optional) Some setups prefer <A-…> aliases:
          map("i", "<A-n>", function()
            actions.move_selection_next(prompt_bufnr)
          end)
          map("i", "<A-p>", function()
            actions.move_selection_previous(prompt_bufnr)
          end)

          local function delete_session()
            local picker = action_st.get_current_picker(prompt_bufnr)
            local entry = action_st.get_selected_entry()
            if entry and entry.value then
              vim.fn.delete(entry.value)
              vim.notify("Deleted session: " .. humanize(entry.value), vim.log.levels.INFO)

              local new_results = {}
              for _, e in ipairs(picker.finder.results) do
                local val = type(e) == "table" and e.value or e
                if val ~= entry.value then
                  table.insert(new_results, val)
                end
              end

              if #new_results == 0 then
                actions.close(prompt_bufnr)
                vim.notify("No sessions left", vim.log.levels.WARN)
              else
                picker:refresh(
                  finders.new_table({
                    results = new_results,
                    entry_maker = function(path)
                      local disp = humanize(path)
                      return { value = path, ordinal = disp, display = disp }
                    end,
                  }),
                  { reset_prompt = true }
                )
                vim.schedule(function()
                  actions.move_selection_next(prompt_bufnr)
                end)
              end
            end
          end

          map("n", "dd", delete_session)
          map("i", "<C-d>", delete_session)

          return true
        end,
      })
      :find()
  end

  open_picker(list_sessions())
end

return M
