[{1 :Olical/conjure
  :ft [:clojure :fennel :hy :lua :python]
  :init (fn []
          (set vim.g.conjure#filetype#fennel "conjure.client.fennel.nfnl")
          ; Rebind from K to <prefix>K
          (set vim.g.conjure#mapping#doc_word "K"))}

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
                              (vim.api.nvim_buf_set_keymap bufnr :n :gd "<Cmd>lua vim.lsp.buf.definition()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :gD "<Cmd>lua vim.lsp.buf.declaration()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :K "<Cmd>lua vim.lsp.buf.hover()<CR>" {:noremap true})
                              ; Leaderkey.
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>lh "<Cmd>lua vim.lsp.buf.signature_help()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>ln "<Cmd>lua vim.lsp.buf.rename()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>le "<Cmd>lua vim.diagnostic.open_float()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>lq "<Cmd>lua vim.diagnostic.setloclist()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>lf "<Cmd>lua vim.lsp.buf.format()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>la "<Cmd>lua vim.lsp.buf.code_action()<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :v :<Leader>la "<Cmd>lua vim.lsp.buf.code_action()<CR>" {:noremap true})
                              ; Telescope.
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>ld "<Cmd>Telescope lsp_definitions<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>lt "<Cmd>Telescope lsp_type_definitions<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>lw "<Cmd>Telescope diagnostics<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>lr "<Cmd>Telescope lsp_references<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>ls "<Cmd>Telescope lsp_document_symbols<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>lS "<Cmd>Telescope lsp_workspace_symbols<CR>" {:noremap true})
                              (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>li "<Cmd>Telescope lsp_implementations<CR>" {:noremap true}))}}))}

 {1 :stevearc/conform.nvim
  :event [:BufNewFile :BufReadPre]
  :keys [{1 :<Leader>cf
          2 #((. (require :conform) :format) {:async true})
          :desc "Code format"
          :mode [:n :v]}
         {1 :<Leader>cF
          2 vim.cmd.ConformInfo
          :desc "Code format"
          :mode [:n :v]}]
  :opts {:formatters {:google-java-format {:prepend_args ["--aosp"]}}
         :formatters_by_ft {:* [:trim_whitespace]
                            :c [:clang-format]
                            :cs [:csharpier]
                            :clojure [:cljfmt]
                            :cpp [:clang-format]
                            :css [:prettier]
                            :dart [:dart_format]
                            :go [:gofmt]
                            :haskell [:ormolu]
                            :html [:prettier]
                            :java [:google-java-format]
                            :javascript [:prettier]
                            :javascript.jsx [:prettier]
                            :javascriptreact [:prettier]
                            :json [:prettier]
                            :jsonc [:prettier]
                            :lua [:stylua]
                            :markdown [:prettier]
                            :nix [:nixfmt]
                            :odin [:odinfmt]
                            :python [:ruff_format]
                            :rust [:rustfmt]
                            :scala [:scalafmt]
                            :toml [:taplo]
                            :typescript [:prettier]
                            :typescript.tsx [:prettier]
                            :typescriptreact [:prettier]
                            :typst [:typstyle]
                            :vue [:prettier]
                            :zig [:zigfmt]}}}

 {1 :folke/ts-comments.nvim
  :event :VeryLazy
  :opts {}}]
