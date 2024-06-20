return {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
        require('luasnip').setup({
            update_events = { "TextChanged", "TextChangedI" },
            -- enable_autosnippets = true
        })

        --¯runtimepath is searched for directories that contain snippets
        -- :h runtimepath

        -- Lua snippets
        -- https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md#lua
        -- <runtimepath>/luasnippets direc will be loaded
        -- can provide paths list to load for custom direc
        require("luasnip.loaders.from_lua").load()
    end
}
