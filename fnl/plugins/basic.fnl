[{1 :nvim-telescope/telescope.nvim
  :dependencies [:nvim-lua/plenary.nvim
                 :nvim-tree/nvim-web-devicons
                 :nvim-telescope/telescope-file-browser.nvim]
  :init (fn []
          (let [builtin (require :telescope.builtin)]
            ; Buffer.
            (vim.keymap.set :n :<leader>bb builtin.buffers {:noremap true :desc "Find buffer"})

            ; File.
            (vim.keymap.set :n :<leader>fc ":Telescope file_browser path=%:p:h select_buffer=true<CR>" {:noremap true :desc "Open file browser with current buffer"})
            (vim.keymap.set :n :<leader>ff ":Telescope file_browser<CR>" {:noremap true :desc "Open file browser"})

            ; Git.
            (vim.keymap.set :n :<leader>gt builtin.git_status {:noremap true :desc "Git status"})

            ; Search.
            (vim.keymap.set :n :<leader>sc builtin.grep_string {:noremap true :desc "Find string under cursor"})
            (vim.keymap.set :n :<leader>sf builtin.find_files {:noremap true :desc "Fd file"})
            (vim.keymap.set :n :<leader>sg builtin.live_grep {:noremap true :desc "Ripgrep"})
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
            (vim.keymap.set :n :<leader>vt :<cmd>TSContextToggle<CR> {:noremap true :desc "Treesitter context"}))

          (let [telescope (require :telescope)]
            (telescope.load_extension :file_browser)))
  :config (fn []
            (let [telescope (require :telescope)
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
                                          :colorscheme {:enable_preview true}}
                                :extensions {:file_browser {:collapse_dirs true
                                                            :mappings {:n {:g fb-actions.toggle_respect_gitignore}
                                                                       :i {:<C-g> fb-actions.toggle_respect_gitignore}}}}})))}

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

 {1 :folke/flash.nvim
  :event :VeryLazy
  :opts {}
  :keys [{1 :<localleader>aa :mode [:n :o :x] 2 (fn [] ((. (require :flash) :jump))) :desc :Flash}
         {1 :<localleader>al :mode [:n :o :x] 2 (fn [] ((. (require :flash) :jump) {:label {:after [0 0]} :pattern :^ :search {:max_length 0 :mode :search}})) :desc "Flash Line"}
         {1 :<localleader>at :mode [:n :o :x] 2 (fn [] ((. (require :flash) :treesitter))) :desc "Flash Treesitter"}
         {1 :<localleader>ar :mode :o 2 (fn [] ((. (require :flash) :remote))) :desc "Remote Flash"}
         {1 :<localleader>as :mode [:o :x] 2 (fn [] ((. (require :treesitter_search) :remote))) :desc "Treesitter Search"}
         {1 :<C-s> :mode :c 2 (fn [] ((. (require :flash) :toggle))) :desc "Toggle Flash Search"}]}

 {1 :folke/which-key.nvim
  :event :VeryLazy
  :init (fn []
          (set vim.o.timeout true)
          (set vim.o.timeoutlen 500))
  :opts {}
  :config #(let [wk (require :which-key)]
             (wk.register
               {:<leader>b {:name :Buffer}
                :<leader>c {:name :Code}
                :<leader>e {:name :Explore}
                :<leader>f {:name :File}
                :<leader>g {:name :Git
                            :b {:name :Buffer}
                            :h {:name :Hunk}
                            :l {:name :Line}}
                :<leader>l {:name :Lsp}
                :<leader>o {:name :Org}
                :<leader>s {:name :Search}
                :<leader>t {:name :Tab}
                :<leader>v {:name :View}}))}]
