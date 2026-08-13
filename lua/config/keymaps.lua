-- Use <Esc> to exit terminal mode.
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<C-c>", "<Esc>")
vim.keymap.set("n", "<C-c>", vim.cmd.nohlsearch)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<M-j>", vim.cmd.cnext)
vim.keymap.set("n", "<M-k>", vim.cmd.cprev)

-- Normal mode: Move current line up/down
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up" })

-- Visual mode: Move selected block up/down
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move block up" })

-- Insert mode: Move current line up/down
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })

vim.keymap.set("n", "<M-->", "<C-w>-")
vim.keymap.set("n", "<M-=>", "<C-w>+")
vim.keymap.set("n", "<M-.>", "<C-w>>")
vim.keymap.set("n", "<M-,>", "<C-w><")
