local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        c = { "clang-format" },
    },
    formatters = {
        clang_format = {
            prepend_args = { "--style=file", "--fallback-style=LLVM" },
        },
    },
})

vim.keymap.set("n", "<leader>fm", conform.format)
