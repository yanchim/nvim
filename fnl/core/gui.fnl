;; Neovide.
; CJK input in neovide.
(when vim.g.neovide
  (fn set_ime [args]
    (if (args.event:match :Enter$)
      (set vim.g.neovide_input_ime true)
      (set vim.g.neovide_input_ime false)))

  (local ime_input (vim.api.nvim_create_augroup :ime_input {:clear true}))

  (vim.api.nvim_create_autocmd
    [:InsertEnter :InsertLeave]
    {:group ime_input :pattern "*" :callback set_ime})

  (vim.api.nvim_create_autocmd
    [:CmdlineEnter :CmdlineLeave]
    {:group ime_input :pattern "[/\\?]" :callback set_ime}))

{}
