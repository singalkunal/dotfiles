-- put global declarations here

------- Global functions --------
--[[
    hacky global function to require modules
]]--
_G._require = function(cwd, module_path)
    _require(cwd, module_path, false)
end

_G._require = function(cwd, module_path, trim)
    local final_cwd = cwd
    if trim then
        -- final_cwd = (cwd):match("(.-)[^%.]+$")
        final_cwd:gsub("." .. module_path .. "$", "") -- trim module_path from cwd
    end
    require(final_cwd .. '.' .. module_path)
end

_G.get_mode_display_text = function(mode)
    -- mode_map copied from:
    -- https://github.com/nvim-lualine/lualine.nvim/blob/5113cdb32f9d9588a2b56de6d1df6e33b06a554a/lua/lualine/utils/mode.lua
    local mode_map = {
        ['n']      = 'NORMAL',
        ['no']     = 'O-PENDING',
        ['nov']    = 'O-PENDING',
        ['noV']    = 'O-PENDING',
        ['no\22']  = 'O-PENDING',
        ['niI']    = 'NORMAL',
        ['niR']    = 'NORMAL',
        ['niV']    = 'NORMAL',
        ['nt']     = 'NORMAL',
        ['v']      = 'VISUAL',
        ['vs']     = 'VISUAL',
        ['V']      = 'V-LINE',
        ['Vs']     = 'V-LINE',
        ['\22']    = 'V-BLOCK',
        ['\22s']   = 'V-BLOCK',
        ['s']      = 'SELECT',
        ['S']      = 'S-LINE',
        ['\19']    = 'S-BLOCK',
        ['i']      = 'INSERT',
        ['ic']     = 'INSERT',
        ['ix']     = 'INSERT',
        ['R']      = 'REPLACE',
        ['Rc']     = 'REPLACE',
        ['Rx']     = 'REPLACE',
        ['Rv']     = 'V-REPLACE',
        ['Rvc']    = 'V-REPLACE',
        ['Rvx']    = 'V-REPLACE',
        ['c']      = 'COMMAND',
        ['cv']     = 'EX',
        ['ce']     = 'EX',
        ['r']      = 'REPLACE',
        ['rm']     = 'MORE',
        ['r?']     = 'CONFIRM',
        ['!']      = 'SHELL',
        ['t']      = 'TERMINAL',
    }

    mode = (mode == nil) and vim.fn.mode or mode
    return (mode_map == nil or mode_map[mode] == nil) and mode or mode_map[mode]
end

------ Global properties -------
_G.isLoaded = true -- to check if global is loaded
