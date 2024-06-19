[{1 :garymjr/nvim-snippets
  :event :InsertEnter
  :opts {}
  :keys [{1 :<C-K>
          2 #(if
               (vim.snippet.active {:direction 1}) (vim.schedule #(vim.snippet.jump 1))
               ; nvim-snippets does not support expand for now...
               :<C-K>)
          :expr true :silent true :mode :i}
         {1 :<C-L>
          2 #(vim.schedule #(vim.snippet.jump 1))
          :expr true :silent true :mode [:i :s]}
         {1 :<C-J>
          2 #(if
               (vim.snippet.active {:direction -1}) (vim.schedule #(vim.snippet.jump -1))
               :<C-J>)
          :expr true :silent true :mode [:i :s]}]}]
