[{1 :folke/which-key.nvim
  :event "VeryLazy"
  :init (fn []
          (set vim.o.timeout true)
          (set vim.o.timeoutlen 500))
  :opts {}
  :config (fn []
            (let [wk (require :which-key)]
              (wk.register
                {:<leader>e {:name :Explore}
                 :<leader>f {:name :Find}
                 :<leader>g {:name :Git
                             :h {:name :Hunk}}
                 :<leader>s {:name :Split}
                 :<leader>t {:name :Tab}})))}]
