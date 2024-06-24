-- [nfnl] Compiled from fnl/plugins/treesitter.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local treesitter = require("nvim-treesitter.configs")
  return treesitter.setup({highlight = {enable = true}, indent = {enable = true}, ensure_installed = {"bash", "c", "clojure", "commonlisp", "cpp", "css", "dart", "elixir", "fennel", "gitignore", "go", "html", "java", "javascript", "jsdoc", "json", "lua", "markdown", "markdown_inline", "python", "query", "regex", "ruby", "rust", "toml", "tsx", "typescript", "typst", "vim", "vimdoc", "vue", "yaml", "zig"}, incremental_selection = {enable = true, keymaps = {init_selection = "<C-space>", node_incremental = "<C-space>", node_decremental = "<bs>", scope_incremental = false}}})
end
return {{"nvim-treesitter/nvim-treesitter", event = {"BufReadPre", "BufNewFile"}, build = ":TSUpdate", config = _1_}}
