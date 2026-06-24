return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,    -- sugestões aparecem automaticamente
        debounce = 75,
        keymap = {
          accept = "<Tab>",      -- Tab pra aceitar
          accept_word = false,
          accept_line = false,
          next = "<M-]>",        -- Alt+] próxima sugestão
          prev = "<M-[>",        -- Alt+[ sugestão anterior
          dismiss = "<C-]>",     -- Ctrl+] dispensa
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    })
  end,
}
