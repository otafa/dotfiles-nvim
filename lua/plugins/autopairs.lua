return {
  "windwp/nvim-autopairs",
  -- só carrega ao entrar no modo de inserção, que é quando ele precisa agir
  event = "InsertEnter",
  -- config = true faz o lazy chamar require("nvim-autopairs").setup() com as opções padrão
  -- o padrão já fecha (), {}, [], aspas e pula por cima do fechamento quando você digita ele
  config = true,
}
