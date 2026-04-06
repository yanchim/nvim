local add = vim.pack.add

add({ 'https://github.com/nvim-mini/mini.nvim' })

local misc = require('mini.misc')

local function now(f) misc.safely('now', f) end
local function later(f) misc.safely('later', f) end

local now_if_args = vim.fn.argc(-1) > 0 and now or later

--- Define custom autocommand group and helper to create an autocommand.
--- Autocommands are Neovim's way to define actions that are executed on events
--- (like creating a buffer, setting an option, etc.).
---
--- @see `:help autocommand`
--- @see vim.api.nvim_del_autocmd
--- @param event vim.api.keyset.events|vim.api.keyset.events[] Event(s) that will trigger the handler (`callback` or `command`).
--- @param opts vim.api.keyset.create_autocmd Options dict:
--- - buffer (`integer?`) Buffer id for buffer-local autocommands `autocmd-buflocal`.
---   Not allowed with {pattern}.
--- - callback (`function|string?`) Lua function (or Vimscript function name, if string)
---   called when the event(s) is triggered. Lua callback can return `lua-truthy` to delete
---   the autocommand. Callback receives one argument, a table with keys: [event-args]()
---     - id: (`number`) Autocommand id
---     - event: (`vim.api.keyset.events`) Name of the triggered event `autocmd-events`
---     - group: (`number?`) Group id, if any
---     - file: (`string`) [<afile>] (not expanded to a full path)
---     - match: (`string`) [<amatch>] (expanded to a full path)
---     - buf: (`number`) [<abuf>]
---     - data: (`any`) Arbitrary data passed from [nvim_exec_autocmds()] [event-data]()
--- - command (string?) Vim command executed on event. Not allowed with {callback}.
--- - desc (`string?`) Description (for documentation and troubleshooting).
--- - group (`string|integer?`) Group name or id to match against.
--- - nested (`boolean?`, default: false) Run nested autocommands `autocmd-nested`.
--- - once (`boolean?`, default: false) Handle the event only once `autocmd-once`.
--- - pattern (`string|array?`) Pattern(s) to match literally `autocmd-pattern`.
--- @return integer # Autocommand id (number)
local function new_autocmd(event, opts)
  return vim.api.nvim_create_autocmd(
    event,
    vim.tbl_extend('force', { group = vim.api.nvim_create_augroup('init.lua', {}) }, opts)
  )
end

-- Define custom `vim.pack.add()` hook helper. See `:h vim.pack-events`.
local function on_packchanged(plugin_name, kinds, callback, desc)
  new_autocmd('PackChanged', {
    pattern = '*',
    callback = function(ev)
      local name, kind = ev.data.spec.name, ev.data.kind
      if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then return end
      if not ev.data.active then vim.cmd.packadd(plugin_name) end
      callback()
    end,
    desc = desc,
  })
end

-- local function on_event(ev, f) misc.safely('event:' .. ev, f) end
-- local function on_filetype(ft, f) misc.safely('filetype:' .. ft, f) end

--- Built-in behavior

-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.o.mouse = 'a' -- Enable mouse
vim.o.mousescroll = 'ver:25,hor:6' -- Customize mouse scroll
vim.o.switchbuf = 'usetab' -- Use already opened buffers when switching
vim.o.undofile = true -- Enable persistent undo

vim.o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)

-- Enable all filetype plugins and syntax (if not enabled, for better startup)
vim.cmd('filetype plugin indent on')
if vim.fn.exists('syntax_on') ~= 1 then vim.cmd('syntax enable') end

-- UI
-- vim.o.breakindent = true -- Indent wrapped lines to match line start
-- vim.o.breakindentopt = 'list:-1' -- Add padding for lists (if 'wrap' is set)
-- vim.o.colorcolumn = '+1' -- Draw column on the right of maximum width
vim.o.cursorline = false -- Disable current line highlighting
vim.o.linebreak = true -- Wrap lines at 'breakat' (if 'wrap' is set)
vim.o.list = true -- Show helpful text indicators
vim.o.number = true -- Show line numbers
vim.o.relativenumber = true
-- vim.o.pumborder = 'single' -- Use border in popup menu
vim.o.pumheight = 10 -- Make popup menu smaller
vim.o.pummaxwidth = 100 -- Make popup menu not too wide
vim.o.ruler = false -- Don't show cursor coordinates
vim.o.shortmess = 'CFOSWaco' -- Disable some built-in completion messages
vim.o.showmode = false -- Don't show mode in command line
vim.o.signcolumn = 'yes' -- Always show signcolumn (less flicker)
vim.o.splitbelow = true -- Horizontal splits will be below
vim.o.splitkeep = 'screen' -- Reduce scroll during window split
vim.o.splitright = true -- Vertical splits will be to the right
-- vim.o.winborder = 'single' -- Use border in floating windows
vim.o.wrap = false -- Don't visually wrap lines (toggle with \w)

vim.o.cursorlineopt = 'screenline,number' -- Show cursor line per screen line

-- Special UI symbols. More is set via 'mini.basics' later.
vim.o.fillchars = 'eob: ,fold:╌'
-- NOTE: Having `tab` present is needed because `^I` will be shown if
-- omitted (documented in `:h listchars`), here we hide the tab char.
vim.o.listchars = 'tab:  ,extends:>,precedes:<,nbsp:.'

-- Folds (see `:h fold-commands`, `:h zM`, `:h zR`, `:h zA`, `:h zj`)
vim.o.foldlevel = 10 -- Fold nothing by default; set to 0 or 1 to fold
vim.o.foldmethod = 'indent' -- Fold based on indent level
vim.o.foldnestmax = 10 -- Limit number of fold levels
vim.o.foldtext = '' -- Show text under fold with its highlighting

