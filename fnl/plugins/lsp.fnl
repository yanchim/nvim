[{1 :neovim/nvim-lspconfig
  :event ["BufReadPre" "BufNewFile"]
  :dependencies [:hrsh7th/cmp-nvim-lsp]
  :config #(let [cmplsp (require :cmp_nvim_lsp)]
             (vim.api.nvim_create_autocmd
               :LspAttach
               {:callback
                (fn []
                  (vim.keymap.set :n :gd "<Cmd>lua vim.lsp.buf.definition()<CR>" {:noremap true})
                  (vim.keymap.set :n :gD "<Cmd>lua vim.lsp.buf.declaration()<CR>" {:noremap true})
                  ; Leaderkey.
                  (vim.keymap.set :n :<Leader>lh "<Cmd>lua vim.lsp.buf.signature_help()<CR>" {:noremap true})
                  (vim.keymap.set :n :<Leader>ln "<Cmd>lua vim.lsp.buf.rename()<CR>" {:noremap true})
                  (vim.keymap.set :n :<Leader>le "<Cmd>lua vim.diagnostic.open_float()<CR>" {:noremap true})
                  (vim.keymap.set :n :<Leader>lq "<Cmd>lua vim.diagnostic.setloclist()<CR>" {:noremap true})
                  (vim.keymap.set :n :<Leader>lf "<Cmd>lua vim.lsp.buf.format()<CR>" {:noremap true})
                  (vim.keymap.set :n :<Leader>la "<Cmd>lua vim.lsp.buf.code_action()<CR>" {:noremap true})
                  (vim.keymap.set :v :<Leader>la "<Cmd>lua vim.lsp.buf.code_action()<CR>" {:noremap true})
                  ; Telescope.
                  (vim.keymap.set :n :<Leader>ld "<Cmd>Telescope lsp_definitions<CR>" {:noremap true})
                  (vim.keymap.set :n :<Leader>lt "<Cmd>Telescope lsp_type_definitions<CR>" {:noremap true})
                  (vim.keymap.set :n :<Leader>lw "<Cmd>Telescope diagnostics<CR>" {:noremap true})
                  (vim.keymap.set :n :<Leader>lr "<Cmd>Telescope lsp_references<CR>" {:noremap true})
                  (vim.keymap.set :n :<Leader>ls "<Cmd>Telescope lsp_document_symbols<CR>" {:noremap true})
                  (vim.keymap.set :n :<Leader>lS "<Cmd>Telescope lsp_workspace_symbols<CR>" {:noremap true})
                  (vim.keymap.set :n :<Leader>li "<Cmd>Telescope lsp_implementations<CR>" {:noremap true}))
                :desc "On LSP Attach"})

             ; To add support to more language servers check:
             ; https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

             ; Default configuration for all clients.
             (vim.lsp.config :* {:capabilities (cmplsp.default_capabilities)})

             ; Typescript.
             (vim.lsp.config :ts_ls
                             {:init_options {:plugins [{:name "@vue/typescript-plugin"
                                                        :location ""
                                                        :languages [:javascript :javascriptreact :javascript.jsx
                                                                    :typescript :typescriptreact :typescript.tsx
                                                                    :vue]}]}
                              :filetypes [:javascript :javascriptreact :javascript.jsx
                                          :typescript :typescriptreact :typescript.tsx
                                          :vue]})

             ; Vue.
             (vim.lsp.config :volar {})

             (vim.lsp.enable [:c3_lsp
                              :clangd
                              :gopls
                              :ols
                              :rust_analyzer
                              :ts_ls :vue_ls
                              :zls]))}]
