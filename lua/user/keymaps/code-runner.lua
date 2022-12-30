local ks = vim.keymap.set
local runner = require("user.code-runner")

local modes = { 'n', 'i' }

ks(modes, '<F12>', runner.run_with_file_input_output, { desc = "input_output" })
ks(modes, '<F24>', runner.run_with_file_input_output_stderr, { desc = "input_output_stderr" }) -- S-F12
ks(modes, '<F36>', runner.run_with_file_input, { desc = "input" }) -- C-F12
ks(modes, '<F48>', runner.run_in_terminal, { desc = "terminal" }) -- C-S-F12
