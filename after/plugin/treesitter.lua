local nvim_ts = require("nvim-treesitter")

nvim_ts.install({
    "c",
    "lua",
    "python",
    "javascript",
    "typescript",
    "jsx",
    "tsx",
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "lua",
        "python",
        "c",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "java",
    },
    callback = function()
        vim.treesitter.start()
    end,
})
