local telescope = require("telescope")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("telescope.builtin")

telescope.setup({})
telescope.load_extension("fidget")

local function find_files_then_grep()
    builtin.find_files({
        attach_mappings = function(prompt_bufnr, map)
            local function grep_filtered_files()
                local picker = action_state.get_current_picker(prompt_bufnr)
                local entries = picker:get_multi_selection()

                -- When no files are marked, search every file left by the current filter.
                if #entries == 0 then
                    entries = {}
                    for entry in picker.manager:iter() do
                        table.insert(entries, entry)
                    end
                end

                local search_dirs = vim.tbl_map(function(entry)
                    return entry.path or entry.filename or entry.value
                end, entries)

                if #search_dirs == 0 then
                    vim.notify("No files selected for live grep", vim.log.levels.WARN)
                    return
                end

                actions.close(prompt_bufnr)
                builtin.live_grep({ search_dirs = search_dirs })
            end

            map("i", "<C-g>", grep_filtered_files)
            map("n", "<C-g>", grep_filtered_files)
            return true
        end,
    })
end

vim.keymap.set("n", "<leader>ff", find_files_then_grep)
vim.keymap.set("n", "<leader>fc", function()
    builtin.find_files({
        cwd = vim.fn.stdpath("config"),
    })
end)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>fw", builtin.lsp_dynamic_workspace_symbols)
vim.keymap.set("n", "<leader>gb", builtin.git_branches)
