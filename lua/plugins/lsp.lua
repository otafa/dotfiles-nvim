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

      -- cria um gatilho que dispara toda vez que um servidor LSP se conecta a um arquivo
      -- só nesse momento os atalhos abaixo passam a existir, e apenas naquele arquivo
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          -- função auxiliar pra não repetir as opções; buffer = event.buf deixa o atalho local ao arquivo
          local function map(tecla, acao, descricao)
            vim.keymap.set("n", tecla, acao, { buffer = event.buf, desc = "LSP: " .. descricao })
          end

          -- gd: pula pra onde a função/variável sob o cursor foi definida
          map("gd", vim.lsp.buf.definition, "ir pra definicao")
          -- K: mostra a documentação flutuante do item sob o cursor
          map("K", vim.lsp.buf.hover, "ver documentacao")
          -- <leader>rn: renomeia o símbolo sob o cursor em todos os lugares (leader = espaço)
          map("<leader>rn", vim.lsp.buf.rename, "renomear")
          -- <leader>ca: abre o menu de ações/correções de código naquele ponto
          map("<leader>ca", vim.lsp.buf.code_action, "acoes de codigo")
          -- ]d e [d: pulam pro próximo e pro erro anterior do arquivo
          map("]d", function() vim.diagnostic.jump({ count = 1 }) end, "proximo erro")
          map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "erro anterior")
        end,
      })
    end,
  },
}
