local home = vim.fn.expand("~")

local M = {}

M.codes_dir = home .. "/Codes"

M.bin_dir = M.codes_dir .. "/X"

M.timeout = "3"

M.timing_command = "/usr/bin/time -f '\\%es\\t\\%Mkb' " .. "timeout -k"

if vim.fn.glob("/usr/bin/time") == "" or vim.fn.glob("/usr/bin/timeout") == "" then
    M.timing_command = ""
    M.timeout = ""
end

M.copy_to_input_command = "silent !xclip -sel clip -o > " .. M.bin_dir .. "/Input.txt"
M.copy_from_output_command = "silent !xclip -sel clip " .. M.bin_dir .. "/Output.txt"

if vim.fn.has('win32') == 1 then
    M.copy_to_input_command = 'silent !powershell -command "Get-Clipboard" > ' .. M.bin_dir .. '\\Input.txt'
    M.copy_from_output_command = 'silent !clip < ' .. M.bin_dir .. '\\Output.txt'
end


-- create required files and directories if doesn't exist
if vim.fn.isdirectory(M.bin_dir) == 0 then
    if vim.fn.has('win32') == 1 then
        M.codes_dir = string.gsub(M.codes_dir, '/', '\\')
        M.bin_dir = string.gsub(M.bin_dir, '/', '\\')
        os.execute('mkdir ' .. M.codes_dir .. '\\include')
        os.execute('mkdir ' .. M.bin_dir)
        os.execute('type nul >> ' .. M.bin_dir .. '\\Input.txt')
    else
        os.execute('mkdir -p ' .. M.codes_dir .. '/include')
        os.execute('mkdir -p ' .. M.bin_dir)
        os.execute('touch ' .. M.bin_dir .. '/Input.txt')
    end
end

-- needs to close the "
M.run_in_terminal_command = "alacritty -e sh -c \""

return M
