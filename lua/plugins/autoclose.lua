return {
  "m4xshen/autoclose.nvim",
  config = function()
    require("autoclose").setup({
      --keys = {
      --  ["<"] = { escape = false, close = true, pair = "<>" }
      --},
      options = {
        disable_when_touch = true,
        touch_regex = "[%w(%[{]",
        pair_spaces = true,
        auto_indent = true
      },
    })
  end,
}
