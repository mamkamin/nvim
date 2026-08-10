require("mason").setup({})
require("lazydev").setup({
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
})
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "ruff",
        "basedpyright",
    },
    automatic_enable = {
        exclude = {
            "ruff",
        },
    },
})
