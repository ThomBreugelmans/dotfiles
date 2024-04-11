local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
    use 'wbthomason/packer.nvim'
    -- Your plugins go here

    use { 
        "catppuccin/nvim", 
        as = "catppuccin", 
    }

    use 'nvim-lua/plenary.nvim'

    use 'nvim-lualine/lualine.nvim'

    use 'onsails/lspkind.nvim'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'

    use 'neovim/nvim-lspconfig'
    use({
        'ray-x/navigator.lua',
        requires = {
            { 'ray-x/guihua.lua', run = 'cd lua/fzy && make' },
            { 'neovim/nvim-lspconfig' },
        },
        config = function()
            require('navigator').setup()
        end
    })
    use 'nvim-treesitter/nvim-treesitter'

    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-file-browser.nvim'
    use 'kyazdani42/nvim-web-devicons'

    use ({
	'lewis6991/gitsigns.nvim',
	config = function()
		require('gitsigns').setup()
	end
    })
    use 'dinhhuy258/git.nvim'

    use 'windwp/nvim-autopairs'
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use 'ggandor/leap.nvim'

    use 'norcalli/nvim-colorizer.lua'

    use 'folke/zen-mode.nvim'
end)

