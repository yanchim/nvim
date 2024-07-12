[{1 :nvim-telescope/telescope.nvim
  :dependencies [:nvim-lua/plenary.nvim
                 :nvim-tree/nvim-web-devicons
                 :nvim-telescope/telescope-file-browser.nvim]
  :init (fn []
          (let [builtin (require :telescope.builtin)]
            ; Buffer.
            (vim.keymap.set :n :<leader>bb builtin.buffers {:noremap true :desc "Switch buffer"})
            (vim.keymap.set :n :<C-x>b builtin.buffers {:noremap true :desc "Switch buffer"})

            ; File.
            (vim.keymap.set :n :<leader>fc "<Cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>" {:noremap true :desc "Open file browser with current buffer"})
            (vim.keymap.set :n :<leader>ff "<Cmd>Telescope file_browser<CR>" {:noremap true :desc "Open file browser"})
            ;; Emacs style.
            (vim.keymap.set :n :<C-x><C-f> "<Cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>" {:noremap true :desc "Find file"})

            ; Git.
            (vim.keymap.set :n :<leader>gt builtin.git_status {:noremap true :desc "Git status"})

            ; Search.
            (vim.keymap.set :n :<leader>sc builtin.grep_string {:noremap true :desc "Find string under cursor"})
            (vim.keymap.set :n :<leader>sf builtin.find_files {:noremap true :desc "Find file"})
            (vim.keymap.set :n :<leader>sg builtin.live_grep {:noremap true :desc "Grep"})
            (vim.keymap.set :n :<leader>sr builtin.oldfiles {:noremap true :desc "Find recent buffer"})
            (vim.keymap.set :n :<leader>ss builtin.current_buffer_fuzzy_find {:noremap true :desc "Search buffer"})

            ; View.
            (vim.keymap.set :n :<leader>v: builtin.commands {:noremap true :desc "Commands"})
            (vim.keymap.set :n :<leader>vc builtin.colorscheme {:noremap true :desc "Colorscheme"})
            (vim.keymap.set :n :<leader>vh builtin.help_tags {:noremap true :desc "Help tags"})
            (vim.keymap.set :n :<leader>vk builtin.keymaps {:noremap true :desc "Keymaps"})
            (vim.keymap.set :n :<leader>vm builtin.marks {:noremap true :desc "Marks"})
            (vim.keymap.set :n :<leader>vo builtin.vim_options {:noremap true :desc "Options"})
            (vim.keymap.set :n :<leader>vr builtin.registers {:noremap true :desc "Registers"})
            (vim.keymap.set :n :<leader>vt vim.cmd.TSContextToggle {:noremap true :desc "Treesitter context"}))

          (let [telescope (require :telescope)]
            (telescope.load_extension :file_browser)))
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
                                         :live_grep {:mappings {:i {:<C-f> actions.to_fuzzy_refine}}}
                                         :colorscheme {:enable_preview true}}
                               :extensions {:file_browser {:collapse_dirs true
                                                           :mappings {:n {:g fb-actions.toggle_respect_gitignore}
                                                                      :i {:<C-g> fb-actions.toggle_respect_gitignore}}}}}))}

 {1 :stevearc/dressing.nvim
  :opts {}}

 {1 :kylechui/nvim-surround
  :event :VeryLazy
  :config #(let [surround (require :nvim-surround)]
             (surround.setup))}

 {1 :echasnovski/mini.pairs
  :version false
  :event :VeryLazy
  :opts {:modes {:insert true :command true :terminal false}
         ; Skip autopair when the cursor is inside these treesitter nodes.
         :skip_ts [:string]
         ; Skip autopair when next character is closing pair and there are more
         ; closing pairs than opening pairs.
         :skip_unbalanced true
         ; Better deal with markdown code blocks.
         :markdown true}
  :config #(let [mp (require :mini.pairs)]
             (mp.setup))}

 {1 :folke/todo-comments.nvim
  :dependencies [:nvim-lua/plenary.nvim]
  :opts {:signs false}
  :keys [{1 "[c" :mode :n 2 #((. (require :todo-comments) :jump_prev)) :desc "Prev todo comment"}
         {1 "]c" :mode :n 2 #((. (require :todo-comments) :jump_next)) :desc "Next todo comment"}
         {1 "<leader>st" :mode :n 2 :<Cmd>TodoTelescope<CR> :desc "Search todo comment"}]}

 {1 :folke/flash.nvim
  :event :VeryLazy
  :opts {}
  :keys [{1 :<localleader>aa :mode [:n :o :x] 2 #((. (require :flash) :jump)) :desc :Flash}
         {1 :<localleader>al :mode [:n :o :x] 2 #((. (require :flash) :jump) {:label {:after [0 0]} :pattern :^ :search {:max_length 0 :mode :search}}) :desc "Flash Line"}
         {1 :<localleader>at :mode [:n :o :x] 2 #((. (require :flash) :treesitter)) :desc "Flash Treesitter"}
         {1 :<localleader>ar :mode :o 2 #((. (require :flash) :remote)) :desc "Remote Flash"}
         {1 :<localleader>as :mode [:o :x] 2 #((. (require :treesitter_search) :remote)) :desc "Treesitter Search"}
         {1 :<C-s> :mode :c 2 #((. (require :flash) :toggle)) :desc "Toggle Flash Search"}]}

 {1 :folke/which-key.nvim
  :event :VeryLazy
  :init (fn []
          (set vim.o.timeout true)
          (set vim.o.timeoutlen 500))
  :opts {}
  :config #(let [wk (require :which-key)]
             (wk.add
               [{1 :<leader>? 2 #((. (require :which-key) :show) {:global false}) :desc "Buffer local keymaps"}
                {1 :<leader>b :group :Buffer}
                {1 :<leader>c :group :Code}
                {1 :<leader>e :group :Explore}
                {1 :<leader>f :group :File}
                {1 :<leader>g :group :Git}
                {1 :<leader>gb :group :Buffer}
                {1 :<leader>gh :group :Hunk}
                {1 :<leader>gl :group :Line}
                {1 :<leader>l :group :Lsp}
                {1 :<leader>o :group :Org}
                {1 :<leader>s :group :Search}
                {1 :<leader>t :group :Tab}
                {1 :<leader>v :group :View}]))}]
