[{1 :nvim-orgmode/orgmode
  :event :VeryLazy
  :ft [:org]
  :config #(let [org (require :orgmode)]
             (org.setup {:org_agenda_files "~/org/**/*"
                         :org_default_notes_file "~/org/notes.org"}))}]