-- Editing
vim.o.autoindent = true -- Use auto indent
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.formatoptions = 'rqnl1j' -- Improve comment editing
vim.o.ignorecase = true -- Ignore case during search
vim.o.incsearch = true -- Show search matches while typing
vim.o.infercase = true -- Infer case in built-in completion
vim.o.shiftwidth = 2 -- Use this number of spaces for indentation
vim.o.smartcase = true -- Respect case if search pattern has upper case
vim.o.smartindent = true -- Make indenting smart
vim.o.spelloptions = 'camel' -- Treat camelCase word parts as separate words
vim.o.softtabstop = 2
vim.o.tabstop = 8 -- Show tab as this number of spaces
vim.o.virtualedit = 'block' -- Allow going past end of line in blockwise mode
vim.o.clipboard = 'unnamedplus'

vim.o.iskeyword = '@,48-57,_,192-255,-' -- Treat dash as `word` textobject part

-- Pattern for a start of numbered list (used in `gw`). This reads as
-- "Start of list item is: at least one special character (digit, -, +, *)
-- possibly followed by punctuation (. or `)`) followed by at least one space".
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

-- Built-in completion
vim.o.complete = '.,w,b,kspell' -- Use less sources
vim.o.completeopt = 'menuone,noselect,fuzzy,nosort' -- Use custom behavior
vim.o.completetimeout = 100 -- Limit sources delay

-- Don't auto-wrap comments and don't insert comment leader after hitting 'o'.
-- Do on `FileType` to always override these changes from filetype plugins.
new_autocmd('FileType', {
  callback = function() vim.cmd('setlocal formatoptions-=c formatoptions-=o') end,
  desc = "Proper 'formatoptions'",
})

-- Diagnostics
--
-- Neovim has built-in support for showing diagnostic messages. This
-- configures a more conservative display while still being useful.
-- See `:h vim.diagnostic` and `:h vim.diagnostic.config()`.
-- Use `later()` to avoid sourcing `vim.diagnostic` on startup
later(function()
  vim.diagnostic.config({
    -- Show signs on top of any other sign, but only for warnings and errors
    --- @type vim.diagnostic.Opts.Signs
    signs = { priority = 9999, severity = { min = 'WARN', max = 'ERROR' } },
    -- Show all diagnostics as underline (for their messages type `<Leader>ld`)
    --- @type vim.diagnostic.Opts.Underline
    underline = { severity = { min = 'HINT', max = 'ERROR' } },
    -- Show more details immediately for errors on the current line
    --- @type vim.diagnostic.Opts.VirtualLines
    virtual_lines = false,
    --- @type vim.diagnostic.Opts.VirtualText
    virtual_text = {
      current_line = true,
      severity = { min = 'ERROR', max = 'ERROR' },
    },
    -- Don't update diagnostics when typing
    update_in_insert = false,
  })
end)

os.setlocale('C')

if vim.uv.os_uname().sysname == 'Windows_NT' then
  vim.o.shell = vim.fn.executable('pwsh') == 1 and 'pwsh'
    or vim.fn.executable('powershell') == 1 and 'powershell'
    or vim.o.shell

  vim.o.shellcmdflag = table.concat({
    '-NoLogo',
    '-NonInteractive',
    '-ExecutionPolicy RemoteSigned',
    '-Command',
    [=[ [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();]=],
    [=[$PSDefaultParameterValues['Out-File:Encoding']='utf8';]=],
    [=[$PSStyle.OutputRendering='plaintext';]=],
    [=[Remove-Alias -Force -ErrorAction SilentlyContinue tee;]=],
  }, ' ')

  vim.o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
  vim.o.shellpipe = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'

  vim.o.shellquote = ''
  vim.o.shellxquote = ''
end

-- https://vim-jp.org/vim-users-jp/2011/02/20/Hack-202.html
new_autocmd('BufWritePre', {
  pattern = '*',
  callback = function(event)
    local dir = vim.fs.dirname(event.file)
    local force = vim.v.cmdbang == 1
    if
      vim.fn.isdirectory(dir) == 0
      and (force or vim.fn.confirm('"' .. dir .. '" does not exist. Create?', '&Yes\n&No') == 1)
    then
      vim.fn.mkdir(vim.fn.iconv(dir, vim.o.encoding, vim.o.termencoding), 'p')
    end
  end,
  desc = 'Auto mkdir to save file',
})

--- Keymap

-- Paste linewise before/after current line
-- Usage: `yiw` to yank a word and `]p` to put it on the next line.
vim.keymap.set('n', '[p', '<Cmd>exe "iput! " . v:register<CR>', { noremap = true, desc = 'Paste Above' })
vim.keymap.set('n', ']p', '<Cmd>exe "iput "  . v:register<CR>', { noremap = true, desc = 'Paste Below' })

vim.keymap.set({ 'i', 'n', 'x' }, '<C-X><C-Q>', vim.cmd.quitall, { desc = 'Quit' })
vim.keymap.set({ 'i', 'n', 'x' }, '<C-X><C-R>', function()
  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].readonly = not vim.bo[buf].readonly
end, { desc = 'Toggle readonly' })
vim.keymap.set({ 'i', 'n', 'x' }, '<C-X><C-S>', vim.cmd.update, { desc = 'Save buffer' })

vim.keymap.set('n', '<LocalLeader>w', vim.cmd.write, { noremap = true, desc = 'Write current file' })
vim.keymap.set(
  'n',
  '<LocalLeader>cd',
  function() vim.cmd.tcd('%:h') end,
  { noremap = true, desc = "Change tab's cwd to current file" }
)
vim.keymap.set('n', '<LocalLeader>dd', function() vim.cmd('verbose pwd') end, { noremap = true, desc = 'pwd' })

local function explore_quickfix() vim.cmd(vim.fn.getqflist({ winid = true }).winid ~= 0 and 'cclose' or 'copen') end

local function explore_locations() vim.cmd(vim.fn.getloclist(0, { winid = true }).winid ~= 0 and 'lclose' or 'lopen') end

