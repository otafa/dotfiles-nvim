return {
  "nvim-treesitter/nvim-treesitter",
  -- usa a branch estável e bem documentada (a "main" é a reescrita nova, com API diferente)
  branch = "master",
  -- toda vez que o plugin atualiza, roda :TSUpdate pra recompilar os parsers das linguagens
  build = ":TSUpdate",
  -- carrega ao abrir um arquivo, que é quando ele precisa analisar o código
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- a configuração do treesitter fica nesse submódulo "configs"
    require("nvim-treesitter.configs").setup({
      -- parsers que serão instalados automaticamente (um por linguagem)
      ensure_installed = {
        "lua", "python", "java", "javascript", "typescript", "tsx",
        "html", "css", "json", "vim", "vimdoc",
      },
      -- liga o colorido de sintaxe baseado na estrutura real do código
      highlight = { enable = true },
      -- liga a indentação automática inteligente
      indent = { enable = true },
    })
  end,
}
