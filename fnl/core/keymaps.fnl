; Space is reserved to be leader key.
(vim.keymap.set :n :<space> :<nop> {:noremap true})

(vim.keymap.set :n :<localleader>cd "<Cmd>tcd %:h<CR>" {:desc "Change cwd to current file"})
(vim.keymap.set :n :<localleader>dd "<Cmd>verbose pwd<CR>" {:desc "pwd"})

(vim.keymap.set [:n :v] :<localleader>w vim.cmd.write {:desc "Write current file"})
(vim.keymap.set [:n :v] :<localleader>Q vim.cmd.quitall {:desc "Quit"})

(vim.keymap.set :t :jk :<C-\><C-N> {:desc "Exit terminal INSERT mode"})

(vim.keymap.set :n :<localleader>xl vim.cmd.lopen {:desc "Location list"})
(vim.keymap.set :n :<localleader>xq vim.cmd.copen {:desc "Quickfix list"})

; Buffer.
(vim.keymap.set :n :<leader>bd "<Cmd>bp<bar>bd #<CR>" {:desc "Delete current buffer"})
(vim.keymap.set :n :<localleader>xx "<Cmd>bp<bar>bd #<CR>" {:desc "Delete current buffer"})
(vim.keymap.set :n :<localleader>bb "<Cmd>e #<CR>" {:desc "Switch to prev buffer"})
(vim.keymap.set [:i :n :v] :<C-x><C-s> vim.cmd.update {:desc "Save buffer"})

; Window.
(vim.keymap.set :n :<M-j> :<C-w>j {:desc "Move cursor to the downside window"})
(vim.keymap.set :n :<M-k> :<C-w>k {:desc "Move cursor to the upside window"})
(vim.keymap.set :n :<M-h> :<C-w>h {:desc "Move cursor to the leftside window"})
(vim.keymap.set :n :<M-l> :<C-w>l {:desc "Move cursor to the rightside window"})

(vim.keymap.set :n :<localleader>sq :<C-w>q {:desc "Close current window"})
(vim.keymap.set :n :<localleader>sa :<C-w>s {:desc "Split window horizontal"})
(vim.keymap.set :n :<localleader>sd :<C-w>v {:desc "Split window vertically"})
(vim.keymap.set :n :<localleader>oo :<C-w>o {:desc "Keep current window only"})
(vim.keymap.set :n :<C-x>0 :<C-w>q {:desc "Delete window"})
(vim.keymap.set :n :<C-x>1 :<C-w>o {:desc "Delete other windows"})
(vim.keymap.set :n :<C-x>2 :<C-w>s {:desc "Split window below"})
(vim.keymap.set :n :<C-x>3 :<C-w>v {:desc "Split window right"})
(vim.keymap.set :n :<C-x>o :<C-w><C-w> {:desc "Other window"})

; Tab.
(vim.keymap.set :n :<leader>to vim.cmd.tabnew {:desc "Open new tab"})
(vim.keymap.set :n :<leader>tx vim.cmd.tabclose {:desc "Close current tab"})
(vim.keymap.set :n :<leader>tn vim.cmd.tabn {:desc "Go to next tab"})
(vim.keymap.set :n :<leader>tp vim.cmd.tabp {:desc "Go to previous tab"})
(vim.keymap.set :n :<leader>tf "<Cmd>tabnew %<CR>" {:desc "Open current buffer in new tab"})
(vim.keymap.set :n :<leader>tt "<Cmd>tab terminal<CR>" {:desc "Toggle terminal in tab"})

(vim.keymap.set :n :<leader>th #(vim.cmd.tabmove :-) {:desc "move tab left"})
(vim.keymap.set :n :<leader>tl #(vim.cmd.tabmove :+) {:desc "move tab right"})
(vim.keymap.set :n :<leader>ta #(vim.cmd.tabmove :0) {:desc "move tab first"})
(vim.keymap.set :n :<leader>te #(vim.cmd.tabmove :$) {:desc "move tab last"})

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

; Brackets.
(vim.keymap.set :n "[b" vim.cmd.bprevious {:desc "Prev buffer"})
(vim.keymap.set :n "]b" vim.cmd.bnext {:desc "Next buffer"})
(vim.keymap.set :n "[B" vim.cmd.bfirst {:desc "First buffer"})
(vim.keymap.set :n "]B" vim.cmd.blast {:desc "Last buffer"})
(vim.keymap.set :n "[q" vim.cmd.cprev {:desc "Prev quickfix"})
(vim.keymap.set :n "]q" vim.cmd.cnext {:desc "Next quickfix"})
(vim.keymap.set :n "[Q" vim.cmd.cfirst {:desc "First quickfix"})
(vim.keymap.set :n "]Q" vim.cmd.clast {:desc "Last quickfix"})
(vim.keymap.set :n "[t" vim.cmd.tabprevious {:desc "Prev tab"})
(vim.keymap.set :n "]t" vim.cmd.tabnext {:desc "Next tab"})
(vim.keymap.set :n "[T" vim.cmd.tabfirst {:desc "First tab"})
(vim.keymap.set :n "]T" vim.cmd.tablast {:desc "Last tab"})

(vim.keymap.set :n "[<space>" "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>" {:desc "Blank above"})
(vim.keymap.set :n "]<space>" "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>" {:desc "Blank below"})

;; Diagnostic.
(fn diagnostic-goto [next severity]
  (let [go (or (and next vim.diagnostic.goto_next) vim.diagnostic.goto_prev)]
    (set-forcibly! severity (or (and severity
                                     (. vim.diagnostic.severity severity))
                                nil))
    (fn [] (go {: severity}))))

(fn diagnostic-toggle []
  "Toggle diagnostic show."
  (if (vim.diagnostic.is_enabled)
    (vim.diagnostic.disable)
    (vim.diagnostic.enable)))

(vim.keymap.set :n :<localleader>xD diagnostic-toggle {:desc "Toggle Diagnostics"})
(vim.keymap.set :n :<localleader>xd vim.diagnostic.open_float {:desc "Display Diagnostics"})
(vim.keymap.set :n "]d" (diagnostic_goto true)  {:desc "Next Diagnostic"})
(vim.keymap.set :n "[d" (diagnostic_goto false) {:desc "Prev Diagnostic"})
(vim.keymap.set :n "]e" (diagnostic_goto true  :ERROR) {:desc "Next Error"})
(vim.keymap.set :n "[e" (diagnostic_goto false :ERROR) {:desc "Prev Error"})
(vim.keymap.set :n "]w" (diagnostic_goto true  :WARN) {:desc "Next Warning"})
(vim.keymap.set :n "[w" (diagnostic_goto false :WARN) {:desc "Prev Warning"})

{}
