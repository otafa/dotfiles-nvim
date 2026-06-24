return {
  "saghen/blink.cmp",
  -- version baixa uma release pronta com o binário já compilado, evitando precisar do Rust/cargo na máquina
  version = "*",
  -- só carrega quando você entra no modo de inserção, deixando o Neovim abrir mais rápido
  event = "InsertEnter",
  -- opts é um atalho do lazy.nvim: ele chama require("blink.cmp").setup(opts) sozinho pra você
  opts = {
    keymap = {
      -- preset "default": Ctrl+y aceita, Ctrl+espaço abre o menu, Ctrl+n e Ctrl+p navegam
      -- usamos Ctrl+y de propósito pra não conflitar com o Tab do Copilot
      preset = "default",
    },
    completion = {
      -- mostra automaticamente a documentação do item selecionado numa janelinha ao lado
      documentation = { auto_show = true },
    },
    sources = {
      -- de onde vêm as sugestões, em ordem de prioridade:
      -- lsp = inteligência da linguagem, path = caminhos de arquivo, snippets = trechos prontos, buffer = palavras já no texto
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
