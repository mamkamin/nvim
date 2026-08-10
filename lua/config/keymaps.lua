-- Use <Esc> to exit terminal mode.
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<C-c>", "<Esc>")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set('n', '<M-j>', vim.cmd.cnext)
vim.keymap.set('n', '<M-k>', vim.cmd.cprev)
