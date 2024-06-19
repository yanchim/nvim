; Symbols to show for lsp diagnostics.
(fn define-signs
  [prefix]
  (let [error (.. prefix "SignError")
        warn  (.. prefix "SignWarn")
        info  (.. prefix "SignInfo")
        hint  (.. prefix "SignHint")]
    (vim.fn.sign_define error {:text "" :texthl error})
    (vim.fn.sign_define warn  {:text "" :texthl warn})
    (vim.fn.sign_define info  {:text "" :texthl info})
    (vim.fn.sign_define hint  {:text "" :texthl hint})))

(define-signs "Diagnostic")

[{1 :neovim/nvim-lspconfig
  :event ["BufReadPre" "BufNewFile"]
  :dependencies [:hrsh7th/cmp-nvim-lsp]
  :init (fn []
          (vim.keymap.set :n :<leader>ll :<cmd>LspStart<CR> {:desc "Start LSP"})
          (vim.keymap.set :n :<leader>lR :<cmd>LspRestart<CR> {:desc "Restart LSP"})
          (vim.keymap.set :n :<leader>lQ :<cmd>LspStop<CR> {:desc "Stop LSP"}))
  :config #(let [lsp (require :lspconfig)
                 cmplsp (require :cmp_nvim_lsp)
                 handlers {"textDocument/publishDiagnostics"
                           (vim.lsp.with
                             vim.lsp.diagnostic.on_publish_diagnostics
                             {:severity_sort true
                              :update_in_insert true
                              :underline true
                              :virtual_text false})
                           "textDocument/hover"
                           (vim.lsp.with
                             vim.lsp.handlers.hover
                             {:border "single"})
                           "textDocument/signatureHelp"
                           (vim.lsp.with
                             vim.lsp.handlers.signature_help
                             {:border "single"})}
                 capabilities (cmplsp.default_capabilities)
                 before_init (fn [params]
                               (set params.workDoneToken :1))
                 on_attach (fn [client bufnr]
                             (vim.lsp.inlay_hint.enable true {: bufnr})
                             (vim.api.nvim_buf_set_keymap bufnr :n :gd "<cmd>lua vim.lsp.buf.definition()<CR>" {:noremap true})
                             (vim.api.nvim_buf_set_keymap bufnr :n :K "<cmd>lua vim.lsp.buf.hover()<CR>" {:noremap true})
                             (vim.api.nvim_buf_set_keymap bufnr :n :<leader>ld "<cmd>lua vim.lsp.buf.declaration()<CR>" {:noremap true})
                             (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lt "<cmd>lua vim.lsp.buf.type_definition()<CR>" {:noremap true})
                             (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lh "<cmd>lua vim.lsp.buf.signature_help()<CR>" {:noremap true})
                             (vim.api.nvim_buf_set_keymap bufnr :n :<leader>ln "<cmd>lua vim.lsp.buf.rename()<CR>" {:noremap true})
                             (vim.api.nvim_buf_set_keymap bufnr :n :<leader>le "<cmd>lua vim.diagnostic.open_float()<CR>" {:noremap true})
                             (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lq "<cmd>lua vim.diagnostic.setloclist()<CR>" {:noremap true})
                             (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lf "<cmd>lua vim.lsp.buf.format()<CR>" {:noremap true})
                             (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lj "<cmd>lua vim.diagnostic.goto_next()<CR>" {:noremap true})
                             (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lk "<cmd>lua vim.diagnostic.goto_prev()<CR>" {:noremap true})
                             (vim.api.nvim_buf_set_keymap bufnr :n :<leader>la "<cmd>lua vim.lsp.buf.code_action()<CR>" {:noremap true})
                             (vim.api.nvim_buf_set_keymap bufnr :v :<leader>la "<cmd>lua vim.lsp.buf.range_code_action()<CR> " {:noremap true})
                             ; Telescope.
                             (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lw ":lua require('telescope.builtin').diagnostics()<cr>" {:noremap true})
                             (vim.api.nvim_buf_set_keymap bufnr :n :<leader>lr ":lua require('telescope.builtin').lsp_references()<cr>" {:noremap true})
                             (vim.api.nvim_buf_set_keymap bufnr :n :<leader>li ":lua require('telescope.builtin').lsp_implementations()<cr>" {:noremap true}))]

             ;; To add support to more language servers check:
             ;; https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

             ;; Clojure.
             (lsp.clojure_lsp.setup {:autostart false
                                     :on_attach on_attach
                                     :handlers handlers
                                     :before_init before_init
                                     :capabilities capabilities})

             ;; Rust.
             (lsp.rust_analyzer.setup {:autostart false
                                       :on_attach on_attach
                                       :handlers handlers
                                       :before_init before_init
                                       :capabilities capabilities})

             ;; Typescript.
             (lsp.tsserver.setup {:autostart false
                                  :on_attach on_attach
                                  :handlers handlers
                                  :before_init before_init
                                  :capabilities capabilities})

             ;; Zig.
             (lsp.zls.setup {:autostart false
                             :on_attach on_attach
                             :handlers handlers
                             :before_init before_init
                             :capabilities capabilities}))}]
