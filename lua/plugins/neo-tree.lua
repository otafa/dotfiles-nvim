return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Abrir/fechar Neo-tree" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      window = {
        position = "left",
        width = 35,
      },
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
    })
  end,
}
