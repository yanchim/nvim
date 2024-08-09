[{1 :nvim-telescope/telescope.nvim
  :dependencies [:nvim-lua/plenary.nvim
                 :nvim-telescope/telescope-file-browser.nvim]
  :init #(let [telescope (require :telescope)
               builtin (require :telescope.builtin)]
           ; Buffer.
           (vim.keymap.set :n :<Leader>bb builtin.buffers {:noremap true :desc "Switch buffer"})
           (vim.keymap.set :n :<C-X>b builtin.buffers {:noremap true :desc "Switch buffer"})

           ; File.
           (vim.keymap.set :n :<LocalLeader>ff #(telescope.extensions.file_browser.file_browser {:path "%:p:h" :select_buffer true}) {:noremap true :desc "Open file browser with current buffer"})
           (vim.keymap.set :n :<Leader>fc #(telescope.extensions.file_browser.file_browser {:path "%:p:h" :select_buffer true}) {:noremap true :desc "Open file browser with current buffer"})
           (vim.keymap.set :n :<Leader>ff telescope.extensions.file_browser.file_browser {:noremap true :desc "Open file browser"})
           (vim.keymap.set :n :<Leader>fr builtin.oldfiles {:noremap true :desc "Recent files"})
           ;; Emacs style.
           (vim.keymap.set :n :<C-X><C-F> #(telescope.extensions.file_browser.file_browser {:path "%:p:h" :select_buffer true}) {:noremap true :desc "Find file"})

           ; Git.
           (vim.keymap.set :n :<Leader>gt builtin.git_status {:noremap true :desc "Git status"})

           ; Search.
           (vim.keymap.set :n :<Leader>sc builtin.grep_string {:noremap true :desc "Find string under cursor"})
           (vim.keymap.set :n :<Leader>sf builtin.find_files {:noremap true :desc "Find file"})
           (vim.keymap.set :n :<Leader>sg builtin.live_grep {:noremap true :desc "Grep"})
           (vim.keymap.set :n :<Leader>ss builtin.current_buffer_fuzzy_find {:noremap true :desc "Search buffer"})

           (vim.keymap.set :n :<LocalLeader>ss builtin.current_buffer_fuzzy_find {:noremap true :desc "Search buffer"})
           (vim.keymap.set :n :<LocalLeader>gg builtin.live_grep {:noremap true :desc "Grep"})

           ; View.
           (vim.keymap.set :n :<Leader>v: builtin.commands {:noremap true :desc "Commands"})
           (vim.keymap.set :n :<Leader>vc builtin.colorscheme {:noremap true :desc "Colorscheme"})
           (vim.keymap.set :n :<Leader>vh builtin.help_tags {:noremap true :desc "Help tags"})
           (vim.keymap.set :n :<Leader>vk builtin.keymaps {:noremap true :desc "Keymaps"})
           (vim.keymap.set :n :<Leader>vm builtin.marks {:noremap true :desc "Marks"})
           (vim.keymap.set :n :<Leader>vo builtin.vim_options {:noremap true :desc "Options"})
           (vim.keymap.set :n :<Leader>vr builtin.registers {:noremap true :desc "Registers"})
           (vim.keymap.set :n :<Leader>vt vim.cmd.TSContextToggle {:noremap true :desc "Treesitter context"}))
  :config #(let [telescope (require :telescope)
                 actions (require :telescope.actions)
                 fb-actions (require :telescope._extensions.file_browser.actions)]
             (telescope.setup {:defaults {:file_ignore_patterns [:node_modules]
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
                               :pickers {:find_files {:find_command ["fd"
                                                                     "--full-path"
                                                                     "--color=never"]}
                                         :live_grep {:mappings {:i {:<C-F> actions.to_fuzzy_refine}}}
                                         :colorscheme {:enable_preview true}}
                               :extensions {:file_browser {:collapse_dirs true
                                                           :mappings {:n {:g fb-actions.toggle_respect_gitignore}
                                                                      :i {:<C-G> fb-actions.toggle_respect_gitignore}}}}})
           ; Load extensions after setup function to make extensions work.
           (telescope.load_extension :file_browser))}

 {1 :natecraddock/workspaces.nvim
  :dependencies [:nvim-telescope/telescope.nvim]
  :config #(let [ws (require :workspaces)
                 ts (require :telescope)]

             (ts.load_extension :workspaces)
             (vim.keymap.set :n :<Leader>pp ts.extensions.workspaces.workspaces {:noremap true :desc "Open workspace"})

             (vim.keymap.set :n :<Leader>pa ws.add {:noremap true :desc "Add workspace"})
             (vim.keymap.set :n :<Leader>pr ws.remove {:noremap true :desc "Remove workspace"})
             (vim.keymap.set :n :<Leader>pl ws.list_dirs {:noremap true :desc "List dirs which contain workspaces"})
             (vim.keymap.set :n :<Leader>ps ws.sync_dirs {:noremap true :desc "Sync workspaces in dir"})

             (ws.setup
               {:cd_type :tab
                :hooks {:open ["Telescope find_files"]}}))}

 {1 :MagicDuck/grug-far.nvim
  :opts {}
  :keys [{1 :<Leader>sr :mode [:n :v]
          2 #(let [grug (require :grug-far)
                   ext (and (= vim.bo.buftype "") (vim.fn.expand "%:e"))]
               (grug.grug_far {:prefills {:filesFilter (or (and (and ext (not= ext ""))
                                                                (.. "*." ext))
                                                           nil)}
                               :transient true}))
          :desc "Search and Replace"}]}

 {1 :kylechui/nvim-surround
  :event :VeryLazy
  :opts {}}

 {1 :echasnovski/mini.pairs
  :event :VeryLazy
  :opts {:modes {:insert true :command true :terminal false}
         ; Skip autopair when the cursor is inside these treesitter nodes.
         :skip_ts [:string]
         ; Skip autopair when next character is closing pair and there are more
         ; closing pairs than opening pairs.
         :skip_unbalanced true
         ; Better deal with markdown code blocks.
         :markdown true}}

 {1 :folke/todo-comments.nvim
  :lazy false
  :dependencies [:nvim-lua/plenary.nvim]
  :opts {:signs false}
  :keys [{1 "[c" :mode :n 2 #((. (require :todo-comments) :jump_prev)) :desc "Prev todo comment"}
         {1 "]c" :mode :n 2 #((. (require :todo-comments) :jump_next)) :desc "Next todo comment"}
         {1 "<Leader>st" :mode :n 2 :<Cmd>TodoTelescope<CR> :desc "Search todo comment"}]}

 {1 :folke/flash.nvim
  :event :VeryLazy
  :opts {}
  :keys [{1 :<LocalLeader>aa :mode [:n :o :x] 2 #((. (require :flash) :jump)) :desc :Flash}
         {1 :<LocalLeader>al :mode [:n :o :x] 2 #((. (require :flash) :jump) {:label {:after [0 0]} :pattern :^ :search {:max_length 0 :mode :search}}) :desc "Flash Line"}
         {1 :<LocalLeader>at :mode [:n :o :x] 2 #((. (require :flash) :treesitter)) :desc "Flash Treesitter"}
         {1 :<LocalLeader>ar :mode :o 2 #((. (require :flash) :remote)) :desc "Remote Flash"}
         {1 :<LocalLeader>as :mode [:o :x] 2 #((. (require :treesitter_search) :remote)) :desc "Treesitter Search"}
         {1 :<C-S> :mode :c 2 #((. (require :flash) :toggle)) :desc "Toggle Flash Search"}]}

 {1 :folke/which-key.nvim
  :event :VeryLazy
  :opts {}
  :config #(let [wk (require :which-key)]
             (wk.add
               [{1 :<Leader>? 2 #((. (require :which-key) :show) {:global false}) :desc "Buffer local keymaps"}
                {1 :<Leader>b :group :Buffer}
                {1 :<Leader>c :group :Code}
                {1 :<Leader>e :group :Explore}
                {1 :<Leader>f :group :File}
                {1 :<Leader>g :group :Git}
                {1 :<Leader>gb :group :Buffer}
                {1 :<Leader>gh :group :Hunk}
                {1 :<Leader>gl :group :Line}
                {1 :<Leader>l :group :Lsp}
                {1 :<Leader>o :group :Org}
                {1 :<Leader>p :group :Project}
                {1 :<Leader>s :group :Search}
                {1 :<Leader>t :group :Tab}
                {1 :<Leader>u :group :Undo}
                {1 :<Leader>v :group :View}]))}]
