local function minimal_status_line()
    -- local mode = "%-5{%v:lua.string.upper(v:lua.vim.fn.mode())%}" 
    local mode = "%-5{%v:lua.get_mode_display_text(v:lua.vim.fn.mode())%}"
    local file_name = "%-.16t"
    local buf_nr = "[%n]"
    local modified = " %-m"
    local file_type = " %y"
    local right_align = "%="
    local line_no = "%10([%l/%L%)]"
    local pct_thru_file = "%5p%%"

    return string.format(
        "%s%s%s%s%s%s%s%s",
        mode,
        file_name,
        buf_nr,
        modified,
        file_type,
        right_align,
        line_no,
        pct_thru_file
    )
end

local function minimal_status_line_old()
    local hl_user1 = "%1*"
    local hl_user4 = "%4*"
    local hl_user0 = "%0*"  -- restore normal highlight (same as %*)
    local modified = " %m " -- [+] / [-] modified flag
    local full_file_path = " %<%F"
    local buf_no = " [#%n]"
    local file_type = " %y"
    local right_align = "%="
    local file_encoding = " %{&fileencoding?&fileencoding:&encoding}"
    local line_col_info = " line:%l/%L, col:%-2c"
    local percent_thru_file = "%5p%%"

    return string.format(
        "%s%s%s%s%s%s%s%s%s%s%s",
        hl_user1,
        modified,
        hl_user0,
        full_file_path,
        buf_no,
        file_type,
        right_align,
        hl_user4,
        file_encoding,
        line_col_info,
        percent_thru_file,
        "  ",
        hl_user1
    )
end

vim.opt.statusline = minimal_status_line_old()