vim.keymap.set('n', '<LocalLeader>xq', explore_quickfix, { noremap = true, desc = 'Quickfix list' })
vim.keymap.set('n', '<LocalLeader>xQ', explore_locations, { noremap = true, desc = 'Location list' })

vim.keymap.set('n', '<LocalLeader>xd', vim.diagnostic.open_float, { noremap = true, desc = 'Display Diagnostics' })
vim.keymap.set('n', '<LocalLeader>xg', vim.cmd.edit, { noremap = true, desc = 'Revert current buffer' })
vim.keymap.set('n', '<LocalLeader>xG', vim.cmd.checktime, { noremap = true, desc = 'Revert all buffers' })

-- Buffer
vim.keymap.set('n', '<Leader>ba', '<Cmd>b#<CR>', { noremap = true, desc = 'Alternate' })
vim.keymap.set(
  'n',
  '<Leader>bs',
  function() vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true)) end,
  { noremap = true, desc = 'Scratch' }
)

-- Window
vim.keymap.set('n', '<M-j>', '<C-W>j', { noremap = true, desc = 'Move cursor to the downside window' })
vim.keymap.set('n', '<M-k>', '<C-W>k', { noremap = true, desc = 'Move cursor to the upside window' })
vim.keymap.set('n', '<M-h>', '<C-W>h', { noremap = true, desc = 'Move cursor to the leftside window' })
vim.keymap.set('n', '<M-l>', '<C-W>l', { noremap = true, desc = 'Move cursor to the rightside window' })

vim.keymap.set('n', '<C-X>0', '<C-W>q', { noremap = true, desc = 'Delete window' })
vim.keymap.set('n', '<C-X>1', '<C-W>o', { noremap = true, desc = 'Delete other windows' })
vim.keymap.set('n', '<C-X>2', '<C-W>s', { noremap = true, desc = 'Split window below' })
vim.keymap.set('n', '<C-X>3', '<C-W>v', { noremap = true, desc = 'Split window right' })
vim.keymap.set('n', '<C-X>o', '<C-W><C-W>', { noremap = true, desc = 'Other window' })

vim.keymap.set('n', '<LocalLeader>sq', '<C-W>q', { noremap = true, desc = 'Close current window' })
vim.keymap.set('n', '<LocalLeader>sa', '<C-W>s', { noremap = true, desc = 'Split window horizontal' })
vim.keymap.set('n', '<LocalLeader>sd', '<C-W>v', { noremap = true, desc = 'Split window vertically' })
vim.keymap.set('n', '<LocalLeader>oo', '<C-W>o', { noremap = true, desc = 'Keep current window only' })

-- Tab
vim.keymap.set('n', '<Leader>to', vim.cmd.tabnew, { noremap = true, desc = 'Open new tab' })
vim.keymap.set('n', '<Leader>tx', vim.cmd.tabclose, { noremap = true, desc = 'Close current tab' })
vim.keymap.set('n', '<Leader>tn', vim.cmd.tabn, { noremap = true, desc = 'Go to next tab' })
vim.keymap.set('n', '<Leader>tp', vim.cmd.tabp, { noremap = true, desc = 'Go to previous tab' })
vim.keymap.set('n', '<Leader>tf', '<Cmd>tabnew %<CR>', { noremap = true, desc = 'Open current buffer in new tab' })
vim.keymap.set('n', '<Leader>tt', '<Cmd>tab terminal<CR>', { noremap = true, desc = 'Toggle terminal in tab' })

vim.keymap.set('n', '<Leader>th', '<Cmd>tabmove -<CR>', { noremap = true, desc = 'Move tab left' })
vim.keymap.set('n', '<Leader>tl', '<Cmd>tabmove +<CR>', { noremap = true, desc = 'Move tab left' })
vim.keymap.set('n', '<Leader>ta', '<Cmd>tabmove 0<CR>', { noremap = true, desc = 'Move tab left' })
vim.keymap.set('n', '<Leader>te', '<Cmd>tabmove $<CR>', { noremap = true, desc = 'Move tab left' })

-- Readline like behavior
vim.keymap.set('c', '<C-A>', '<Home>', { noremap = true, desc = 'Bol' })
vim.keymap.set('c', '<C-E>', '<End>', { noremap = true, desc = 'Eol' })
vim.keymap.set('c', '<C-D>', '<Delete>', { noremap = true, desc = 'Delete char' })
vim.keymap.set('c', '<C-F>', '<Right>', { noremap = true, desc = 'Forward char' })
vim.keymap.set('c', '<C-B>', '<Left>', { noremap = true, desc = 'Backward char' })
vim.keymap.set('i', '<C-N>', '<Down>', { noremap = true, desc = 'Next line' })
vim.keymap.set('i', '<C-P>', '<Up>', { noremap = true, desc = 'Prev line' })

vim.keymap.set('c', '<C-O>', '<C-F>', { noremap = true, desc = 'Command' })

vim.keymap.set('t', 'jk', '<C-\\><C-N>', { noremap = true, desc = 'Exit terminal INSERT mode' })

--- GUI

if vim.fn.has('gui_running') == 1 then
  if vim.g.neovide then
    local function set_ime(args)
      if args.event:match('Enter$') then
        vim.g.neovide_input_ime = true
        return nil
      else
        vim.g.neovide_input_ime = false
        return nil
      end
    end

    local ime_input = vim.api.nvim_create_augroup('ime_input', { clear = true })

    vim.api.nvim_create_autocmd(
      { 'InsertEnter', 'InsertLeave' },
      { group = ime_input, pattern = '*', callback = set_ime }
    )
    vim.api.nvim_create_autocmd(
      { 'CmdlineEnter', 'CmdlineLeave' },
      { group = ime_input, pattern = '[/\\?]', callback = set_ime }
    )

    vim.g.neovide_input_macos_option_key_is_meta = 'only_left'
  end
end

--- MINI

