[{1 :nvim-treesitter/nvim-treesitter
  :event ["BufReadPre" "BufNewFile"]
  :build ":TSUpdate"
  :config (fn []
            (let [treesitter (require :nvim-treesitter.configs)]
              (treesitter.setup
                {:highlight {:enable true}
                 :indent {:enable true}
                 :ensure_installed [:bash
                                    :c
                                    :clojure
                                    :commonlisp
                                    :cpp
                                    :css
                                    :dart
                                    :elixir
                                    :fennel
                                    :gitignore
                                    :go
                                    :html
                                    :java
                                    :javascript
                                    :json
                                    :lua
                                    :markdown
                                    :markdown_inline
                                    :python
                                    :query
                                    :regex
                                    :ruby
                                    :rust
                                    :toml
                                    :tsx
                                    :typescript
                                    :typst
                                    :vim
                                    :vimdoc
                                    :vue
                                    :yaml
                                    :zig]
                 :incremental_selection {:enable true
                                         :keymaps {:init_selection :<C-space>
                                                   :node_incremental :<C-space>
                                                   :node_decremental :<bs>
                                                   :scope_incremental false}}})))}]
