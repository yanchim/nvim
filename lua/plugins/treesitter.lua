-- [nfnl] fnl/plugins/treesitter.fnl
local function _1_()
  local treesitter = require("nvim-treesitter")
  local parsers = {"bash", "c", "c3", "c_sharp", "clojure", "commonlisp", "cpp", "css", "dart", "diff", "elixir", "fennel", "fsharp", "gitignore", "go", "haskell", "html", "java", "javascript", "jsdoc", "jsx", "json", "jsonc", "just", "kotlin", "lua", "make", "markdown", "markdown_inline", "nix", "ocaml", "odin", "powershell", "purescript", "python", "query", "regex", "rust", "scala", "sql", "swift", "toml", "tsx", "typescript", "typst", "vim", "vimdoc", "vue", "xml", "yaml", "zig"}
  treesitter.install(parsers)
  return treesitter.update()
end
local function _2_()
  local function _3_(args)
    local filetype = args.match
    local lang = vim.treesitter.language.get_lang(filetype)
    if vim.treesitter.language.add(lang) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      return vim.treesitter.start()
    else
      return nil
    end
  end
  return vim.api.nvim_create_autocmd("FileType", {callback = _3_})
end
local function _5_()
  return require("treesitter-context").go_to_context(vim.v.count1)
end
return {{"nvim-treesitter/nvim-treesitter", branch = "main", build = {_1_, ":TSUpdate"}, init = _2_, lazy = false}, {"nvim-treesitter/nvim-treesitter-textobjects", branch = "main", opts = {}}, {"nvim-treesitter/nvim-treesitter-context", keys = {{"<Leader>cc", _5_, mode = "n", desc = "Jump to context (upwards)"}}, opts = {}, lazy = false}}
