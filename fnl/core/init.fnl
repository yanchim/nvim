(local {: autoload} (require :nfnl.module))
(local core (autoload :nfnl.core))

; Nvim global options.
(let [options
      {; Expand tab to space.
       :expandtab true
       :tabstop 8
       ; 2 spaces for tab.
       :softtabstop 2
       ; 2 spaces for indent width.
       :shiftwidth 2
       ; tcqj
       :formatoptions :jcroqlnt
       ; Settings needed for compe autocompletion.
       :completeopt "menuone,noselect"
       ; Case insensitive search.
       :ignorecase true
       ; If mixed case included, assume want case-sensitive.
       :smartcase true
       ; Shared clipboard with linux.
       :clipboard :unnamedplus
       ; Show line numbers and relative.
       :number true
       :relativenumber true
       ; Make signcolumn always one column with signs and linenumber.
       :signcolumn :number}]
  (each [option value (pairs options)]
    (core.assoc vim.o option value)))

; Avoid issues with system's default locale.
(os.setlocale :C)

; Tree style listing for netrw.
(set vim.g.netrw_liststyle 3)

(require :core.keymaps)

(when (= (. (vim.uv.os_uname) :sysname) "Windows_NT")
  (set vim.o.shell (or (and (= (vim.fn.executable :pwsh) 1) :pwsh)
                       (and (= (vim.fn.executable :powershell) 1) :powershell)
                       vim.o.shell)))

(when (vim.fn.has :gui_running)
  (require :core.gui))

{}
