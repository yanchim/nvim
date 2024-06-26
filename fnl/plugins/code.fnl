[{1 :bakpakin/fennel.vim
  :lazy true
  ; For fennel's indent, which is not supported yet in nvim-treesitter.
  :ft [:fennel]}

 {1 :JoosepAlviste/nvim-ts-context-commentstring
  :after :nvim-treesitter
  :config #(let [tcc (require :ts_context_commentstring)
                 internal (require :ts_context_commentstring.internal)
                 get-option vim.filetype.get_option]
             (set vim.g.skip_ts_context_commentstring_module true)
             (set vim.filetype.get_option
                  (fn [filetype option]
                    (or (and (= option :commentstring)
                             (internal.calculate_commentstring))
                        (get-option filetype option))))
             (tcc.setup {:enable_autocmd false}))}]
