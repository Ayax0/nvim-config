return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.5",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "kdheepak/lazygit.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    local telescope = require("telescope");
    telescope.load_extension("lazygit");
    telescope.load_extension("ui-select");

    telescope.setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
      }
    })

    local builtin = require("telescope.builtin");
    vim.keymap.set("n", "<C-p>", builtin.find_files, {})
    -- vim.keymap.set("n", "<C-g>", telescope.extensions.lazygit.lazygit, {})
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})

    vim.api.nvim_create_autocmd(
      "BufEnter",
      {
        callback = function()
          require('lazygit.utils').project_root_dir()
        end
      }
    )
  end,
}
