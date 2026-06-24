-- este arquivo retorna uma LISTA de plugins (por isso os blocos dentro de { })
return {
  -- 1) Mason sozinho: assim o comando :Mason fica disponível mesmo sem arquivo aberto
  {
    "mason-org/mason.nvim",
    -- cmd faz o lazy carregar o plugin quando você digita :Mason
    cmd = "Mason",
    -- opts = {} faz o lazy chamar require("mason").setup({}) automaticamente, criando o comando
    opts = {},
  },

  -- 2) O LSP de fato, que liga os servidores aos arquivos que você abre
  {
    "neovim/nvim-lspconfig",
    -- carrega ao abrir um arquivo, que é quando o LSP precisa entrar em ação
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      -- mason-lspconfig liga o mason ao lspconfig e habilita os servidores automaticamente
      "mason-org/mason-lspconfig.nvim",
      -- precisamos do blink aqui pra pegar as capabilities (o que nosso editor sabe fazer)
      "saghen/blink.cmp",
    },
    config = function()
      -- pega as capabilities do blink e aplica a TODOS os servidores ("*")
      -- isso avisa cada LSP que nosso editor suporta autocomplete completo
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      vim.lsp.config("*", { capabilities = capabilities })

      -- ajuste só pro servidor de Lua: ensina ele que "vim" é uma variável global válida,
      -- senão ele reclama de "undefined global vim" o tempo todo na config do Neovim
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      -- manda o mason instalar esses servidores e habilitá-los automaticamente
      -- lua_ls = Lua, ts_ls = JavaScript/TypeScript, pyright = Python, jdtls = Java
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "pyright", "jdtls" },
      })
    end,
  },
}
