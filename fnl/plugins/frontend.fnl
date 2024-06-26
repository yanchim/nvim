[{1 :mattn/emmet-vim
  :ft [:css :html :javascriptreact :typescriptreact :vue]
  :init (fn []
          ; Install emmet for frontend files only.
          (set vim.g.user_emmet_install_global 0)
          (vim.api.nvim_create_autocmd
            :FileType {:pattern [:css :html :javascriptreact :typescriptreact :vue]
                       :command :EmmetInstall})
          ; Enable emmet in INSERT and NORMAL only.
          (set vim.g.user_emmet_mode :in)
          ; Remap emmet leader key.
          (set vim.g.user_emmet_leader_key :<C-g>))}]
