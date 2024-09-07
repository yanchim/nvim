-- [nfnl] Compiled from fnl/plugins/lsp.fnl by https://github.com/Olical/nfnl, do not edit.
local function define_signs(prefix)
  local error = (prefix .. "SignError")
  local warn = (prefix .. "SignWarn")
  local info = (prefix .. "SignInfo")
  local hint = (prefix .. "SignHint")
  vim.fn.sign_define(error, {text = "\239\129\151", texthl = error})
  vim.fn.sign_define(warn, {text = "\239\129\177", texthl = warn})
  vim.fn.sign_define(info, {text = "\239\129\154", texthl = info})
  return vim.fn.sign_define(hint, {text = "\239\129\153", texthl = hint})
end
define_signs("Diagnostic")
local function _1_()
  vim.keymap.set("n", "<Leader>ll", vim.cmd.LspStart, {desc = "Start LSP"})
  vim.keymap.set("n", "<Leader>lI", vim.cmd.LspInfo, {desc = "LSP Info"})
  vim.keymap.set("n", "<Leader>lR", vim.cmd.LspRestart, {desc = "Restart LSP"})
  return vim.keymap.set("n", "<Leader>lQ", vim.cmd.LspStop, {desc = "Stop LSP"})
end
local function _2_()
  local lsp = require("lspconfig")
  local cmplsp = require("cmp_nvim_lsp")
  local handlers = {["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {severity_sort = true, update_in_insert = true, underline = true, virtual_text = false}), ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "single"}), ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"})}
  local capabilities = cmplsp.default_capabilities()
  local before_init
  local function _3_(params)
    params.workDoneToken = "1"
    return nil
  end
  before_init = _3_
  local on_attach
  local function _4_(client, bufnr)
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
  on_attach = _4_
  lsp.clangd.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.clojure_lsp.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.metals.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.nixd.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.rust_analyzer.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.slint_lsp.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.ts_ls.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.tinymist.setup({single_file_support = true, on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  return lsp.zls.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
end
return {{"neovim/nvim-lspconfig", event = {"BufReadPre", "BufNewFile"}, dependencies = {"hrsh7th/cmp-nvim-lsp"}, init = _1_, config = _2_}}
