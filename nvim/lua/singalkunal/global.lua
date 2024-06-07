-- put global declarations here

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

_G.isLoaded = true -- to check if global is loaded
