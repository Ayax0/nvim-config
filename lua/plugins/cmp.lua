return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "onsails/lspkind.nvim" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "saadparwaiz1/cmp_luasnip" },
    { "hrsh7th/cmp-nvim-lua" },
    { "L3MON4D3/LuaSnip" },
    { "rafamadriz/friendly-snippets" },
  },
  config = function()
    local cmp = require("cmp");
    local cmp_action = require("lsp-zero").cmp_action();
    local cmp_autopairs = require("nvim-autopairs.completion.cmp");
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done());

    local luasnip = require("luasnip");
    require("luasnip.loaders.from_vscode").lazy_load();

    local function has_words_before()
      local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup({
      enabled = function()
        -- disables in comments
        local context = require("cmp.config.context")
        if vim.api.nvim_get_mode().mode == "c" then
          return true
        else
          return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
        end
      end,
      preselect = "none",
      completion = {
        keyword_length = 1,
        completeopt = "menu,menuone,noinsert",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        fields = { "abbr", "kind", "menu" },
        format = require("lspkind").cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
          mode = "symbol_text",
          symbol_map = { Copilot = "" },
        }),
      },
      mapping = {
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<C-n>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-p>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping.scroll_docs(-4),
        ["<C-j>"] = cmp.mapping.scroll_docs(4),
        ["<C-c>"] = cmp.mapping.abort(),
        ["<C-Space>"] = { i = cmp.mapping.complete() },
        ["<C-f>"] = cmp_action.luasnip_jump_forward(),
        ["<C-b>"] = cmp_action.luasnip_jump_backward(),
      },
      sources = {
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "path",    option = { trailing_slash = true } },
      },
    })
  end
}
