-- Caminho onde o lazy.nvim será instalado
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Se ainda não existe, clona o repositório
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
    end

    -- Adiciona o lazy.nvim ao runtimepath
    vim.opt.rtp:prepend(lazypath)

    -- Configura o lazy: lê todos os arquivos de lua/plugins/
    require("lazy").setup("plugins")
