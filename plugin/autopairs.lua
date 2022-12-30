local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then
    return
end

autopairs.setup(require("user.plugins.autopairs"))

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    print("Failed to load cmp in autopairs.lua")
    return
end

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
