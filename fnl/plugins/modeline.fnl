(local {: autoload} (require :nfnl.module))
(local lsp (autoload :core.lsp))

(fn lsp_connection []
  (let [message (lsp.get-progress-message)]
    (if
      ; If has progress handler and is loading.
      (or (= message.status :begin)
          (= message.status :report))
      (.. message.msg " : " message.percent "%% ")

      ; If has progress handler and finished loading.
      (= message.status "end")
      :

      ; If hasn't progress handler, but has connected lsp client.
      (and (= message.status "")
           (not (vim.tbl_isempty (vim.lsp.buf_get_clients 0))))
      :

      ; Else.
      :)))

[{1 :nvim-lualine/lualine.nvim
  :config #(let [lualine (require :lualine)]
             (lualine.setup
               {:options {:theme :auto
                          :icons_enabled false
                          :section_separators ""
                          :component_separators ""}
                :sections {:lualine_a [:mode]
                           :lualine_b [{1 :diagnostics
                                        :sections [:error :warn :info :hint]
                                        :sources [:nvim_lsp]}]
                           :lualine_c [{1 :filename
                                        :file_status true
                                        :path 1
                                        :shorting_target 40}]
                           :lualine_x [[lsp_connection]
                                       :filesize
                                       :encoding
                                       :fileformat
                                       :filetype]
                           :lualine_y [:progress]
                           :lualine_z [:location]}
                :inactive_sections {:lualine_a []
                                    :lualine_b []
                                    :lualine_c [{1 :filename
                                                 :file_status true
                                                 :path 1}]
                                    :lualine_x [:location]
                                    :lualine_y []
                                    :lualine_z []}}))}]
