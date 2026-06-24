-- Números nas linhas
vim.opt.number = true


-- Indentação
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Busca
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Visual
vim.opt.termguicolors = true   -- importante: habilita cores 24-bit (16 milhões de cores)
vim.opt.cursorline = true
vim.opt.scrolloff = 8

-- Tecla líder (espaço)
vim.g.mapleader = " " 




-- clipboard
vim.opt.clipboard = "unnamedplus"
-- Conf do wl-clipboard (wayland)
vim.g.clipboard = {
    name = "wl-clipboard",
    copy = {
        ["+"] = "wl-copy",
        ["*"] = "wl-copy --primary",
    },
    paste = {
        ["+"] = "wl-paste --no-newline",
        ["*"] = "wl-paste --no-newline --primary",
    },
    cache_enabled = 0,
}




--atalhos
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h10"
end

  -- Atalhos de copiar/colar do sistema
vim.keymap.set("n", "<C-S-v>", '"+p')                                    -- normal
vim.keymap.set("i", "<C-S-v>", '<C-r>+')                                 -- inserção
vim.keymap.set("v", "<C-S-c>", '"+y')                                    -- visual: copiar
vim.keymap.set("v", "<C-S-v>", '"+p')                                    -- visual: colar
vim.keymap.set("c", "<C-S-v>", "<C-r>+")                                 -- linha de comando
vim.keymap.set("t", "<C-S-v>", [[<C-\><C-n>"+pi]])                       -- terminal


-- Configurações da font
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h11"
end




