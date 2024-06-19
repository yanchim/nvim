[{1 :julienvincent/nvim-paredit
  :lazy true
  :ft [:clojure :fennel :lisp :scheme]
  :config #(let [paredit (require :nvim-paredit)]
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
                  "Wrap element insert tail"]}}))}

 {1 :julienvincent/nvim-paredit-fennel
  :dependencies [:julienvincent/nvim-paredit]
  :lazy true
  :ft [:fennel]
  :config #(let [paredit-fnl (require :nvim-paredit-fennel)]
             (paredit-fnl.setup))}]
