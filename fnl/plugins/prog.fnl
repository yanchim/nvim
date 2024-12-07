[{1 :Olical/conjure
  :ft [:clojure :fennel :hy :lua :python]
  :init (fn []
          (set vim.g.conjure#filetype#fennel "conjure.client.fennel.nfnl")
          ; Rebind from K to <prefix>K
          (set vim.g.conjure#mapping#doc_word "K"))}

 {1 :bakpakin/fennel.vim
  :lazy true
  ; For fennel's indent, which is not supported yet in nvim-treesitter.
  :ft [:fennel]}

 {1 :hylang/vim-hy
  :lazy true
  :ft [:hy]}

 {1 :stevearc/conform.nvim
  :event [:BufNewFile :BufReadPre]
  :opts {}
  :config #(let [conform (require :conform)]

             (vim.keymap.set [:n :v] :<Leader>cf conform.format {:desc "Code format"})
             (vim.keymap.set [:n :v] :<Leader>cF :<Cmd>ConformInfo<CR> {:desc "Code format info"})

             (conform.setup
               {:formatters
                {:google-java-format {:prepend_args ["--aosp"]}}
                :formatters_by_ft
                {:* [:trim_whitespace]
                 :c [:clang-format]
                 :cs [:csharpier]
                 :clojure [:cljfmt]
                 :cpp [:clang-format]
                 :css [:prettier]
                 :haskell [:ormolu]
                 :html [:prettier]
                 :go [:gofmt]
                 :java [:google-java-format]
                 :javascript [:prettier]
                 :javascriptreact [:prettier]
                 :json [:prettier]
                 :lua [:stylua]
                 :markdown [:prettier]
                 :nix [:nixfmt]
                 :python [:ruff_format]
                 :rust [:rustfmt]
                 :scala [:scalafmt]
                 :toml [:taplo]
                 :typescript [:prettier]
                 :typescriptreact [:prettier]
                 :typst [:typstyle]
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
