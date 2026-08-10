local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({})
telescope.load_extension("fidget")

vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fc", function()
    builtin.find_files({
        cwd = vim.fn.stdpath("config"),
    })
end)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
