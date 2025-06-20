[{1 :nvim-treesitter/nvim-treesitter
    :lazy false
    :branch :main
    :build [#(let [treesitter (require :nvim-treesitter)
                   parsers [:bash
                            :c
                            :c3
                            :c_sharp
                            :clojure
                            :commonlisp
                            :cpp
                            :css
                            :dart
                            :diff
                            :elixir
                            :fennel
                            :fsharp
                            :gitignore
                            :go
                            :haskell
                            :html
                            :java
                            :javascript :jsdoc :jsx
                            :json :jsonc
                            :just
                            :kotlin
                            :lua
                            :make
                            :markdown :markdown_inline
                            :nix
                            :ocaml
                            :odin
                            :powershell
                            :purescript
                            :python
                            :query
                            :regex
                            :rust
                            :scala
                            :sql
                            :swift
                            :toml
                            :tsx :typescript
                            :typst
                            :vim :vimdoc
                            :vue
                            :xml
                            :yaml
                            :zig]]
               (treesitter.install parsers)
               (treesitter.update))
            ::TSUpdate]
    :init #(vim.api.nvim_create_autocmd
             :FileType
             {:callback (fn [args]
                          (local filetype args.match)
                          (local lang (vim.treesitter.language.get_lang filetype))
                          (when (vim.treesitter.language.add lang)
                            (set vim.bo.indentexpr "v:lua.require'nvim-treesitter'.indentexpr()")
                            (set vim.wo.foldexpr "v:lua.vim.treesitter.foldexpr()")
                            (vim.treesitter.start)))})}

 {1 :nvim-treesitter/nvim-treesitter-textobjects
  :branch :main
  :opts {}}

 {1 :nvim-treesitter/nvim-treesitter-context
  :lazy false
  :keys [{1 "<Leader>cc" :mode :n
          2 #((. (require :treesitter-context) :go_to_context) vim.v.count1)
          :desc "Jump to context (upwards)"}]
  :opts {}}]
