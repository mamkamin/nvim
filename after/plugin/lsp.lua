require("mason").setup({})
require("lazydev").setup({
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
})
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        -- "basedpyright",
        "ts_ls",
        "tailwindcss",
        "emmet_language_server",
    },
})
