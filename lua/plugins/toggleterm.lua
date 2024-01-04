return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      start_in_insert = false,
    });

    vim.keymap.set('n', '<C-t>', ':ToggleTerm direction=float name=terminal<CR>', {});
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], {});
  end
}
