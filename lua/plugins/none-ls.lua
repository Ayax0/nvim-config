return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    { "jay-babu/mason-null-ls.nvim" }
  },
  config = function()
    local none_ls_mason = require("mason-null-ls");
    local none_ls = require("null-ls");

    none_ls_mason.setup({
      ensure_installed = {
        "stylua",
        "eslint_d",
      }
    })

    none_ls.setup({
      sources = {
        none_ls.builtins.formatting.stylua,

        none_ls.builtins.formatting.eslint_d,
        none_ls.builtins.diagnostics.eslint_d,
      },
    })
  end,
}
