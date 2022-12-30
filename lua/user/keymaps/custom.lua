local ks = vim.keymap.set
local fns = require("user.utils.input_output")

ks('n', '<A-\\>', fns.toggle_sidebar)
ks('n', '<Leader>io', fns.set_input_output_in_sidebar)

ks({ 'n', 'i' }, '<F4>', fns.populate_input_file)
ks('n', '<F3>', fns.copy_output_file)
