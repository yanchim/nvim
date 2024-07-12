-- [nfnl] Compiled from fnl/plugins/code.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local conform = require("conform")
  vim.keymap.set({"n", "v"}, "<leader>cf", conform.format, {desc = "Code format"})
  vim.keymap.set({"n", "v"}, "<leader>cF", "<Cmd>ConformInfo<CR>", {desc = "Code format info"})
  return conform.setup({formatters = {cljfmt = {command = "cljfmt", args = {"fix", "-"}}}, formatters_by_ft = {c = {"clang-format"}, clojure = {"cljfmt"}, cpp = {"clang-format"}, css = {"prettier"}, html = {"prettier"}, javascript = {"prettier"}, javascriptreact = {"prettier"}, json = {"prettier"}, markdown = {"prettier"}, rust = {"rustfmt"}, typescript = {"prettier"}, typescriptreact = {"prettier"}, vue = {"prettier"}, zig = {"zigfmt"}}})
end
local function _2_()
  local lint = require("lint")
  do
    local lint_augroup = vim.api.nvim_create_augroup("lint", {clear = true})
    local function _3_()
      return lint.try_lint()
    end
    vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost", "InsertLeave"}, {group = lint_augroup, callback = _3_})
  end
  lint.linters_by_ft = {c = {"clangtidy"}, cpp = {"clangtidy"}, fennel = {"fennel"}, zsh = {"zsh"}}
  return nil
end
return {{"bakpakin/fennel.vim", lazy = true, ft = {"fennel"}}, {"stevearc/conform.nvim", event = {"BufNewFile", "BufReadPre"}, opts = {}, config = _1_}, {"mfussenegger/nvim-lint", event = {"BufNewFile", "BufReadPre"}, config = _2_}, {"folke/ts-comments.nvim", event = "VeryLazy", opts = {}}}
