return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 40,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)

        vim.keymap.set("n", "<C-t>", "", { buffer = bufnr })
        vim.keymap.del("n", "<C-t>", { buffer = bufnr })
      end,
    })

    vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", {})
  end,
}
