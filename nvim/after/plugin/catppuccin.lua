require('catppuccin').setup({
    integrations = {
        cmp = true,
        gitsigns = true,
        leap = true,
        mason = true,
        treesitter = true,
    }
})

vim.cmd.colorscheme "catppuccin"