now(
  function()
    require('mini.basics').setup({
      options = { basic = false },
      mappings = { basic = false },
    })
  end
)

now(function()
  local icons = require('mini.icons')

  -- Set up to not prefer extension-based icon for some extensions
  local ext3_blocklist = { scm = true, txt = true, yml = true }
  local ext4_blocklist = { json = true, yaml = true }

  icons.setup({
    use_file_extension = function(ext, _) return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)]) end,
  })

  later(function()
    icons.mock_nvim_web_devicons()
    icons.tweak_lsp_kind()
  end)
end)

now(function()
  require('mini.notify').setup()
  vim.keymap.set('n', '<Leader>un', require('mini.notify').clear, { noremap = true, desc = 'Clear notify' })
  vim.keymap.set(
    'n',
    '<Leader>vl',
    require('mini.notify').show_history,
    { noremap = true, desc = 'Show notify history' }
  )
end)

now(function()
  local statusline = require('mini.statusline')

  local function section_filename()
    if vim.bo.buftype == 'terminal' then
      -- In terminal always use plain name
      return '%t'
    else
      -- Or use relative path
      return '%f%m%r'
    end
  end

  statusline.setup({
    use_icons = false,
    content = {
      active = function()
        local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
        local diff = statusline.section_diff({ trunc_width = 75 }):gsub('^Diff ', '', 1)
        local lsp = statusline.section_lsp({ trunc_width = 75 }):gsub('^LSP ', '', 1)
        local diagnostics = statusline.section_diagnostics({ trunc_width = 75 }):gsub('^Diag ', '', 1)
        local filename = section_filename()
        local fileinfo = statusline.section_fileinfo({ trunc_width = 120 })
        local location = statusline.section_location({ trunc_width = 75 })
        local search = statusline.section_searchcount({ trunc_width = 75 })

        return statusline.combine_groups({
          { hl = mode_hl, strings = { mode } },
          { hl = 'MiniStatuslineDevinfo', strings = { diff, diagnostics, lsp } },
          '%<', -- Mark general truncate point
          { hl = 'MiniStatuslineFilename', strings = { filename } },
          '%=', -- End left alignment
          { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
          { hl = mode_hl, strings = { search, location } },
        })
      end,
    },
  })
end)

-- now(function() require('mini.tabline').setup() end)

now_if_args(function()
  local cmp = require('mini.completion')

  local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
  local function process_items(items, base) return cmp.default_process_items(items, base, process_items_opts) end

  cmp.setup({
    -- Without this config autocompletion is set up through `:h 'completefunc'`.
    -- Although not needed, setting up through `:h 'omnifunc'` is cleaner
    -- (sets up only when needed) and makes it possible to use `<C-u>`.
    source_func = 'omnifunc',
    auto_setup = false,
    process_items = process_items,
  })

  -- To handle conflicts with customized keys for popup menu
  vim.keymap.set(
    'i',
    '<C-F>',
    function() return cmp.scroll('down') and '' or '<Right>' end,
    { expr = true, desc = 'Forward' }
  )
  vim.keymap.set(
    'i',
    '<C-B>',
    function() return cmp.scroll('up') and '' or '<Left>' end,
    { expr = true, desc = 'Backward' }
  )

  new_autocmd('LspAttach', {
    callback = function(ev) vim.bo[ev.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp' end,
    desc = "Set 'omnifunc' for LSP completion only when needed.",
  })

  -- Advertise to servers that Neovim now supports certain set of completion and
  -- signature features through 'mini.completion'.
  vim.lsp.config('*', { capabilities = cmp.get_lsp_capabilities() })
end)

now_if_args(function()
  local files = require('mini.files')
  files.setup({
    windows = { preview = true },
  })
  vim.keymap.set('n', '<Leader>fe', files.open, { noremap = true, desc = 'File explorer' })
  vim.keymap.set(
    'n',
    '<Leader>ff',
    function() files.open(vim.api.nvim_buf_get_name(0)) end,
    { noremap = true, desc = 'File explorer (current)' }
  )

  local show_dotfiles = true

  local filter_show = function(_) return true end

  local filter_hide = function(fs_entry) return not vim.startswith(fs_entry.name, '.') end

  local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    files.refresh({ content = { filter = new_filter } })
  end

  new_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local buf_id = args.data.buf_id
      vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
    end,
    desc = 'Toggle dotfiles show/hide',
  })
end)

now_if_args(function()
  -- Makes `:h MiniMisc.put()` and `:h MiniMisc.put_text()` public
  misc.setup()

  -- Change current working directory based on the current file path. It
  -- searches up the file tree until the first root marker ('.git' or 'Makefile')
  -- and sets their parent directory as a current directory.
  -- This is helpful when simultaneously dealing with files from several projects.
  misc.setup_auto_root()

  -- Restore latest cursor position on file open
  misc.setup_restore_cursor()

  -- Synchronize terminal emulator background with Neovim's background to remove
  -- possibly different color padding around Neovim instance
  misc.setup_termbg_sync()
end)

-- Extra 'mini.nvim' functionality.
--
-- See also:
-- - `:h MiniExtra.pickers` - pickers. Most are mapped in `<Leader>f` group.
--   Calling `setup()` makes 'mini.pick' respect 'mini.extra' pickers.
-- - `:h MiniExtra.gen_ai_spec` - 'mini.ai' textobject specifications
-- - `:h MiniExtra.gen_highlighter` - 'mini.hipatterns' highlighters
later(function() require('mini.extra').setup() end)

later(function() require('mini.ai').setup() end)

later(function() require('mini.align').setup() end)

later(function() require('mini.bracketed').setup() end)

