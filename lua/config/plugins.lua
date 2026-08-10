vim.cmd("packadd! nohlsearch")

vim.pack.add({
    "https://github.com/OXY2DEV/markview.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/stevearc/quicker.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    "https://github.com/folke/lazydev.nvim",
    "https://github.com/rafamadriz/friendly-snippets",
    {
        src = "https://github.com/saghen/blink.cmp",
        version = "v1",
    },
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/stevearc/conform.nvim",
    {
        src = "https://github.com/ThePrimeagen/harpoon",
        version = "harpoon2",
    },
    {
        src = "https://github.com/rose-pine/neovim",
        name = "rose-pine",
    },
    "https://github.com/nvim-mini/mini.indentscope",
    "https://github.com/tpope/vim-sleuth",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/folke/tokyonight.nvim",
})

local nvim_ts = require("nvim-treesitter")
local fzf = require("fzf-lua")
local conform = require("conform")
local harpoon = require("harpoon")

require("mini.indentscope").setup({})
require("rose-pine").setup({
    styles = {
        italic = false,
    },
})
require("mason").setup({})
require("quicker").setup({})
require("gitsigns").setup({})
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
require("blink-cmp").setup({})

vim.cmd.colorscheme("tokyonight")

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

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

fzf.setup({ fzf_colors = true })
vim.keymap.set("n", "<leader>ff", fzf.files)
vim.keymap.set("n", "<leader>fc", function()
    fzf.files({
        cwd = vim.fn.stdpath("config"),
    })
end)
vim.keymap.set("n", "<leader>fg", fzf.grep)
vim.keymap.set("n", "<leader>fb", fzf.buffers)
vim.keymap.set("n", "<leader>fh", fzf.helptags)

harpoon:setup({
    settings = {
        save_on_toggle = true,
    },
})

vim.keymap.set("n", "<leader>a", function()
    harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end)
vim.keymap.set("n", "<leader>1", function()
    harpoon:list():select(1)
end)
vim.keymap.set("n", "<leader>2", function()
    harpoon:list():select(2)
end)
vim.keymap.set("n", "<leader>3", function()
    harpoon:list():select(3)
end)
vim.keymap.set("n", "<leader>4", function()
    harpoon:list():select(4)
end)
vim.keymap.set("n", "<C-p>", function()
    harpoon:list():prev()
end)
vim.keymap.set("n", "<C-n>", function()
    harpoon:list():next()
end)

nvim_ts.install({ "c", "lua", "python" })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "python", "c" },
    callback = function()
        vim.treesitter.start()
    end,
})
