require("mason").setup({})
require("java").setup()
require("lazydev").setup({
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
})

vim.lsp.config("tailwindcss", {
    filetypes = vim.tbl_filter(function(filetype)
        return filetype ~= "css"
    end, vim.lsp.config.tailwindcss.filetypes),
})

vim.lsp.config("emmet_language_server", {
    filetypes = vim.list_extend(vim.list_extend({}, vim.lsp.config.emmet_language_server.filetypes), { "php" }),
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "basedpyright",
        "ts_ls",
        "tailwindcss",
        "cssls",
        "emmet_language_server",
    },
})
vim.lsp.enable("jdtls")
