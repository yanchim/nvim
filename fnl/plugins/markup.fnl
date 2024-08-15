[{1 :chomosuke/typst-preview.nvim
  :build ::TypstPreviewUpdate
  :ft [:typst]
  :opts {:dependencies_bin
         {:typst-preview :tinymist
          :websocat :websocat}}}

 {1 :nvim-orgmode/orgmode
  :event :VeryLazy
  :ft [:org]
  :opts {:org_agenda_files "~/org/**/*"
         :org_default_notes_file "~/org/notes.org"}}]
