local opt = require("user.code-runner.options")

local M = {}

local flags = [[-D LOCAL -D DBG_MACRO_NO_WARNING -D_GLIBCXX_DEBUG --std=c++20 -Wall -Wno-unused-variable -Wshadow -Wfloat-equal -Wconversion -Wlogical-op -Wshift-overflow=2 -Wduplicated-cond -Wcast-qual -Wcast-align -fsanitize=undefined -fno-sanitize-recover -fstack-protector]]

if vim.fn.has('win32') == 1 then
    flags = [[-D LOCAL -D DBG_MACRO_NO_WARNING -Wall -Wshadow -Wfloat-equal -Wconversion -Wlogical-op -Wshift-overflow=2 -Wduplicated-cond -Wcast-qual -Wcast-align -fno-sanitize-recover -fstack-protector]]
end

M.compile_command = string.format("g++ -I %s/include %s -o %s/Program", opt.codes_dir, flags, opt.bin_dir)

M.run_command = string.format("%s %s %s %s/Program", opt.timing_command, opt.timeout, opt.timeout, opt.bin_dir)

return M
