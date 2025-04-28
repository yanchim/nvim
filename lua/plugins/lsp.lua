-- [nfnl] fnl/plugins/lsp.fnl
local function _1_()
  vim.keymap.set("n", "<Leader>ll", vim.cmd.LspStart, {desc = "Start LSP"})
  local function _2_()
    return vim.cmd.checkhealth("vim.lsp")
  end
  vim.keymap.set("n", "<Leader>lI", _2_, {desc = "LSP Info"})
  vim.keymap.set("n", "<Leader>lR", vim.cmd.LspRestart, {desc = "Restart LSP"})
  return vim.keymap.set("n", "<Leader>lQ", vim.cmd.LspStop, {desc = "Stop LSP"})
end
local function _3_()
  local lsp = require("lspconfig")
  local cmplsp = require("cmp_nvim_lsp")
  local handlers = {["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {severity_sort = true, update_in_insert = true, underline = true, virtual_text = false}), ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "single"}), ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "single"})}
  local capabilities = cmplsp.default_capabilities()
  local before_init
  local function _4_(params)
    params.workDoneToken = "1"
    return nil
  end
  before_init = _4_
  local on_attach
  local function _5_(client, bufnr)
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
  on_attach = _5_
  lsp.clangd.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.csharp_ls.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.clojure_lsp.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.gopls.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.hls.setup({filetypes = {"haskell", "lhaskell", "cabal"}, on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.jdtls.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.nixd.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.ocamllsp.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.rust_analyzer.setup({settings = {["rust-analyzer"] = {procMacro = {ignored = {leptos_macro = {"server"}}}}}, on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.metals.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.slint_lsp.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.ts_ls.setup({init_options = {plugins = {{name = "@vue/typescript-plugin", location = "", languages = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue"}}}}, filetypes = {"javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue"}, on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.tinymist.setup({single_file_support = true, on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  lsp.volar.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
  return lsp.zls.setup({on_attach = on_attach, handlers = handlers, before_init = before_init, capabilities = capabilities, autostart = false})
end
return {{"neovim/nvim-lspconfig", event = {"BufReadPre", "BufNewFile"}, dependencies = {"hrsh7th/cmp-nvim-lsp"}, init = _1_, config = _3_}}
