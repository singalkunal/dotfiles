return {
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        config = function()
            require("tokyonight").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
                transparent = true, -- Enable this to disable setting the background color
                terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Value is any valid attr-list value for `:help nvim_set_hl`
                    comments = { italic = false },
                    keywords = { italic = false },
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "dark", -- style for sidebars, see below
                    floats = "dark", -- style for floating windows
                },
            })
            -- vim.cmd("colorscheme tokyonight")
        end
    },
    {
        'AlexvZyl/nordic.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require 'nordic' .setup({
                -- Enable general editor background transparency.
                transparent_bg = true,
                override = {
                    ColorColumn = { bg = 'NvimDarkGray3' , ctermbg = 238 },
                    Visual = { bg = 'NvimDarkGray1', ctermbg = 238 },
                    StatusLine = { bg = '#455A64', fg = 'NvimLightGray1', ctermbg = 0 },

                    WinSeparator = { bg = 'none', fg = 'NvimDarkGray4', ctermbg = 238 }
                }
            })
            require 'nordic' .load()
        end
    }
}
