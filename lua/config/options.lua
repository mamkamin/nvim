vim.o.number = true
vim.o.relativenumber = true
vim.o.winborder = "rounded"
vim.o.colorcolumn = "100"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.list = true
vim.o.confirm = true
vim.o.signcolumn = "yes"

-- Defer clipboard setup to avoid adding to startup time.
vim.api.nvim_create_autocmd("UIEnter", {
    callback = function()
        vim.o.clipboard = "unnamedplus"
    end,
})
