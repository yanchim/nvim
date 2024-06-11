(local lisp-ft [:clojure :fennel :lisp :scheme])

[{1 :julienvincent/nvim-paredit
  :lazy true
  :ft lisp-ft
  :config (fn []
            (let [paredit (require :nvim-paredit)]
              (paredit.setup
                {:keys
                 {:<M-H> [paredit.api.slurp_backwards "Slurp backwards"]
                  :<M-J> [paredit.api.barf_backwards "Barf backwards"]
                  :<M-K> [paredit.api.barf_forwards "Barf forwards"]
                  :<M-L> [paredit.api.slurp_forwards "Slurp forwards"]

                  :<localleader>9
                  [(fn []
                     (paredit.cursor.place_cursor
                       (paredit.wrap.wrap_element_under_cursor "( " ")")
                       {:placement :inner_start
                        :mode :insert}))
                   "Wrap element insert head"]

                  :<localleader>0
                  [(fn []
                     (paredit.cursor.place_cursor
                       (paredit.wrap.wrap_element_under_cursor "(" ")")
                       {:placement :inner_end
                        :mode :insert}))
                   "Wrap element insert tail"]}})))}

 {1 :julienvincent/nvim-paredit-fennel
  :dependencies [:julienvincent/nvim-paredit]
  :lazy true
  :ft [:fennel]
  :config (fn []
            (let [paredit-fnl (require :nvim-paredit-fennel)]
              (paredit-fnl.setup)))}

 {1 :windwp/nvim-autopairs
  :event "InsertEnter"
  :dependencies [:hrsh7th/nvim-cmp]
  :config (fn []
            (let [autopairs (require :nvim-autopairs)
                  autopairs-cmp (require :nvim-autopairs.completion.cmp)
                  cmp (require :cmp) ]
              (cmp.event:on :confirm_done (autopairs-cmp.on_confirm_done))
              (autopairs.setup {:disable_filetype lisp-ft})))}]
