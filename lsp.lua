-- This contains all the code for LSP setup to happen lazily
-- Autocomplete within cmp.setup() contains all the autocomplete specific keybindings
-- LSP within lsp_zero.on_attach() contains all the lsp specific keybindings (mainly telescope)

return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        lazy = true,
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'aznhe21/actions-preview.nvim',
        config = function ()
            local hl = require("actions-preview.highlight")
            require("actions-preview").setup {
                highlight_command = {
                    hl.delta("/usr/bin/delta")
                },
                diff = {
                    algorithm = "patience",
                    ignore_whitespace = true,
                },
            }
        end,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            {'L3MON4D3/LuaSnip'},
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            --- keybind configuration
            cmp.setup({
                formatting = lsp_zero.cmp_format({details = true}),
                mapping = cmp.mapping.preset.insert({
                    ['<Space>'] = cmp.mapping.confirm({select = false}),
                    ['<Tab>'] = cmp_action.luasnip_supertab(),
                    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                }, {
                    { name = 'buffer' },
                })
            })
        end
    },

    -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = {'LspInfo', 'LspInstall', 'LspStart'},
        event = {'BufReadPre', 'BufNewFile'},
        dependencies = {
            {'hrsh7th/cmp-nvim-lsp'},
            {'williamboman/mason-lspconfig.nvim'},
            {'nvim-telescope/telescope.nvim'},
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            --- keybind configuration
            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({buffer = bufnr})
                local telescope = require("telescope.builtin")
                vim.keymap.set('n', 'gd', telescope.lsp_definitions, {buffer=bufnr})
                vim.keymap.set('n', 'gi', telescope.lsp_implementations, {buffer=bufnr})
                vim.keymap.set('n', 'go', telescope.lsp_type_definitions, {buffer=bufnr})
                vim.keymap.set('n', 'gr', telescope.lsp_references, {buffer=bufnr})
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {buffer=bufnr})
                vim.keymap.set('n', '<leader>ac', require('actions-preview').code_actions, {buffer=bufnr})
                vim.keymap.set('n', '<leader><Space>', telescope.diagnostics, {buffer=bufnr})
            end)

            --- mason configuration
            require('mason-lspconfig').setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "gopls",
                    "ltex"
                },
                handlers = {
                    -- this first function is the "default handler"
                    -- it applies to every language server without a "custom handler"
                    function(server_name)
                        require('lspconfig')[server_name].setup({capabilities = capabilities})
                    end,
                    ["lua_ls"] = function()
                        local lspconfig = require("lspconfig")
                        lspconfig.lua_ls.setup {
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    runtime = { version = "Lua 5.1" },
                                    diagnostics = {
                                        globals = { "vim", "it", "describe", "before_each", "after_each" },
                                    },
                                    workspace = {
                                        -- Make the server aware of Neovim runtime files
                                        library = vim.api.nvim_get_runtime_file("", true),
      },
                                }
                            }
                        }
                    end,
                }
            })
        end
    },
    --- Diagnostics
    {
    'dgagn/diagflow.nvim',
    -- event = 'LspAttach', This is what I use personnally and it works great
    opts = {
        show_borders = true
    }
    }
}