later(function()
  local bufremove = require('mini.bufremove')
  local function delete()
    if vim.bo.modified then
      local choice = vim.fn.confirm(('Save changes to ' .. vim.fn.bufname() .. '?'), '&Yes\n&No\n&Cancel')
      if choice == 1 then
        vim.cmd.write()
        return bufremove.delete(0)
      elseif choice == 2 then
        return bufremove.delete(0, true)
      end
    else
      return bufremove.delete(0)
    end
  end

  vim.keymap.set('n', '<Leader>bd', delete, { noremap = true, desc = 'Delete' })
  vim.keymap.set('n', '<Leader>bD', function() bufremove.delete(0, true) end, { noremap = true, desc = 'Delete!' })

  vim.keymap.set('n', '<Leader>bw', bufremove.wipeout, { noremap = true, desc = 'Wipeout' })
  vim.keymap.set('n', '<Leader>bW', function() bufremove.wipeout(0, true) end, { noremap = true, desc = 'Wipeout!' })
end)

later(function()
  local miniclue = require('mini.clue')
  miniclue.setup({
    window = {
      config = {
        -- Compute window width automatically
        width = 'auto',
      },
    },
    triggers = {
      -- Leader triggers
      { mode = { 'n', 'x' }, keys = '<Leader>' },

      { mode = { 'n', 'x' }, keys = '<LocalLeader>' },

      -- Built-in completion
      { mode = 'i', keys = '<C-X>' },

      -- `g` key
      { mode = { 'n', 'x' }, keys = 'g' },

      -- Marks
      { mode = { 'n', 'x' }, keys = "'" },
      { mode = { 'n', 'x' }, keys = '`' },

      -- Registers
      { mode = { 'n', 'x' }, keys = '"' },
      { mode = { 'c', 'i' }, keys = '<C-R>' },

      -- Window commands
      { mode = 'n', keys = '<C-W>' },

      -- `b` key
      { mode = { 'n', 'x' }, keys = 'b' },

      -- `c` key
      { mode = { 'n', 'x' }, keys = 'c' },

      -- `z` key
      { mode = { 'n', 'x' }, keys = 'z' },

      -- mini.basics
      { mode = 'n', keys = '\\' },

      -- mini.bracketed
      { mode = { 'n', 'x' }, keys = '[' },
      { mode = { 'n', 'x' }, keys = ']' },
    },

    clues = {
      -- Enhance this by adding descriptions for <Leader> mapping groups
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.square_brackets(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),

      { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
      { mode = 'n', keys = '<Leader>c', desc = '+Code' },
      { mode = 'n', keys = '<Leader>f', desc = '+File' },
      { mode = 'n', keys = '<Leader>g', desc = '+Git' },
      { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
      { mode = 'n', keys = '<Leader>p', desc = '+Project' },
      { mode = 'n', keys = '<Leader>s', desc = '+Search' },
      { mode = 'n', keys = '<Leader>t', desc = '+Tab' },
      { mode = 'n', keys = '<Leader>u', desc = '+Undo' },
      { mode = 'n', keys = '<Leader>v', desc = '+View' },

      { mode = 'x', keys = '<Leader>s', desc = '+Search' },
    },
  })
end)

-- Command line tweaks. Improves command line editing with:
-- - Autocompletion. Basically an automated `:h cmdline-completion`.
-- - Autocorrection of words as-you-type. Like `:W`->`:w`, `:lau`->`:lua`, etc.
-- - Autopeek command range (like line number at the start) as-you-type.
later(function() require('mini.cmdline').setup() end)

later(function() require('mini.comment').setup() end)

later(function() require('mini.diff').setup() end)

later(function()
  local git = require('mini.git')
  git.setup()
  vim.keymap.set('n', '<Leader>gs', git.show_at_cursor, { noremap = true, desc = 'Show at cursor' })
  vim.keymap.set('x', '<Leader>gs', git.show_at_cursor, { noremap = true, desc = 'Show at selection' })
  vim.keymap.set('n', '<Leader>gd', git.show_diff_source, { noremap = true, desc = 'Git diff source' })
  vim.keymap.set('n', '<Leader>gr', git.show_range_history, { noremap = true, desc = 'Git range history' })
end)

later(function()
  local hipatterns = require('mini.hipatterns')
  local hi_words = require('mini.extra').gen_highlighter.words

  hipatterns.setup({
    highlighters = {
      -- Highlight standalone 'FIXME', 'HACK', 'XXX','TODO', 'NOTE'
      fixme = hi_words({ 'FIXME' }, 'MiniHipatternsFixme'),
      hack = hi_words({ 'HACK', 'XXX' }, 'MiniHipatternsHack'),
      todo = hi_words({ 'TODO' }, 'MiniHipatternsTodo'),
      note = hi_words({ 'NOTE' }, 'MiniHipatternsNote'),

      -- Highlight hex color strings (`#aabbcc`) using that color
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })

  vim.keymap.set(
    'n',
    '<Leader>sH',
    require('mini.extra').pickers.hipatterns,
    { noremap = true, desc = 'Search hipatterns' }
  )
end)

later(function() require('mini.jump').setup() end)

later(function() require('mini.jump2d').setup() end)

-- Special key mappings. Provides helpers to map:
-- - Multi-step actions. Apply action 1 if condition is met; else apply
--   action 2 if condition is met; etc.
-- - Combos. Sequence of keys where each acts immediately plus execute extra
--   action if all are typed fast enough. Useful for Insert mode mappings to not
--   introduce delay when typing mapping keys without intention to execute action.
--
-- See also:
-- - `:h MiniKeymap-examples` - examples of common setups
-- - `:h MiniKeymap.map_multistep()` - map multi-step action
-- - `:h MiniKeymap.map_combo()` - map combo
later(function()
  local keymap = require('mini.keymap')

  keymap.setup()
  -- Navigate 'mini.completion' menu with `<Tab>` /  `<S-Tab>`
  keymap.map_multistep('i', '<Tab>', { 'pmenu_next' })
  keymap.map_multistep('i', '<S-Tab>', { 'pmenu_prev' })
  -- On `<CR>` try to accept current completion item, fall back to accounting
  -- for pairs from 'mini.pairs'
  keymap.map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
  -- On `<BS>` just try to account for pairs from 'mini.pairs'
  keymap.map_multistep('i', '<BS>', { 'minipairs_bs' })
end)

-- Move any selection in any direction. Example usage in Normal mode:
-- - `<M-j>`/`<M-k>` - move current line down / up
-- - `<M-h>`/`<M-l>` - decrease / increase indent of current line
--
-- Example usage in Visual mode:
-- - `<M-h>`/`<M-j>`/`<M-k>`/`<M-l>` - move selection left/down/up/right
later(function() require('mini.move').setup() end)

later(function()
  -- Create pairs not only in Insert, but also in Command line mode
  require('mini.pairs').setup({ modes = { command = true } })
end)

later(function()
  require('mini.pick').setup({
    mappings = {
      caret_right = '<C-F>',
      caret_left = '<C-B>',

      scroll_down = '<C-J>',
      scroll_up = '<C-K>',
    },
  })

  local builtin = require('mini.pick').builtin

  -- buffer
  vim.keymap.set('n', '<C-X>b', builtin.buffers, { noremap = true, desc = 'Switch buffer' })
  vim.keymap.set('n', '<Leader>bb', builtin.buffers, { noremap = true, desc = 'Switch buffer' })
  vim.keymap.set('n', '<LocalLeader>bb', builtin.buffers, { noremap = true, desc = 'Switch buffer' })

  -- file
  vim.keymap.set(
    'n',
    '<C-X><C-F>',
    function() builtin.files(nil, { source = { cwd = vim.fn.expand('%:p:h') } }) end,
    { noremap = true, desc = 'Find file' }
  )
  vim.keymap.set('n', '<Leader>sf', builtin.files, { noremap = true, desc = 'Find file' })

  -- search
  vim.keymap.set('n', '<Leader>sg', builtin.grep_live, { noremap = true, desc = 'Grep (live)' })
  vim.keymap.set('n', '<Leader>sG', builtin.grep, { noremap = true, desc = 'Grep' })
  vim.keymap.set(
    'n',
    '<Leader>sc',
    function() builtin.grep({ pattern = vim.fn.expand('<cword>') }) end,
    { noremap = true, desc = 'Find text under cursor' }
  )

  -- undo
  vim.keymap.set('n', '<Leader>up', builtin.resume, { noremap = true, desc = 'Resume picker' })

  -- view
  vim.keymap.set('n', '<Leader>vh', builtin.help, { noremap = true, desc = 'Help' })
end)

later(function()
  local pickers = require('mini.extra').pickers

  -- buffer
  vim.keymap.set('n', '<Leader>bl', pickers.buf_lines, { noremap = true, desc = 'Buffer lines' })

  -- search
  vim.keymap.set(
    'n',
    '<Leader>ss',
    function() pickers.buf_lines({ scope = 'current' }) end,
    { noremap = true, desc = 'Search buffer' }
  )
  vim.keymap.set('n', '<Leader>sb', pickers.buf_lines, { noremap = true, desc = 'Search in buffers' })
  vim.keymap.set('n', '<Leader>sh', pickers.history, { noremap = true, desc = 'Search history' })
  vim.keymap.set(
    'n',
    '<Leader>s/',
    function() pickers.history({ scope = '/' }) end,
    { noremap = true, desc = '"/" history' }
  )
  vim.keymap.set(
    'n',
    '<Leader>s:',
    function() pickers.history({ scope = ':' }) end,
    { noremap = true, desc = '":" history' }
  )

  -- git
  vim.keymap.set('n', '<Leader>gb', pickers.git_branches, { noremap = true, desc = 'Git branches' })
  vim.keymap.set('n', '<Leader>gc', pickers.git_commits, { noremap = true, desc = 'Git commits' })
  vim.keymap.set('n', '<Leader>gf', pickers.git_files, { noremap = true, desc = 'Git files' })
  vim.keymap.set('n', '<Leader>gh', pickers.git_hunks, { noremap = true, desc = 'Git hunks' })

  -- file
  vim.keymap.set('n', '<Leader>fr', pickers.oldfiles, { noremap = true, desc = 'Find recent file' })
  vim.keymap.set('n', '<Leader>fp', pickers.explorer, { noremap = true, desc = 'File picker' })

  -- view
  vim.keymap.set('n', '<Leader>vc', pickers.colorschemes, { noremap = true, desc = 'Colorscheme' })
  vim.keymap.set(
    'n',
    '<Leader>vd',
    function() pickers.diagnostic({ scope = 'current' }) end,
    { noremap = true, desc = 'Diagnostic' }
  )
  vim.keymap.set('n', '<Leader>vD', pickers.diagnostic, { noremap = true, desc = 'Diagnostic (all)' })
  vim.keymap.set('n', '<Leader>vr', pickers.registers, { noremap = true, desc = 'Registers' })
  vim.keymap.set('n', '<Leader>vt', pickers.treesitter, { noremap = true, desc = 'Tree-sitter' })
  vim.keymap.set('n', '<Leader>vk', pickers.keymaps, { noremap = true, desc = 'Keymaps' })
  vim.keymap.set('n', '<Leader>vo', pickers.options, { noremap = true, desc = 'Options' })
  vim.keymap.set('n', '<Leader>vm', pickers.marks, { noremap = true, desc = 'Marks' })
  vim.keymap.set(
    'n',
    '<Leader>vq',
    function() pickers.list({ scope = 'quickfix' }) end,
    { noremap = true, desc = 'Quickfix' }
  )
  vim.keymap.set('n', '<Leader>v:', pickers.commands, { noremap = true, desc = 'Commands' })
  vim.keymap.set('n', '<Leader>vH', pickers.hl_groups, { noremap = true, desc = 'Highlight groups' })
end)

-- How to expand a snippet in Insert mode:
-- - If you know snippet's prefix, type it as a word and press `<C-j>`. Snippet's
--   body should be inserted instead of the prefix.
-- - If you don't remember snippet's prefix, type only part of it (or none at all)
--   and press `<C-j>`. It should show picker with all snippets that have prefixes
--   matching typed characters (or all snippets if none was typed).
--   Choose one and its body should be inserted instead of previously typed text.
later(function()
  -- Define language patterns to work better with 'friendly-snippets'
  local lang_patterns = {
    -- Recognize language of tree-sitter parser
    dart = { 'dart.json', 'dart/flutter.json' },
    javascript = { 'javascript.json', 'ecma/doc.json' },
    typescript = { 'javascript.json', 'typescript.json', 'ecma/doc.json' },
    jsx = { 'javascript.json', 'ecma/*.json' },
    tsx = { 'javascript.json', 'typescript.json', 'ecma/*.json' },
  }

  local snp = require('mini.snippets')
  local config_path = vim.fn.stdpath('config')

  snp.setup({
    snippets = {
      -- Load custom file with global snippets first.
      snp.gen_loader.from_file(config_path .. '/snippets/global.json'),
      -- Load snippets based on current language by reading files from
      -- "snippets/" subdirectories from 'runtimepath' directories.
      snp.gen_loader.from_lang({ lang_patterns = lang_patterns }),
    },
  })

  -- -- Select and insert snippets via completion engine
  -- -- Call after mini.snippets setup
  -- snp.start_lsp_server()
end)

later(function() require('mini.splitjoin').setup() end)

later(function()
  require('mini.surround').setup({
    mappings = {
      add = 'ys',
      delete = 'ds',
      find = 'gN',
      find_left = 'gn',
      highlight = 'gm',
      replace = 'cs',
    },
  })

  -- Remap adding surrounding to Visual mode selection
  vim.keymap.del('x', 'ys')
  vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

  -- Make special mapping for "add surrounding for line"
  vim.keymap.set('n', 'yss', 'ys_', { remap = true })
end)

later(function()
  local trailspace = require('mini.trailspace')
  trailspace.setup()
  vim.api.nvim_create_user_command('Trim', function()
    trailspace.trim()
    trailspace.trim_last_lines()
  end, { desc = 'Trim trailing space and last blank lines' })
end)

now_if_args(function()
  add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
    'https://github.com/nvim-treesitter/nvim-treesitter-context',
  })

  local parsers = { 'stable', 'unstable' }

  require('nvim-treesitter').install(parsers):wait()

  local function ts_update()
    require('nvim-treesitter').install(parsers):wait()
    require('nvim-treesitter').update():wait()
  end

  on_packchanged('nvim-treesitter', { 'update' }, ts_update, ':TSUpdate')

  new_autocmd('FileType', {
    pattern = '*',
    callback = function(args)
      local lang = vim.treesitter.language.get_lang(args.match)
      if lang and vim.treesitter.language.add(lang) then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.wo[0][0].foldmethod = 'expr'
        vim.treesitter.start()
      end
    end,
    desc = 'Treesitter for buffer',
  })

  require('nvim-treesitter-textobjects').setup()

  vim.keymap.set(
    'n',
    '<Leader>cc',
    function() require('treesitter-context').go_to_context(vim.v.count1) end,
    { noremap = true, desc = 'Jump to context (upwards)' }
  )
end)

now_if_args(function()
  add({ 'https://github.com/neovim/nvim-lspconfig' })

  local pickers = require('mini.extra').pickers

  new_autocmd('LspAttach', {
    pattern = '*',
    callback = function()
      -- Command
      vim.keymap.set('n', '<Leader>lq', function() vim.cmd('lsp stop') end, { noremap = true, desc = 'Stop' })
      -- vim.keymap.set('n', '<Leader>lI', vim.cmd(LspInfo), { noremap = true, desc = 'Info' })
      -- vim.keymap.set('n', '<Leader>lL', vim.cmd(LspLog), { noremap = true, desc = 'Log' })
      vim.keymap.set('n', '<Leader>lR', function() vim.cmd('lsp restart') end, { noremap = true, desc = 'Restart' })

      vim.keymap.set('n', '<Leader>la', vim.lsp.buf.code_action, { noremap = true, desc = 'Action' })
      vim.keymap.set('n', '<Leader>lD', vim.lsp.buf.declaration, { noremap = true, desc = 'Declaration' })
      vim.keymap.set('n', '<Leader>ld', vim.lsp.buf.definition, { noremap = true, desc = 'Definition' })
      vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.format, { noremap = true, desc = 'Format' })
      vim.keymap.set('n', '<Leader>lh', vim.lsp.buf.signature_help, { noremap = true, desc = 'Help' })
      vim.keymap.set('n', '<Leader>li', vim.lsp.buf.implementation, { noremap = true, desc = 'Implementation' })
      vim.keymap.set('n', '<Leader>lk', vim.lsp.buf.hover, { noremap = true, desc = 'Hover' })
      vim.keymap.set('n', '<Leader>ln', vim.lsp.buf.rename, { noremap = true, desc = 'Rename' })
      vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.references, { noremap = true, desc = 'References' })
      vim.keymap.set('n', '<Leader>lS', vim.lsp.buf.workspace_symbol, { noremap = true, desc = 'Symbol (workspace)' })
      vim.keymap.set('n', '<Leader>ls', vim.lsp.buf.document_symbol, { noremap = true, desc = 'Symbol (document)' })
      vim.keymap.set('n', '<Leader>lt', vim.lsp.buf.type_definition, { noremap = true, desc = 'Type definition' })

      vim.keymap.set(
        'n',
        '<Leader>ld',
        function() pickers.lsp({ scope = 'definition' }) end,
        { noremap = true, desc = 'Definition' }
      )
      vim.keymap.set(
        'n',
        '<Leader>lD',
        function() pickers.lsp({ scope = 'declaration' }) end,
        { noremap = true, desc = 'Declaration' }
      )
      vim.keymap.set(
        'n',
        '<Leader>lt',
        function() pickers.lsp({ scope = 'type_definition' }) end,
        { noremap = true, desc = 'Type definition' }
      )
      vim.keymap.set(
        'n',
        '<Leader>ls',
        function() pickers.lsp({ scope = 'document_symbol' }) end,
        { noremap = true, desc = 'Symbol (document)' }
      )
      vim.keymap.set(
        'n',
        '<Leader>lS',
        function() pickers.lsp({ scope = 'workspace_symbol' }) end,
        { noremap = true, desc = 'Symbol (workspace)' }
      )
      vim.keymap.set(
        'n',
        '<Leader>li',
        function() pickers.lsp({ scope = 'implementation' }) end,
        { noremap = true, desc = 'Implementation' }
      )
      vim.keymap.set(
        'n',
        '<Leader>lr',
        function() pickers.lsp({ scope = 'references' }) end,
        { noremap = true, desc = 'References' }
      )
    end,
    desc = 'On LSP Attach',
  })

  vim.lsp.enable({
    'clangd',
    'csharp_ls',
    'emmylua_ls',
    'fsautocomplete',
    'gopls',
    'hls',
    'jdtls',
    'kotlin_lsp',
    'ocamllsp',
    'oxfmt',
    'oxlint',
    'rust_analyzer',
    'tinymist',
    'ty',
    'vtsls',
    'vue_ls',
    'zls',
  })
