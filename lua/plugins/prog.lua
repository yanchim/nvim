-- [nfnl] Compiled from fnl/plugins/prog.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  vim.g["conjure#filetype#fennel"] = "conjure.client.fennel.nfnl"
  vim.g["conjure#mapping#doc_word"] = "K"
  return nil
end
local function _2_()
  local conform = require("conform")
  vim.keymap.set({"n", "v"}, "<Leader>cf", conform.format, {desc = "Code format"})
  vim.keymap.set({"n", "v"}, "<Leader>cF", "<Cmd>ConformInfo<CR>", {desc = "Code format info"})
  return conform.setup({formatters = {["google-java-format"] = {prepend_args = {"--aosp"}}}, formatters_by_ft = {["*"] = {"trim_whitespace"}, c = {"clang-format"}, cs = {"csharpier"}, clojure = {"cljfmt"}, cpp = {"clang-format"}, css = {"prettier"}, haskell = {"ormolu"}, html = {"prettier"}, go = {"gofmt"}, java = {"google-java-format"}, javascript = {"prettier"}, javascriptreact = {"prettier"}, json = {"prettier"}, lua = {"stylua"}, markdown = {"prettier"}, nix = {"nixfmt"}, python = {"ruff_format"}, rust = {"rustfmt"}, scala = {"scalafmt"}, toml = {"taplo"}, typescript = {"prettier"}, typescriptreact = {"prettier"}, typst = {"typstyle"}, vue = {"prettier"}, zig = {"zigfmt"}}})
end
local function _3_()
  local lint = require("lint")
  do
    local lint_augroup = vim.api.nvim_create_augroup("lint", {clear = true})
    local function _4_()
      return lint.try_lint()
    end
    vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost", "InsertLeave"}, {group = lint_augroup, callback = _4_})
  end
  lint.linters_by_ft = {c = {"clangtidy"}, cpp = {"clangtidy"}, fennel = {"fennel"}, zsh = {"zsh"}}
  return nil
end
return {{"Olical/conjure", ft = {"clojure", "fennel", "hy", "lua", "python"}, init = _1_}, {"bakpakin/fennel.vim", lazy = true, ft = {"fennel"}}, {"hylang/vim-hy", lazy = true, ft = {"hy"}}, {"stevearc/conform.nvim", event = {"BufNewFile", "BufReadPre"}, opts = {}, config = _2_}, {"mfussenegger/nvim-lint", event = {"BufNewFile", "BufReadPre"}, config = _3_}, {"folke/ts-comments.nvim", event = "VeryLazy", opts = {}}}
