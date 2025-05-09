[{1 :neovim/nvim-lspconfig
  :event ["BufReadPre" "BufNewFile"]
  :dependencies [:hrsh7th/cmp-nvim-lsp]
  :init (fn []
          (vim.keymap.set :n :<Leader>ll vim.cmd.LspStart {:desc "Start LSP"})
          (vim.keymap.set :n :<Leader>lI #(vim.cmd.checkhealth :vim.lsp) {:desc "LSP Info"})
          (vim.keymap.set :n :<Leader>lR vim.cmd.LspRestart {:desc "Restart LSP"})
          (vim.keymap.set :n :<Leader>lQ vim.cmd.LspStop {:desc "Stop LSP"}))
  :config #(let [lsp (require :lspconfig)
                 cmplsp (require :cmp_nvim_lsp)
                 handlers {:textDocument/publishDiagnostics
                           (vim.lsp.with
                             vim.lsp.diagnostic.on_publish_diagnostics
                             {:severity_sort true
                              :update_in_insert true
                              :underline true
                              :virtual_text false})
                           :textDocument/hover
                           (vim.lsp.with vim.lsp.handlers.hover {:border :single})
                           :textDocument/signatureHelp
                           (vim.lsp.with vim.lsp.handlers.signature_help {:border :single})}
                 capabilities (cmplsp.default_capabilities)
                 before_init (fn [params]
                               (set params.workDoneToken :1))
                 on_attach (fn [client bufnr]
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
                             (vim.api.nvim_buf_set_keymap bufnr :n :<Leader>li "<Cmd>lua require('telescope.builtin').lsp_implementations()<CR>" {:noremap true}))]

             ; To add support to more language servers check:
             ; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

             ; Clangd.
             (lsp.clangd.setup {:autostart false
                                :on_attach on_attach
                                :handlers handlers
                                :before_init before_init
                                :capabilities capabilities})

             ; C#.
             (lsp.csharp_ls.setup {:autostart false
                                   :on_attach on_attach
                                   :handlers handlers
                                   :before_init before_init
                                   :capabilities capabilities})


             ; Clojure.
             (lsp.clojure_lsp.setup {:autostart false
                                     :on_attach on_attach
                                     :handlers handlers
                                     :before_init before_init
                                     :capabilities capabilities})

             ; Golang.
             (lsp.gopls.setup {:autostart false
                               :on_attach on_attach
                               :handlers handlers
                               :before_init before_init
                               :capabilities capabilities})

             ; Haskell.
             (lsp.hls.setup {:autostart false
                             :filetypes [:haskell :lhaskell :cabal]
                             :on_attach on_attach
                             :handlers handlers
                             :before_init before_init
                             :capabilities capabilities})

             ; Java.
             (lsp.jdtls.setup {:autostart false
                               :on_attach on_attach
                               :handlers handlers
                               :before_init before_init
                               :capabilities capabilities})

             ; Nix.
             (lsp.nixd.setup {:autostart false
                              :on_attach on_attach
                              :handlers handlers
                              :before_init before_init
                              :capabilities capabilities})

             ; Ocaml.
             (lsp.ocamllsp.setup {:autostart false
                                  :on_attach on_attach
                                  :handlers handlers
                                  :before_init before_init
                                  :capabilities capabilities})

             ; Rust.
             (lsp.rust_analyzer.setup {:autostart false
                                       :settings
                                       {:rust-analyzer
                                        {:procMacro
                                         {:ignored
                                          {:leptos_macro
                                           [;; optional
                                            ;; "component"
                                            :server]}}}}
                                       :on_attach on_attach
                                       :handlers handlers
                                       :before_init before_init
                                       :capabilities capabilities})

             ; Scala.
             (lsp.metals.setup {:autostart false
                                :on_attach on_attach
                                :handlers handlers
                                :before_init before_init
                                :capabilities capabilities})

             ; Slint.
             (lsp.slint_lsp.setup {:autostart false
                                   :on_attach on_attach
                                   :handlers handlers
                                   :before_init before_init
                                   :capabilities capabilities})

             ; Typescript.
             (lsp.ts_ls.setup {:autostart false
                               :init_options {:plugins [{:name "@vue/typescript-plugin"
                                                         :location ""
                                                         :languages [:javascript
                                                                     :javascriptreact
                                                                     :javascript.jsx
                                                                     :typescript
                                                                     :typescriptreact
                                                                     :typescript.tsx
                                                                     :vue]}]}
                               :filetypes [:javascript
                                           :javascriptreact
                                           :javascript.jsx
                                           :typescript
                                           :typescriptreact
                                           :typescript.tsx
                                           :vue]
                               :on_attach on_attach
                               :handlers handlers
                               :before_init before_init
                               :capabilities capabilities})

             ; Typst.
             (lsp.tinymist.setup {:autostart false
                                  :single_file_support true
                                  :on_attach on_attach
                                  :handlers handlers
                                  :before_init before_init
                                  :capabilities capabilities})

             ; Vue.
             (lsp.volar.setup {:autostart false
                               :on_attach on_attach
                               :handlers handlers
                               :before_init before_init
                               :capabilities capabilities})

             ; Zig.
             (lsp.zls.setup {:autostart false
                             :on_attach on_attach
                             :handlers handlers
                             :before_init before_init
                             :capabilities capabilities}))}]
