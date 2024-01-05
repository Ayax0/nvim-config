return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    { "windwp/nvim-ts-autotag" },
    {
      "nvim-treesitter/nvim-treesitter-context",
      config = function()
        require("treesitter-context").setup()
      end
    }
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
