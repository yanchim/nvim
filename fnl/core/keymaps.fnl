; Space is reserved to be leader key.
(vim.keymap.set :n :<space> :<nop> {:noremap true})

(vim.keymap.set :i :jk :<ESC> {:desc "Exit insert mode with jk"})

(vim.keymap.set :n :<localleader>w :<cmd>write<CR> {:desc "Write current file"})
(vim.keymap.set :n :<localleader>Q :<cmd>qa!<CR> {:desc "Quit"})

; Window.
(vim.keymap.set :n :<M-j> :<C-w>j {:desc "Move cursor to the downside window"})
(vim.keymap.set :n :<M-k> :<C-w>k {:desc "Move cursor to the upside window"})
(vim.keymap.set :n :<M-h> :<C-w>h {:desc "Move cursor to the leftside window"})
(vim.keymap.set :n :<M-l> :<C-w>l {:desc "Move cursor to the rightside window"})

(vim.keymap.set :n :<localleader>sq :<C-w>q {:desc "Close current window"})
(vim.keymap.set :n :<localleader>sa :<C-w>s {:desc "Split window horizontal"})
(vim.keymap.set :n :<localleader>sd :<C-w>v {:desc "Split window vertically"})
(vim.keymap.set :n :<localleader>oo :<C-w>o {:desc "Keep current window only"})

{}
