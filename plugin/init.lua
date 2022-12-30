local opt = vim.opt
local options = require("user.options").vim_options


for k, v in pairs(options) do
    opt[k] = v
end

require("user")

require("which-key").setup {
    plugins = {
        marks = false,
        registers = false,
    }
}

require("nvim-tree").setup({
    view = {
        relativenumber = true,
    },
})
