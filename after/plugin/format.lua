local conform = require("conform")

conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        c = { "clang-format" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        php = { "php_cs_fixer" },
        sql = { "sql_formatter" }
    },
    formatters = {
        clang_format = {
            prepend_args = { "--style=file", "--fallback-style=LLVM" },
        },
        php_cs_fixer = {
            args = {
                "fix",
                "--rules=@PSR12",
                "$FILENAME",
            },
            stdin = false
        }
    },
})

vim.keymap.set("n", "<leader>fm", conform.format)
