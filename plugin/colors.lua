vim.g.gruvbox_material_better_performance = 1
vim.cmd("colorscheme gruvbox-material")

local hi = function(...) vim.api.nvim_set_hl(0, ...) end

hi("CursorLineNr", { fg = "none" })
hi("Search", { bg = "none", fg = "#8d93a1", underline = true })
