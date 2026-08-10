local nvim_ts = require("nvim-treesitter")

nvim_ts.install({ "c", "lua", "python" })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "python", "c" },
    callback = function()
        vim.treesitter.start()
    end,
})