end)

later(function()
  add({ 'https://github.com/stevearc/conform.nvim' })

  local conform = require('conform')
  conform.setup({
    --- @type conform.DefaultFormatOpts
    default_format_opts = {
      -- Allow formatting from LSP server if no dedicated formatter is available
      lsp_format = 'fallback',
    },
    formatters = {
      ['google-java-format'] = {
        append_args = { '--aosp' },
      },
    },
    --- @type table<string, conform.FiletypeFormatter>
    formatters_by_ft = {
      ['*'] = { 'trim_whitespace' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      csharp = { 'csharpier' },
      css = { 'oxfmt' },
      fsharp = { 'fantomas' },
      go = { 'gofmt' },
      haskell = { 'ormolu' },
      html = { 'oxfmt' },
      java = { 'google-java-format' },
      javascript = { 'oxlint', 'oxfmt' },
      javascriptreact = { 'oxlint', 'oxfmt' },
      json = { 'oxfmt' },
      jsonc = { 'oxfmt' },
      kotlin = { 'ktlint' },
      lua = { 'stylua' },
      markdown = { 'oxfmt' },
      nix = { 'nixfmt' },
      ocaml = { 'ocamlformat' },
      python = { 'ruff_fix', 'ruff_format' },
      rust = { 'rustfmt' },
      toml = { 'oxfmt' },
      typescript = { 'oxlint', 'oxfmt' },
      typescriptreact = { 'oxlint', 'oxfmt' },
      typst = { 'typstyle' },
      yaml = { 'oxfmt' },
      vue = { 'oxlint', 'oxfmt' },
      zig = { 'zigfmt' },
    },
  })
  vim.keymap.set(
    'n',
    '<Leader>cf',
    function() conform.format({ async = true }) end,
    { noremap = true, desc = 'Code format' }
  )
  vim.keymap.set('n', '<Leader>cF', vim.cmd.ConformInfo, { noremap = true, desc = 'Code format info' })
end)

later(function()
  add({ 'https://github.com/natecraddock/workspaces.nvim' })

  local ws = require('workspaces')

  vim.keymap.set('n', '<Leader>pp', ws.open, { noremap = true, desc = 'Open workspace' })
  vim.keymap.set('n', '<Leader>pa', ws.add, { noremap = true, desc = 'Add workspace' })
  vim.keymap.set('n', '<Leader>pr', ws.remove, { noremap = true, desc = 'Remove workspace' })
  vim.keymap.set('n', '<Leader>pl', ws.list_dirs, { noremap = true, desc = 'List workspace dirs' })
  vim.keymap.set('n', '<Leader>ps', ws.sync_dirs, { noremap = true, desc = 'Sync workspace in dirs' })

  ws.setup({ cd_type = 'tab', hooks = {
    open = function() require('mini.pick').builtin.files() end,
  } })
end)

later(function()
  add({ 'https://github.com/MagicDuck/grug-far.nvim' })
  vim.keymap.set('n', '<Leader>sr', require('grug-far').open, { noremap = true, desc = 'Search and Replace' })
  vim.keymap.set(
    'v',
    '<Leader>sr',
    require('grug-far').with_visual_selection,
    { noremap = true, desc = 'Search and Replace' }
  )
end)

later(function()
  add({ 'https://github.com/folke/ts-comments.nvim' })
  require('ts-comments').setup()
end)

later(function()
  add({
    'https://github.com/NeogitOrg/neogit',
    -- Dependencies for neogit
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/sindrets/diffview.nvim',
  })

  local neogit = require('neogit')
  vim.keymap.set('n', '<Leader>gn', neogit.open, { desc = 'Neogit status' })

  vim.keymap.set(
    'n',
    '<Leader>gg',
    function() neogit.open({ cwd = '%:p:h' }) end,
    { desc = 'Current buffer Neogit status' }
  )

  neogit.setup({})
end)

later(
  function()
    add({
      { src = 'https://github.com/catppuccin/nvim', name = 'catppuccin' },
      'https://github.com/craftzdog/solarized-osaka.nvim',
      'https://github.com/ellisonleao/gruvbox.nvim',
      'https://github.com/folke/tokyonight.nvim',
      'https://github.com/olimorris/onedarkpro.nvim',
      'https://github.com/projekt0n/github-nvim-theme',
      'https://github.com/rebelot/kanagawa.nvim',
    })
  end
)
