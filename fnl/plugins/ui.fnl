(local {: autoload} (require :nfnl.module))
(local lsp (autoload :core.lsp))

(fn lsp-connection []
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
           (not (vim.tbl_isempty (vim.lsp.get_clients {:bufnr (vim.api.nvim_get_current_buf)}))))
      :

      ; Else.
      :)))

[{1 :MunifTanjim/nui.nvim
  :lazy true}

 {1 :echasnovski/mini.icons
  :lazy true
  :opts {}
  :init #(let [icons (require :mini.icons)]
           (tset package.preload :nvim-web-devicons
                 (fn []
                   (icons.mock_nvim_web_devicons)
                   (package.loaded :nvim-web-devicons))))}

 ; Better vim.notify().
 {1 :rcarriga/nvim-notify
  :keys [{1 :<Leader>vl
          2 #((. (require :telescope) :extensions :notify :notify) {})
          :desc "View logs"}
         {1 :<Leader>un
          2 #((. (require :notify) :dismiss) {:silent true :pending true})
          :desc "Dismiss All Notifications"}]}

 {1 :stevearc/dressing.nvim
  :opts {}}

 {1 :folke/noice.nvim
  :event :VeryLazy
  :opts {}
  :config #(let [noice (require :noice)]
             (noice.setup
               {:cmdline {:format {:cmdline {:icon :>}
                                   :filter {:icon :$}
                                   :help {:icon :H}
                                   :search_down {:icon :/}
                                   :search_up {:icon :?}}}
                :lsp {:override {:cmp.entry.get_documentation true
                                 :vim.lsp.util.convert_input_to_markdown_lines true
                                 :vim.lsp.util.stylize_markdown true}}
                :presets {:bottom_search true
                          :command_palette true
                          :long_message_to_split true
                          :lsp_doc_border false}
                :routes [{:view :notify :filter {:event :msg_showmode
                                                 :any [{:find :recording}]}}]}))}

 {1 :nvim-lualine/lualine.nvim
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
                           :lualine_x [[lsp-connection]
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
