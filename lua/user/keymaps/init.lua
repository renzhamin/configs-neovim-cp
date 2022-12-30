vim.g.mapleader = ','

require("user.keymaps.general")
require("user.keymaps.code-runner")
require("user.keymaps.custom")


local wk = require("which-key")

wk.register({
    ["<Leader>"] = {
        t = {
            name = "Telescope",
        },
    }
})
