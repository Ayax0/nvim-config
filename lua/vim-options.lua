vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set number")
vim.cmd("set splitbelow")
vim.cmd("set relativenumber")
vim.g.mapleader = " "

vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.cmd("LspRestart")
	end,
})
