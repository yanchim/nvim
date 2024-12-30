-- [nfnl] Compiled from fnl/plugins/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local treesitter = require("nvim-treesitter.configs")
  local context = require("treesitter-context")
  local function _2_()
    return context.go_to_context(vim.v.count1)
  end
  vim.keymap.set("n", "<LocalLeader>ac", _2_, {silent = true, desc = "Go to nearest context"})
  return treesitter.setup({ensure_installed = {"bash", "c", "c_sharp", "clojure", "commonlisp", "cpp", "css", "dart", "diff", "elixir", "fennel", "fsharp", "gitignore", "go", "haskell", "html", "java", "javascript", "jsdoc", "json", "jsonc", "kotlin", "lua", "make", "markdown", "markdown_inline", "nix", "powershell", "python", "query", "regex", "rust", "scala", "slint", "sql", "swift", "toml", "tsx", "typescript", "typst", "vim", "vimdoc", "vue", "xml", "yaml", "zig"}, highlight = {enable = true, additional_vim_regex_highlighting = false}, indent = {enable = true}, incremental_selection = {enable = true, keymaps = {init_selection = "<C-Space>", node_incremental = "<C-Space>", node_decremental = "<BS>", scope_incremental = false}}, context = {enable = true}, textobjects = {enable = true, lsp_interop = {enable = false}, move = {enable = true, set_jumps = true}, select = {enable = true, lookahead = true, keymaps = {ac = {query = "@class.outer", desc = "Select inner part of a class region"}, ic = {query = "@class.inner", desc = "Select outer part of a class region"}, af = {query = "@function.outer", desc = "Select inner part of a function"}, ["if"] = {query = "@function.inner", desc = "Select inner part of a function"}, as = {query = "@scope", query_group = "locals", desc = "Select language scope"}}, selection_modes = {["@parameter.outer"] = "v", ["@function.outer"] = "V", ["@class.outer"] = "<C-V>"}}}})
end
return {{"nvim-treesitter/nvim-treesitter", event = {"BufReadPre", "BufNewFile"}, dependencies = {"nvim-treesitter/nvim-treesitter-context", "nvim-treesitter/nvim-treesitter-textobjects"}, build = ":TSUpdate", config = _1_}}
