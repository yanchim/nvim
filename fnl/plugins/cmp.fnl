(local cmp-src-menu-items
  {:buffer :buff
   :conjure :conj
   :orgmode :org
   :nvim_lsp :lsp
   :snippets :snp})

(local cmp-srcs
  [{:name :buffer}
   {:name :conjure}
   {:name :nvim_lsp}
   {:name :orgmode}
   {:name :path}
   {:name :snippets}])

(fn has-words-before []
  (let [[line col] (vim.api.nvim_win_get_cursor 0)]
    (and (not= col 0)
         (let [[current-line] (vim.api.nvim_buf_get_lines 0
                                                          (- line 1)
                                                          line true)
               word-before (current-line:sub col col)]
           (= (word-before:match "%s") nil)))))

(fn snippet-next [fallback]
  (local cmp (require :cmp))
  (if (cmp.visible) (cmp.select_next_item)
      (vim.snippet.active {:direction 1}) (vim.schedule #(vim.snippet.jump 1))
      (has_words_before) (cmp.complete)
      (fallback)))

(fn snippet-prev [fallback]
  (local cmp (require :cmp))
  (if (cmp.visible) (cmp.select_prev_item)
      (vim.snippet.active {:direction -1}) (vim.schedule #(vim.snippet.jump -1))
      (fallback)))

[{1 :hrsh7th/nvim-cmp
  :event :InsertEnter
  :dependencies [:hrsh7th/cmp-buffer ; Source for text in buffer.
                 :hrsh7th/cmp-path ; Source for file system path.
                 :PaterJason/cmp-conjure]
  :config (fn []
            (let [cmp (require :cmp)]
              (cmp.setup {:formatting {:format (fn [entry item]
                                                 (set item.menu (or (. cmp-src-menu-items entry.source.name) ""))
                                                 item)}
                          :mapping {:<C-p> (cmp.mapping.select_prev_item)
                                    :<C-n> (cmp.mapping.select_next_item)
                                    :<C-b> (cmp.mapping.scroll_docs (- 4))
                                    :<C-f> (cmp.mapping.scroll_docs 4)
                                    :<M-p> (cmp.mapping.scroll_docs (- 4))
                                    :<M-n> (cmp.mapping.scroll_docs 4)
                                    :<C-Space> (cmp.mapping.complete)
                                    :<C-e> (cmp.mapping.close)
                                    :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Insert :select true})
                                    :<Tab> (cmp.mapping snippet-next {1 :i 2 :s})
                                    :<S-Tab> (cmp.mapping snippet-prev {1 :i 2 :s})}
                          :sources cmp-srcs})))}]

