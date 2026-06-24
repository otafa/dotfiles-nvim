return {
  "windwp/nvim-ts-autotag",
  -- depende do treesitter, que é de onde ele tira a noção do que é uma tag
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  -- carrega ao entrar no modo de inserção, que é quando você digita as tags
  event = "InsertEnter",
  -- config = true chama require("nvim-ts-autotag").setup() com o comportamento padrão:
  -- fecha a tag ao digitar <div> e renomeia o par quando você muda o nome de uma
  config = true,
}
