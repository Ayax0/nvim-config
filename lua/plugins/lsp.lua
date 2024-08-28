return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	dependencies = {
		{ "neovim/nvim-lspconfig" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
	},
	config = function()
		local lsp = require("lsp-zero")
		lsp.preset("minimal")

		lsp.set_sign_icons({
			error = "✘",
			warn = "▲",
			hint = "⚑",
			info = "»",
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		local lspconfig = require("lspconfig")

		lspconfig.volar.setup({
			filetypes = {
				"typescript",
				"javascript",
				"javascriptreact",
				"typescriptreact",
				"vue",
				"json",
			},
		})

		lspconfig.biome.setup({})

		lsp.setup()

		vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		vim.keymap.set("n", "<leader>rl", ":LspRestart<CR>", {})
	end,
}
