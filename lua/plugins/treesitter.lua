return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    { "windwp/nvim-ts-autotag" },
  },
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "html",
        "css",
        "scss",
      },
      highlight = { enable = true },
      autotag = { enable = true },
      indent = { enable = true },
    })
  end,
}
