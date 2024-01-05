return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v2.x",
  dependencies = {
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
  },
  config = function()
    local lsp = require("lsp-zero");
    lsp.preset("minimal");

    lsp.set_sign_icons({
      error = "✘",
      warn = "▲",
      hint = "⚑",
      info = "»",
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }

    lsp.format_on_save({
      format_opts = {
        async = false,
        timeout_ms = 10000,
      },
      servers = {
        ["lua_ls"] = { "lua" },
        ["null_ls"] = {
          "volar",
          "cssmodules_ls"
        }
      },
    })

    lsp.setup();
  end
}
-- return {
--   {
--     "williamboman/mason.nvim",
--     config = function()
--       require("mason").setup()
--     end,
--   },
--   {
--     "williamboman/mason-lspconfig.nvim",
--     config = function()
--       require("mason-lspconfig").setup({
--         ensure_installed = {
--           "lua_ls",
--           "volar",
--           "cssmodules_ls",
--           "emmet_ls",
--         },
--       })
--     end,
--   },
--   {
--     "neovim/nvim-lspconfig",
--     config = function()
--       local capabilities = require("cmp_nvim_lsp").default_capabilities()
--
--       local lspconfig = require("lspconfig")
--       -- LSP
--       lspconfig.lua_ls.setup({
--         capabilities = capabilities,
--       })
--       lspconfig.volar.setup({
--         capabilities = capabilities,
--         filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
--       })
--       lspconfig.cssmodules_ls.setup({
--         capabilities = capabilities,
--       })
--       lspconfig.emmet_ls.setup({
--         capabilities = capabilities
--       })
--       vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
--       vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
--       vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
--     end,
--   },
-- }
