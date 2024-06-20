return {
    'neovim/nvim-lspconfig',
    -- dependencies are lazy loaded
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/nvim-cmp',
        -- lua snip
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip'
    },
    config = function()
        local cmp = require('cmp')
        print("lsp config")
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())
        -- print(dump_me_vaguely(capabilities))

        local on_attach = function(client, bufnr)
            vim.g.completion_matching_strategy_list = "['exact', 'substring', 'fuzzy']"

            local function buf_set_keymap(...)
                vim.api.nvim_buf_set_keymap(bufnr, ...)
            end
            -- Mappings.
            local opts = { noremap = true, silent = true }
            buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
            buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
            buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
            buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
            buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
            buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
            buf_set_keymap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
            buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
            buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
        end

        -- 1. Setup lanuage servers
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "clangd", "lua_ls", "pyright" },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities,
                        on_attach = on_attach
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        on_attach = on_attach,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        -- 2. Setup Completion - provides lang specific code completion over
        -- omnicompletion provided by default vim
        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                -- Add tab support
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<C-e>'] = cmp.mapping.close(),
                ['<CR>'] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true,
                })
            }),
            -- Installed sources
            sources = cmp.config.sources(
                {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                },
                {
                    { name = 'buffer' },
                }),
            formatting = {
                -- changing the order of fields so the icon is the first
                fields = { 'menu', 'abbr', 'kind' },
                -- here is where the change happens
                format = function(entry, vim_item)
                    local menu_icon = {
                        nvim_lsp = 'λ',
                        luasnip = '⋗',
                        buffer = 'Ω',
                        path = '',
                        nvim_lua = 'Π',
                    }

                    -- icons (mostly nerd font icons) for completion window CompletionItemKind
                    -- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#textDocument_completion
                    local completion_item_icons = {
                        Text = '󰊄',
                        Method = '',
                        Function = '󰊕',
                        Constructor = '',
                        Field = '',
                        Variable = '󰫧',
                        Class = '',
                        Interface = '',
                        Module = '󰕳',
                        Property = '',
                        Unit = '',
                        Value = '',
                        Enum = '',
                        Keyword = '',
                        Snippet = '',
                        Color = '',
                        File = '',
                        Reference = '',
                        Folder = '',
                        EnumMember = '',
                        Constant = '',
                        Struct = '',
                        Event = '',
                        Operator = '',
                        TypeParameter = '',
                    }

                    vim_item.menu = menu_icon[entry.source.name]
                    vim_item.kind = (completion_item_icons[vim_item.kind] or 'Foo') .. ' ' .. vim_item.kind
                    return vim_item
                end,
            }
        })

        -- Use icons in the sign column
        set_sign_icons({
            error = '✘',
            warn = '▲',
            hint = '⚑',
            info = '»'
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        --[==[
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        --[==[
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                    { name = 'cmdline' }
                }),
            matching = { disallow_symbol_nonprefix_matching = false }
        })
        ]==] --


        -- 2.2 Diagonastics
        vim.diagnostic.config({
            -- update_in_insert = true,
            -- disable virtual text by default
            -- will be visible via vim.diagnostic.open_float()
            virtual_text = false,
            everity_sort = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
