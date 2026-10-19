require("mini.indentscope").setup({})
require("rose-pine").setup({
    styles = {
        italic = false,
        transparency = false
    },
})

---@diagnostic disable-next-line: missing-fields
require("tokyonight").setup({
    transparent = false,
})

require("vague").setup({
    italic = false,
})

vim.g.nord_italic = false
vim.cmd.colorscheme("nord")
