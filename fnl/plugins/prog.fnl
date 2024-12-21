[{1 :Olical/conjure
  :ft [:clojure :fennel :hy :lua :python]
  :init (fn []
          (set vim.g.conjure#filetype#fennel "conjure.client.fennel.nfnl")
          ; Rebind from K to <prefix>K
          (set vim.g.conjure#mapping#doc_word "K"))}

 {1 :bakpakin/fennel.vim
  :lazy true
  ; For fennel's indent, which is not supported yet in nvim-treesitter.
  :ft :fennel}

 {1 :hylang/vim-hy
  :lazy true
  :ft :hy}

 {1 :nvim-flutter/flutter-tools.nvim
  :dependencies [:nvim-lua/plenary.nvim :stevearc/dressing.nvim]
  :ft :dart
  :config #(let [ft (require :flutter-tools)
                 telescope (require :telescope)]
             (telescope.load_extension :flutter)
             (vim.keymap.set [:n :v] :<Leader>mf telescope.extensions.flutter.commands {:desc "Flutter commands"})
             (ft.setup
               {:lsp
                {:on_attach (fn [client bufnr]
                              (vim.lsp.inlay_hint.enable true {: bufnr})
                              (vim.api.nvim_buf_set_keymap bufnr :n :gd "<Cmd>lua vim.lsp.buf.definition()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :K "<Cmd>lua vim.lsp.buf.hover()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>ld "<Cmd>lua vim.lsp.buf.declaration()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>lt "<Cmd>lua vim.lsp.buf.type_definition()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>lh "<Cmd>lua vim.lsp.buf.signature_help()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>ln "<Cmd>lua vim.lsp.buf.rename()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>le "<Cmd>lua vim.diagnostic.open_float()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>lq "<Cmd>lua vim.diagnostic.setloclist()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>lf "<Cmd>lua vim.lsp.buf.format()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>la "<Cmd>lua vim.lsp.buf.code_action()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :v :<Leader>la "<Cmd>lua vim.lsp.buf.code_action()<CR>" {:noremap true})
                              ; Telescope.
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>lw "<Cmd>lua require('telescope.builtin').diagnostics()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>lr "<Cmd>lua require('telescope.builtin').lsp_references()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>li "<Cmd>lua require('telescope.builtin').lsp_implementations()<CR>" {:noremap true}))}}))}

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
                 :dart [:dart_format]
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
