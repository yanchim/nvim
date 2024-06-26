-- [nfnl] Compiled from fnl/plugins/code.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local tcc = require("ts_context_commentstring")
  local internal = require("ts_context_commentstring.internal")
  local get_option = vim.filetype.get_option
  vim.g.skip_ts_context_commentstring_module = true
  local function _2_(filetype, option)
    return (((option == "commentstring") and internal.calculate_commentstring()) or get_option(filetype, option))
  end
  vim.filetype.get_option = _2_
  return tcc.setup({enable_autocmd = false})
end
return {{"bakpakin/fennel.vim", lazy = true, ft = {"fennel"}}, {"JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter", config = _1_}}
