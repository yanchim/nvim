(vim.keymap.set :n :<LocalLeader>cd "<Cmd>tcd %:h<CR>" {:desc "Change tab's cwd to current file"})
(vim.keymap.set :n :<LocalLeader>dd "<Cmd>verbose pwd<CR>" {:desc "pwd"})

(vim.keymap.set [:n :v] :<LocalLeader>w vim.cmd.write {:desc "Write current file"})
(vim.keymap.set [:n :v] :<LocalLeader>Q #(vim.cmd.quitall {:bang true}) {:desc "Quit"})

(fn readonly-toggle []
  "Toggle buffer readonly status."
  (let [buf (vim.api.nvim_get_current_buf)]
    (if (. vim.bo buf :readonly)
      (tset vim.bo buf :readonly false)
      (tset vim.bo buf :readonly true))))

(vim.keymap.set [:i :n :v] :<C-X><C-Q> vim.cmd.quitall {:desc "Quit"})
(vim.keymap.set [:i :n :v] :<C-X><C-R> readonly-toggle {:desc "Toggle readonly"})
(vim.keymap.set [:i :n :v] :<C-X><C-S> vim.cmd.update {:desc "Save buffer"})

(vim.keymap.set :t :jk :<C-\><C-N> {:desc "Exit terminal INSERT mode"})

(vim.keymap.set :n :<LocalLeader>xl vim.cmd.lopen {:desc "Location list"})
(vim.keymap.set :n :<LocalLeader>xL vim.cmd.lclose {:desc "Close location list"})
(vim.keymap.set :n :<LocalLeader>xq vim.cmd.copen {:desc "Quickfix list"})
(vim.keymap.set :n :<LocalLeader>xQ vim.cmd.cclose {:desc "Close quickfix list"})
(vim.keymap.set :n :<LocalLeader>xx vim.cmd.cc {:desc "Display error"})
(vim.keymap.set :n :<LocalLeader>xg vim.cmd.edit {:desc "Revert current buffer"})
(vim.keymap.set :n :<LocalLeader>xG vim.cmd.checktime {:desc "Revert all buffers"})

; Buffer.
(vim.keymap.set :n :<Leader>bd "<Cmd>bp<Bar>bd #<CR>" {:desc "Delete current buffer"})
(vim.keymap.set :n :<LocalLeader>bb "<Cmd>e #<CR>" {:desc "Switch to prev buffer"})

; Window.
(vim.keymap.set :n :<M-j> :<C-W>j {:desc "Move cursor to the downside window"})
(vim.keymap.set :n :<M-k> :<C-W>k {:desc "Move cursor to the upside window"})
(vim.keymap.set :n :<M-h> :<C-W>h {:desc "Move cursor to the leftside window"})
(vim.keymap.set :n :<M-l> :<C-W>l {:desc "Move cursor to the rightside window"})

(vim.keymap.set :n :<LocalLeader>sq :<C-W>q {:desc "Close current window"})
(vim.keymap.set :n :<LocalLeader>sa :<C-W>s {:desc "Split window horizontal"})
(vim.keymap.set :n :<LocalLeader>sd :<C-W>v {:desc "Split window vertically"})
(vim.keymap.set :n :<LocalLeader>oo :<C-W>o {:desc "Keep current window only"})
(vim.keymap.set :n :<C-x>0 :<C-W>q {:desc "Delete window"})
(vim.keymap.set :n :<C-x>1 :<C-W>o {:desc "Delete other windows"})
(vim.keymap.set :n :<C-x>2 :<C-W>s {:desc "Split window below"})
(vim.keymap.set :n :<C-x>3 :<C-W>v {:desc "Split window right"})
(vim.keymap.set :n :<C-x>o :<C-W><C-W> {:desc "Other window"})

; Tab.
(vim.keymap.set :n :<Leader>to vim.cmd.tabnew {:desc "Open new tab"})
(vim.keymap.set :n :<Leader>tx vim.cmd.tabclose {:desc "Close current tab"})
(vim.keymap.set :n :<Leader>tn vim.cmd.tabn {:desc "Go to next tab"})
(vim.keymap.set :n :<Leader>tp vim.cmd.tabp {:desc "Go to previous tab"})
(vim.keymap.set :n :<Leader>tf "<Cmd>tabnew %<CR>" {:desc "Open current buffer in new tab"})
(vim.keymap.set :n :<Leader>tt "<Cmd>tab terminal<CR>" {:desc "Toggle terminal in tab"})

(vim.keymap.set :n :<Leader>th #(vim.cmd.tabmove :-) {:desc "move tab left"})
(vim.keymap.set :n :<Leader>tl #(vim.cmd.tabmove :+) {:desc "move tab right"})
(vim.keymap.set :n :<Leader>ta #(vim.cmd.tabmove :0) {:desc "move tab first"})
(vim.keymap.set :n :<Leader>te #(vim.cmd.tabmove :$) {:desc "move tab last"})

; Readline like behavior.
(vim.keymap.set [:c :i] :<C-A> :<Home> {:desc "Bol"})
(vim.keymap.set [:c :i] :<C-E> :<End> {:desc "Eol"})
(vim.keymap.set [:c :i] :<C-D> :<Delete> {:desc "Delete char"})
(vim.keymap.set [:c :i] :<C-F> :<Right> {:desc "Forward char"})
(vim.keymap.set [:c :i] :<C-B> :<Left> {:desc "Backward char"})
(vim.keymap.set :i :<C-N> :<Down> {:desc "Next line"})
(vim.keymap.set :i :<C-P> :<Up> {:desc "Prev line"})

; Command.
(vim.keymap.set :c :<C-O> :<C-F> {:desc "Command"})

; Brackets.
(vim.keymap.set :n "[b" vim.cmd.bprevious {:desc "Prev buffer"})
(vim.keymap.set :n "]b" vim.cmd.bnext {:desc "Next buffer"})
(vim.keymap.set :n "[B" vim.cmd.bfirst {:desc "First buffer"})
(vim.keymap.set :n "]B" vim.cmd.blast {:desc "Last buffer"})
(vim.keymap.set :n "[q" vim.cmd.cprev {:desc "Prev quickfix"})
(vim.keymap.set :n "]q" vim.cmd.cnext {:desc "Next quickfix"})
(vim.keymap.set :n "[Q" vim.cmd.cfirst {:desc "First quickfix"})
(vim.keymap.set :n "]Q" vim.cmd.clast {:desc "Last quickfix"})
(vim.keymap.set :n "[l" vim.cmd.lprev {:desc "Prev location"})
(vim.keymap.set :n "]l" vim.cmd.lnext {:desc "Next location"})
(vim.keymap.set :n "[L" vim.cmd.lfirst {:desc "First location"})
(vim.keymap.set :n "]L" vim.cmd.llast {:desc "Last location"})
(vim.keymap.set :n "[t" vim.cmd.tabprevious {:desc "Prev tab"})
(vim.keymap.set :n "]t" vim.cmd.tabnext {:desc "Next tab"})
(vim.keymap.set :n "[T" vim.cmd.tabfirst {:desc "First tab"})
(vim.keymap.set :n "]T" vim.cmd.tablast {:desc "Last tab"})

(vim.keymap.set :n "[<Space>" "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>" {:desc "Blank above"})
(vim.keymap.set :n "]<Space>" "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>" {:desc "Blank below"})

(fn diagnostic-goto [next severity]
  "Go to diagnostic."
  (vim.diagnostic.jump {:count (if next 1 -1) :float true :severity severity}))

(fn diagnostic-toggle []
  "Toggle diagnostic show."
  (vim.diagnostic.enable (not (vim.diagnostic.is_enabled))))

(vim.keymap.set :n :<LocalLeader>xD diagnostic-toggle {:desc "Toggle Diagnostics"})
(vim.keymap.set :n :<LocalLeader>xd vim.diagnostic.open_float {:desc "Display Diagnostics"})
(vim.keymap.set :n "]d" #(diagnostic-goto true)  {:desc "Next Diagnostic"})
(vim.keymap.set :n "[d" #(diagnostic-goto false) {:desc "Prev Diagnostic"})
(vim.keymap.set :n "]e" #(diagnostic-goto true  :ERROR) {:desc "Next Error"})
(vim.keymap.set :n "[e" #(diagnostic-goto false :ERROR) {:desc "Prev Error"})
(vim.keymap.set :n "]w" #(diagnostic-goto true  :WARN) {:desc "Next Warning"})
(vim.keymap.set :n "[w" #(diagnostic-goto false :WARN) {:desc "Prev Warning"})

{}
