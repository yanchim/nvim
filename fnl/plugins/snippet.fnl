[{1 :L3MON4D3/LuaSnip
  :build "make install_jsregexp"
  :config (fn []
            (let [ls (require :luasnip)
                  lsv (require :luasnip.loaders.from_vscode)]
              (vim.keymap.set :i :<C-K> (fn [] (if (ls.expand_or_jumpable) (ls.expand_or_jump))) {:silent true})
              (vim.keymap.set [:i :s] :<C-L> (fn [] (ls.jump 1)) {:silent true})
              (vim.keymap.set [:i :s] :<C-J> (fn [] (ls.jump -1)) {:silent true})
              (vim.keymap.set [:i :s] :<C-E> (fn [] (when (ls.choice_active) (ls.change_choice 1))) {:silent true})
              (lsv.lazy_load {:paths [:./etc/luasnip]})))}]
