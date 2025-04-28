-- [nfnl] fnl/plugins/prog.fnl
local function _1_()
  vim.g["conjure#filetype#fennel"] = "conjure.client.fennel.nfnl"
  vim.g["conjure#mapping#doc_word"] = "K"
  return nil
end
local function _2_()
  local ft = require("flutter-tools")
  local telescope = require("telescope")
  telescope.load_extension("flutter")
  vim.keymap.set({"n", "v"}, "<Leader>mf", telescope.extensions.flutter.commands, {desc = "Flutter commands"})
  local function _3_(client, bufnr)
    vim.lsp.inlay_hint.enable(true, {bufnr = bufnr})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>ld", "<Cmd>lua vim.lsp.buf.declaration()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>lt", "<Cmd>lua vim.lsp.buf.type_definition()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>lh", "<Cmd>lua vim.lsp.buf.signature_help()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>ln", "<Cmd>lua vim.lsp.buf.rename()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>le", "<Cmd>lua vim.diagnostic.open_float()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>lq", "<Cmd>lua vim.diagnostic.setloclist()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>lf", "<Cmd>lua vim.lsp.buf.format()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>la", "<Cmd>lua vim.lsp.buf.code_action()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "v", "<Leader>la", "<Cmd>lua vim.lsp.buf.code_action()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>lw", "<Cmd>lua require('telescope.builtin').diagnostics()<CR>", {noremap = true})
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>lr", "<Cmd>lua require('telescope.builtin').lsp_references()<CR>", {noremap = true})
    return vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>li", "<Cmd>lua require('telescope.builtin').lsp_implementations()<CR>", {noremap = true})
  end
  return ft.setup({lsp = {on_attach = _3_}})
end
local function _4_()
  return require("conform").format({async = true})
end
return {{"Olical/conjure", ft = {"clojure", "fennel", "hy", "lua", "python"}, init = _1_}, {"bakpakin/fennel.vim", lazy = true, ft = "fennel"}, {"hylang/vim-hy", lazy = true, ft = "hy"}, {"nvim-flutter/flutter-tools.nvim", dependencies = {"nvim-lua/plenary.nvim", "stevearc/dressing.nvim"}, ft = "dart", config = _2_}, {"stevearc/conform.nvim", event = {"BufNewFile", "BufReadPre"}, keys = {{"<Leader>cf", _4_, desc = "Code format", mode = {"n", "v"}}, {"<Leader>cF", vim.cmd.ConformInfo, desc = "Code format", mode = {"n", "v"}}}, opts = {formatters = {["google-java-format"] = {prepend_args = {"--aosp"}}}, formatters_by_ft = {["*"] = {"trim_whitespace"}, c = {"clang-format"}, cs = {"csharpier"}, clojure = {"cljfmt"}, cpp = {"clang-format"}, css = {"prettier"}, dart = {"dart_format"}, haskell = {"ormolu"}, html = {"prettier"}, go = {"gofmt"}, java = {"google-java-format"}, javascript = {"prettier"}, javascriptreact = {"prettier"}, json = {"prettier"}, jsonc = {"prettier"}, lua = {"stylua"}, markdown = {"prettier"}, nix = {"nixfmt"}, python = {"ruff_format"}, rust = {"rustfmt"}, scala = {"scalafmt"}, toml = {"taplo"}, typescript = {"prettier"}, typescriptreact = {"prettier"}, typst = {"typstyle"}, vue = {"prettier"}, zig = {"zigfmt"}}}}, {"folke/ts-comments.nvim", event = "VeryLazy", opts = {}}}
