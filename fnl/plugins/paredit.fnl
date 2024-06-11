[{1 :julienvincent/nvim-paredit
  :lazy true
  :ft [:clojure :fennel]
  :config (fn []
            (let [paredit (require :nvim-paredit)]
              (paredit.setup)))}

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
              (autopairs.setup {:check_ts true})))}]
