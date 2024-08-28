return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		{ "jay-babu/mason-null-ls.nvim" },
	},
	config = function()
		local none_ls_mason = require("mason-null-ls")
		local none_ls = require("null-ls")

		none_ls_mason.setup({
			ensure_installed = {
				"stylua",
				"biome",
			},
		})

		none_ls.setup({
			sources = {
				none_ls.builtins.formatting.stylua,

				none_ls.builtins.formatting.biome,
				none_ls.builtins.diagnostics.biome,
			},
			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
					})
				end
			end,
		})
	end,
}
