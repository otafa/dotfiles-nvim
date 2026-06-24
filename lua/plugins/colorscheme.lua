return {
    "folke/tokyonight.nvim",
    enabled = false,
    lazy = false,        -- carrega no startup (temas precisam carregar imediatamente)
    priority = 1000,     -- carrega antes dos outros plugins
    config = function()
    vim.cmd.colorscheme("tokyonight-night")
    end,
}
