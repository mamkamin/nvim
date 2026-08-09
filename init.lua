-- Set <space> as the leader key
-- See `:h mapleader`
-- NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "

-- OPTIONS
--
-- See `:h vim.o`
-- NOTE: You can change these options as you wish!
-- For more options, you can see `:h option-list`
-- To see documentation for an option, you can use `:h 'optionname'`, for example `:h 'number'`
-- (Note the single quotes)

vim.o.number = true -- Show line numbers in a column.

-- Show line numbers relative to where the cursor is.
-- Affects the 'number' option above, see `:h number_relativenumber`.
vim.o.relativenumber = true

vim.o.winborder = "rounded"

-- Sync clipboard between OS and Neovim. Schedule the setting after `UIEnter` because it can
-- increase startup-time. Remove this option if you want your OS clipboard to remain independent.
-- See `:h 'clipboard'`
vim.api.nvim_create_autocmd("UIEnter", {
    callback = function()
        vim.o.clipboard = "unnamedplus"
    end,
})

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true -- Highlight the line where the cursor is on.
vim.o.scrolloff = 10 -- Keep this many screen lines above/below the cursor.
vim.o.list = true -- Show <tab> and trailing spaces.

-- If performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s). See `:h 'confirm'`
vim.o.confirm = true

-- KEYMAPS
--
-- See `:h vim.keymap.set()`, `:h mapping`, `:h keycodes`

-- Use <Esc> to exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("n", "<C-c>", "<Esc>")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- AUTOCOMMANDS (EVENT HANDLERS)
--
-- See `:h lua-guide-autocommands`, `:h autocmd`, `:h nvim_create_autocmd()`

-- Highlight when yanking (copying) text.
-- Try it with `yap` in normal mode. See `:h vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    callback = function()
        vim.hl.on_yank()
    end,
})

-- USER COMMANDS: DEFINE CUSTOM COMMANDS
--
-- See `:h nvim_create_user_command()` and `:h user-commands`

-- Create a command `:GitBlameLine` that print the git blame for the current line
vim.api.nvim_create_user_command("GitBlameLine", function()
    local line_number = vim.fn.line(".") -- Get the current line number. See `:h line()`
    local filename = vim.api.nvim_buf_get_name(0)
    print(vim.system({ "git", "blame", "-L", line_number .. ",+1", filename }):wait().stdout)
end, { desc = "Print the git blame for the current line" })

-- Force Neovim to detect .h files as C files
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.h",
    callback = function()
        vim.bo.filetype = "c"
    end,
})

-- PLUGINS
--
-- See `:h :packadd`, `:h vim.pack`

-- Add the "nohlsearch" package to automatically disable search highlighting after
-- 'updatetime' and when going to insert mode.
vim.cmd("packadd! nohlsearch")

-- Install third-party plugins via "vim.pack.add()".
vim.pack.add({
    -- Markdown preview
    "https://github.com/OXY2DEV/markview.nvim",
    -- Plenary
    "https://github.com/nvim-lua/plenary.nvim",
    -- Mason
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/mason-org/mason-lspconfig.nvim",
    -- Quickstart configs for LSP
    "https://github.com/neovim/nvim-lspconfig",
    -- Fuzzy picker
    "https://github.com/ibhagwan/fzf-lua",
    -- Enhanced quickfix/loclist
    "https://github.com/stevearc/quicker.nvim",
    -- Git integration
    "https://github.com/lewis6991/gitsigns.nvim",
    -- Lazydev
    "https://github.com/folke/lazydev.nvim",
    -- Blink CMP
    "https://github.com/rafamadriz/friendly-snippets",
    {
        src = "https://github.com/saghen/blink.cmp",
        version = "v1",
    },
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/stevearc/conform.nvim",
    -- Harpoon
    {
        src = "https://github.com/ThePrimeagen/harpoon",
        version = "harpoon2",
    },

    -- Rose pine
    {
        src = "https://github.com/rose-pine/neovim",
        name = "rose-pine",
    },
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    "https://github.com/tpope/vim-sleuth",
})

require("ibl").setup({})
require("rose-pine").setup({})
require("mason").setup({})
local fzf = require("fzf-lua")
require("quicker").setup({})
require("gitsigns").setup({})
require("lazydev").setup({
    library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    },
})
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",

        -- PYTHON
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
local conform = require("conform")

vim.cmd.colorscheme("rose-pine")

-- CONFORM --
conform.setup({
    formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        c = { "clang-format" },
    },
    formatters = {
        clang_format = {
            -- Use prepend_args to safely inject options without erasing conform defaults
            prepend_args = { "--style=file", "--fallback-style=LLVM" },
        },
    },
})
vim.keymap.set("n", "<leader>fm", conform.format)

-- FUGITIVE --
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- FZF --
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

-- HARPOON --
local harpoon = require("harpoon")

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

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-p>", function()
    harpoon:list():prev()
end)

vim.keymap.set("n", "<C-n>", function()
    harpoon:list():next()
end)
