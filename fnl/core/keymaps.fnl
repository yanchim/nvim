; Space is reserved to be leader key.
(vim.keymap.set :n :<space> :<nop> {:noremap true})

(vim.keymap.set :n :<localleader>dd "<cmd>cd %:h<CR>" {:desc "Change cwd to current file"})
(vim.keymap.set :n :<localleader>w :<cmd>write<CR> {:desc "Write current file"})
(vim.keymap.set :n :<localleader>Q :<cmd>qa!<CR> {:desc "Quit"})

(vim.keymap.set :t :jk :<C-\><C-N> {:desc "Exit terminal-insert mode with jk"})

; Buffer.
(vim.keymap.set :n :<leader>bd "<cmd>bp<bar>bd #<CR>" {:desc "Delete current buffer"})
(vim.keymap.set :n :<localleader>xx "<cmd>bp<bar>bd #<CR>" {:desc "Delete current buffer"})
(vim.keymap.set [:i :n] :<C-x><C-s> :<cmd>update<CR> {:desc "Emacs style save"})

; Window.
(vim.keymap.set :n :<M-j> :<C-w>j {:desc "Move cursor to the downside window"})
(vim.keymap.set :n :<M-k> :<C-w>k {:desc "Move cursor to the upside window"})
(vim.keymap.set :n :<M-h> :<C-w>h {:desc "Move cursor to the leftside window"})
(vim.keymap.set :n :<M-l> :<C-w>l {:desc "Move cursor to the rightside window"})

(vim.keymap.set :n :<localleader>sq :<C-w>q {:desc "Close current window"})
(vim.keymap.set :n :<localleader>sa :<C-w>s {:desc "Split window horizontal"})
(vim.keymap.set :n :<localleader>sd :<C-w>v {:desc "Split window vertically"})
(vim.keymap.set :n :<localleader>oo :<C-w>o {:desc "Keep current window only"})

; Tab.
(vim.keymap.set :n :<leader>to :<cmd>tabnew<CR> {:desc "Open new tab"})
(vim.keymap.set :n :<leader>tx :<cmd>tabclose<CR> {:desc "Close current tab"})
(vim.keymap.set :n :<leader>tn :<cmd>tabn<CR> {:desc "Go to next tab"})
(vim.keymap.set :n :<leader>tp :<cmd>tabp<CR> {:desc "Go to previous tab"})
(vim.keymap.set :n :<leader>tf "<cmd>tabnew %<CR>" {:desc "Open current buffer in new tab"})
(vim.keymap.set :n :<leader>tt "<cmd>tab terminal<CR>" {:desc "Toggle terminal in tab"})

; Readline like behavior.
(vim.keymap.set [:c :i] :<C-a> :<Home> {:desc "Bol"})
(vim.keymap.set [:c :i] :<C-e> :<End> {:desc "Eol"})
(vim.keymap.set [:c :i] :<C-d> :<Delete> {:desc "Delete char"})
(vim.keymap.set [:c :i] :<C-f> :<Right> {:desc "Forward char"})
(vim.keymap.set [:c :i] :<C-b> :<Left> {:desc "Backward char"})
(vim.keymap.set :i :<C-n> :<Down> {:desc "Next line"})
(vim.keymap.set :i :<C-p> :<Up> {:desc "Prev line"})

; Command.
(vim.keymap.set :c :<C-o> :<C-f> {:desc "Command"})

{}
