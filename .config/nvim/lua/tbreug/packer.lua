return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Color Schemes
    --use { 'kvrohit/mellow.nvim', config = function() vim.cmd('coloscheme mellow') end}
    --use { 'rose-pine/neovim', as = 'rose-pine', config = function() vim.cmd('colorscheme rose-pine') end}
    --use { 'bluz71/vim-moonfly-colors', config = function() vim.cmd('colorscheme moonfly') end}
--    use({ "folke/tokyonight.nvim", config = function()
--        -- config theme tokyonight
--        vim.g.tokyonight_style = "night"
--        vim.g.tokyonight_italic_functions = true
--        vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
--        -- Change the "hint" color to the "orange" color, and make the "error" color bright red
--        vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
--
--        vim.cmd([[colorscheme tokyonight]])
--    end }) -- Theme
    use({ "sainnhe/everforest", config = function() vim.cmd('colorscheme everforest') end })
    use({ "sainnhe/edge", config = function() vim.cmd('colorscheme edge') end })
    use('folke/lsp-colors.nvim')
    use({
        "folke/twilight.nvim",
        config = function()
            require("twilight").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    })

    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
--
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            -- Snippet Collection (Optional)
            { 'rafamadriz/friendly-snippets' },
        }
    }

    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use({
        "anuvyklack/pretty-fold.nvim",
        config = function()
            require("pretty-fold").setup({})
        end,
    })
    use({
        "anuvyklack/fold-preview.nvim",
        requires = 'anuvyklack/keymap-amend.nvim',
        config = function()
            require("fold-preview").setup()
        end,
    })
end)
