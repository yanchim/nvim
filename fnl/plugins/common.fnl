[{1 :nvim-telescope/telescope.nvim
  :dependencies [:nvim-lua/plenary.nvim
                 :nvim-tree/nvim-web-devicons
                 :nvim-telescope/telescope-file-browser.nvim]
  :init (fn []
          (let [builtin (require :telescope.builtin)]
            (vim.keymap.set :n :<localleader><localleader> builtin.commands {:noremap true :desc "Commands"})
            (vim.keymap.set :n :<leader>bb builtin.buffers {:noremap true :desc "Find buffer"})
            (vim.keymap.set :n :<leader>sc builtin.grep_string {:noremap true :desc "Find string under cursor"})
            (vim.keymap.set :n :<leader>sf builtin.find_files {:noremap true :desc "Fd file"})
            (vim.keymap.set :n :<leader>sg builtin.live_grep {:noremap true :desc "Ripgrep"})
            (vim.keymap.set :n :<leader>sr builtin.oldfiles {:noremap true :desc "Find recent buffer"})

            (vim.keymap.set :n :<leader>tc builtin.colorscheme {:noremap true :desc "Colorscheme"})
            (vim.keymap.set :n :<leader>tq builtin.quickfix {:noremap true :desc "Quickfix"})
            (vim.keymap.set :n :<leader>tl builtin.quickfix {:noremap true :desc "Loclist"})
            (vim.keymap.set :n :<leader>tj builtin.quickfix {:noremap true :desc "Jumplist"})

            (vim.keymap.set :n :<leader>gt builtin.git_status {:noremap true :desc "Git status"})

            (vim.keymap.set :n :<leader>fb builtin.buffers {:noremap true :desc "Find buffer"})
            (vim.keymap.set :n :<leader>ff builtin.find_files {:noremap true :desc "Find file"})
            (vim.keymap.set :n :<leader>fg builtin.live_grep {:noremap true :desc "Find grep"})
            (vim.keymap.set :n :<leader>fc builtin.grep_string {:noremap true :desc "Find string under cursor"})
            (vim.keymap.set :n :<leader>fb builtin.buffers {:noremap true :desc "Find buffer"})
            (vim.keymap.set :n :<leader>fr builtin.oldfiles {:noremap true :desc "Find recent buffer"})
            (vim.keymap.set :n :<leader>fh builtin.help_tags {:noremap true :desc "Find help"})
            (vim.keymap.set :n :<leader>ee ":Telescope file_browser<CR>" {:noremap true :desc "Open file browser"})
            (vim.keymap.set :n :<leader>ef ":Telescope file_browser path=%:p:h select_buffer=true<CR>" {:noremap true :desc "Open file browser with current buffer"})))
  :config (fn []
            (let [telescope (require :telescope)]
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
                                                                      "--color=never"]}}
                                :extensions {:file_browser {:collapse_dirs true}}})
              (telescope.load_extension :file_browser)))}

 {1 :stevearc/dressing.nvim
  :opts {}}

 {1 :tummetott/unimpaired.nvim
  :event :VeryLazy
  :opts {}}

 {1 :kylechui/nvim-surround
  :event :VeryLazy
  :config (fn []
            (let [surround (require :nvim-surround)]
              (surround.setup)))}

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
  :config (fn []
            (let [wk (require :which-key)]
              (wk.register
                {:<leader>b {:name :Buffer}
                 :<leader>c {:name :Code}
                 :<leader>e {:name :Explore}
                 :<leader>f {:name :Find}
                 :<leader>g {:name :Git
                             :b {:name :Buffer}
                             :h {:name :Hunk}
                             :l {:name :Line}}
                 :<leader>l {:name :Lsp}
                 :<leader>s {:name :Search}
                 :<leader>t {:name :Toggle/Tab}})))}]
