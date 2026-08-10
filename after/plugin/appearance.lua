require("mini.indentscope").setup({})
require("rose-pine").setup({
    styles = {
        italic = false,
        transparency = true
    },
})

---@diagnostic disable-next-line: missing-fields
require("tokyonight").setup({
    transparent = true,
})

vim.cmd.colorscheme("rose-pine")
