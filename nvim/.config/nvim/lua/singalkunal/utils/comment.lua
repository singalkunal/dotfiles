local M = {}

local api = vim.api
local bo = vim.bo

local comment_map = {
    ["c"] = "//",
    ["cpp"] = "//",
    ["go"] = "//",
    ["java"] = "//",
    ["javascript"] = "//",
    ["scala"] = "//",
    ["php"] = "//",
    ["python"] = "#",
    ["ruby"] = "#",
    ["rust"] = "//",
    ["sh"] = "#",
    ["desktop"] = "#",
    ["fstab"] = "#",
    ["conf"] = "#",
    ["profile"] = "#",
    ["bashrc"] = "#",
    ["bash_profile"] = "#",
    ["mail"] = ">",
    ["eml"] = ">",
    ["bat"] = "REM",
    ["ahk"] = ";",
    ["vim"] = '"',
    ["tex"] = "%",
    ["lua"] = "--"
}

M.toggle_comment = function()
    if comment_map[bo.filetype] ~= nil then
        local comment_leader = comment_map[bo.filetype]
        local line = api.nvim_get_current_line()
        if line:match("^\\s*" .. comment_leader .. " ") then
            -- Uncomment the line
            vim.api.nvim_cmd("silent s/^\\(\\s*\\)" .. comment_leader .. " /\\1/")
        elseif line:match("^\\s*" .. comment_leader) then
            -- Uncomment the line
            vim.api.nvim_cmd("silent s/^\\(\\s*\\)" .. comment_leader .. "/\\1/")
        else
            -- Comment the line
            vim.api.nvim_cmd("silent s/^\\(\\s*\\)/\\1" .. comment_leader .. " /", {})
        end
    else
        print("No comment leader found for filetype")
    end
end

return M
