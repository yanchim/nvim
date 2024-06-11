[{1 :nvim-telescope/telescope.nvim
  :dependencies [:nvim-telescope/telescope-ui-select.nvim
                 :nvim-lua/popup.nvim
                 :nvim-lua/plenary.nvim]
  :init (fn []
          (let [builtin (require :telescope.builtin)]
            (vim.keymap.set :n :<leader>ff builtin.find_files {:noremap true :desc "Find file"})
            (vim.keymap.set :n :<leader>fg builtin.live_grep {:noremap true :desc "Find grep"})
            (vim.keymap.set :n :<leader>fc builtin.grep_string {:noremap true :desc "Find string under cursor"})
            (vim.keymap.set :n :<leader>fb builtin.buffers {:noremap true :desc "Find buffer"})
            (vim.keymap.set :n :<leader>fr builtin.oldfiles {:noremap true :desc "Find recent buffer"})
            (vim.keymap.set :n :<leader>fh builtin.help_tags {:noremap true :desc "Find help"})))
  :config (fn []
            (let [telescope (require :telescope)
                  themes (require :telescope.themes)]
              (telescope.setup {:defaults {:file_ignore_patterns ["node_modules"]
                                           :vimgrep_arguments ["rg"
                                                               "--color=never"
                                                               "--no-heading"
                                                               "--with-filename"
                                                               "--line-number"
                                                               "--column"
                                                               "--smart-case"
                                                               "--iglob"
                                                               "!.git"
                                                               "--hidden"]}
                                :extensions {:ui-select {1 (themes.get_dropdown {})}}
                                :pickers {:find_files {:find_command ["fd"
                                                                      "--full-path"
                                                                      "--color=never"]}}})
              (telescope.load_extension "ui-select")))}]
