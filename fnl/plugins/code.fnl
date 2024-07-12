[{1 :bakpakin/fennel.vim
  :lazy true
  ; For fennel's indent, which is not supported yet in nvim-treesitter.
  :ft [:fennel]}

 {1 :stevearc/conform.nvim
  :event [:BufNewFile :BufReadPre]
  :opts {}
  :config #(let [conform (require :conform)]

             (vim.keymap.set [:n :v] :<leader>cf conform.format {:desc "Code format"})
             (vim.keymap.set [:n :v] :<leader>cF :<Cmd>ConformInfo<CR> {:desc "Code format info"})

             (conform.setup
               {:formatters {:cljfmt {:command :cljfmt :args [:fix :-]}}
                :formatters_by_ft
                {:c [:clang-format]
                 :clojure [:cljfmt]
                 :cpp [:clang-format]
                 :css [:prettier]
                 :html [:prettier]
                 :javascript [:prettier]
                 :javascriptreact [:prettier]
                 :json [:prettier]
                 :markdown [:prettier]
                 :rust [:rustfmt]
                 :typescript [:prettier]
                 :typescriptreact [:prettier]
                 :vue [:prettier]
                 :zig [:zigfmt]}}))}

 {1 :mfussenegger/nvim-lint
  :event [:BufNewFile :BufReadPre]
  :config #(let [lint (require :lint)]
             (let [lint-augroup (vim.api.nvim_create_augroup :lint {:clear true})]
               (vim.api.nvim_create_autocmd
                 [:BufEnter :BufWritePost :InsertLeave]
                 {:group lint-augroup :callback #(lint.try_lint)}))

             (set lint.linters_by_ft
                  {:c [:clangtidy]
                   :cpp [:clangtidy]
                   :fennel [:fennel]
                   :zsh [:zsh]}))}

 {1 :folke/ts-comments.nvim
  :event :VeryLazy
  :opts {}}]
