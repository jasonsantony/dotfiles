local M = {}

-- Turn "%Users%me%proj.vim" into "~/proj"
local function humanize(path)
    if type(path) == "table" and path.value then
        path = path.value
    end

    local fname = vim.fn.fnamemodify(path, ":t")
    local stem = fname:gsub("%.vim$", "")
    local decoded = stem:gsub("%%", "/")

    local uv = vim.uv or vim.loop
    local home = uv.os_homedir()

    -- If decoded looks like "Users/me/..." (missing leading slash), fix it.
    -- This matches the example in your comment.
    if decoded:sub(1, 1) ~= "/" and home:sub(1, 1) == "/" then
        -- If home is "/Users/me" and decoded starts with "Users/me", prefix "/"
        local home_no_lead = home:gsub("^/", "")
        if decoded:sub(1, #home_no_lead) == home_no_lead then
            decoded = "/" .. decoded
        end
    end

    if decoded:sub(1, #home) == home then
        decoded = "~" .. decoded:sub(#home + 1)
    end

    return decoded
end

local function session_dir()
    return vim.fn.stdpath("state") .. "/sessions"
end

-- Collect all session files
local function list_sessions()
    local dir = session_dir()
    local files = vim.fn.globpath(dir, "*.vim", false, true) or {}
    table.sort(files)
    return files
end

function M.session_picker()
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local function make_finder(results)
        return finders.new_table({
            results = results,
            entry_maker = function(path)
                local disp = humanize(path)
                return { value = path, ordinal = disp, display = disp }
            end,
        })
    end

    local results = list_sessions()

    local function open_picker()
        if #results == 0 then
            vim.notify("No sessions found", vim.log.levels.WARN)
            return
        end

        pickers
            .new({}, {
                prompt_title = "Sessions",
                finder = make_finder(results),
                sorter = conf.generic_sorter({}),
                previewer = false,
                attach_mappings = function(prompt_bufnr, map)
                    local function load_session()
                        local entry = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        if entry and entry.value then
                            vim.cmd("silent! source " .. vim.fn.fnameescape(entry.value))
                            vim.notify("Loaded session: " .. humanize(entry.value), vim.log.levels.INFO)
                        end
                    end

                    local function refresh_from_disk()
                        results = list_sessions()
                        local picker = action_state.get_current_picker(prompt_bufnr)
                        picker:refresh(make_finder(results), { reset_prompt = true })
                    end

                    local function delete_session()
                        local entry = action_state.get_selected_entry()
                        if not (entry and entry.value) then
                            return
                        end

                        local ok = (vim.fn.delete(entry.value) == 0)
                        if not ok then
                            vim.notify("Failed to delete: " .. humanize(entry.value), vim.log.levels.ERROR)
                            return
                        end

                        vim.notify("Deleted session: " .. humanize(entry.value), vim.log.levels.INFO)

                        -- Remove from our local results list
                        local new_results = {}
                        for _, p in ipairs(results) do
                            if p ~= entry.value then
                                table.insert(new_results, p)
                            end
                        end
                        results = new_results

                        if #results == 0 then
                            actions.close(prompt_bufnr)
                            vim.notify("No sessions left", vim.log.levels.WARN)
                            return
                        end

                        local picker = action_state.get_current_picker(prompt_bufnr)
                        picker:refresh(make_finder(results), { reset_prompt = true })

                        -- Keep navigation feeling smooth
                        vim.schedule(function()
                            actions.move_selection_next(prompt_bufnr)
                        end)
                    end

                    map("i", "<CR>", load_session)
                    map("n", "<CR>", load_session)

                    -- Alt/Option navigation in insert mode
                    map("i", "<M-n>", actions.move_selection_next)
                    map("i", "<M-p>", actions.move_selection_previous)
                    map("i", "<A-n>", actions.move_selection_next)
                    map("i", "<A-p>", actions.move_selection_previous)

                    -- Delete
                    map("n", "dd", delete_session)
                    map("i", "<C-d>", delete_session)

                    -- Reload list from disk
                    map("n", "r", refresh_from_disk)
                    map("i", "<C-r>", refresh_from_disk)

                    map("n", "q", function()
                        actions.close(prompt_bufnr)
                    end)

                    return true
                end,
            })
            :find()
    end

    open_picker()
end

return M
