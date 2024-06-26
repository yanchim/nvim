(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

; Nvim global options.
(let [options
      {; Expand tab to space.
       :expandtab true
       ; 2 spaces for tab.
       :tabstop 2
       :softtabstop 2
       ; 2 spaces for indent width.
       :shiftwidth 2
       ; Settings needed for compe autocompletion.
       :completeopt "menuone,noselect"
       ; Case insensitive search.
       :ignorecase true
       ; If mixed case included, assume want case-sensitive.
       :smartcase true
       ; Shared clipboard with linux.
       :clipboard "unnamedplus"
       ; Don't show line numbers.
       :number false
       ; Show line and column number.
       :ruler true
       ; Make signcolumn always one column with signs and linenumber.
       :signcolumn "number"}]
  (each [option value (pairs options)]
    (core.assoc vim.o option value)))

; Prevent commenting out next line after a comment line.
(vim.api.nvim_create_autocmd
  :FileType
  {:pattern :* :callback (fn [] (vim.opt_local.formatoptions:remove [:r :o]))})

; Tree style listing for netrw.
(vim.cmd "let g:netrw_liststyle = 3")

(require :core.keymaps)

(when (= (. (vim.uv.os_uname) :sysname) "Windows_NT")
  (set vim.o.shell :pwsh))

(when (vim.fn.has :gui_running)
  (require :core.gui))

{}
