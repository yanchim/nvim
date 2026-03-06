-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Wrapper function to use internal augroup
local function create_autocmd(event, opts)
  vim.api.nvim_create_autocmd(
    event,
    vim.tbl_extend('force', { group = vim.api.nvim_create_augroup('init.lua', {}) }, opts)
  )
end

local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'

if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local clone_cmd = {
    'git',
    'clone',
    '--filter=blob:none',
    -- Uncomment next line to use 'stable' branch
    -- '--branch', 'stable',
    'https://github.com/nvim-mini/mini.nvim',
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd('packadd mini.nvim | helptags ALL')
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Set up 'mini.deps'
local deps = require('mini.deps')
deps.setup({ path = { package = path_package } })

local add, now, later = deps.add, deps.now, deps.later

now(
  function()
    require('mini.basics').setup({
      mappings = { basic = false },
      options = { extra_ui = true },
    })
  end
)

now(function()
  -- Appearance
  vim.o.cursorline = false
  vim.o.relativenumber = true
  -- NOTE: Having `tab` present is needed because `^I` will be shown if
  -- omitted (documented in `:h listchars`), here we hide the tab char.
  vim.o.listchars = 'tab:  ,extends:>,precedes:<,nbsp:.'

  -- Editing
  vim.o.expandtab = true
  vim.o.tabstop = 8
  vim.o.softtabstop = 2
  vim.o.shiftwidth = 2
  vim.o.clipboard = 'unnamedplus'

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
end)

-- Keymap
now(function()
  vim.keymap.set(
    'n',
    '<LocalLeader>cd',
    function() vim.cmd.tcd('%:h') end,
    { desc = "Change tab's cwd to current file" }
  )
  vim.keymap.set('n', '<LocalLeader>dd', function() vim.cmd('verbose pwd') end, { desc = 'pwd' })

  vim.keymap.set({ 'n', 'v' }, '<LocalLeader>w', vim.cmd.write, { desc = 'Write current file' })
  vim.keymap.set({ 'n', 'v' }, '<LocalLeader>Q', function() vim.cmd.quitall({ bang = true }) end, { desc = 'Quit' })

  vim.keymap.set({ 'i', 'n', 'v' }, '<C-X><C-Q>', vim.cmd.quitall, { desc = 'Quit' })
  vim.keymap.set({ 'i', 'n', 'v' }, '<C-X><C-R>', function()
    local buf = vim.api.nvim_get_current_buf()
    vim.bo[buf].readonly = not vim.bo[buf].readonly
  end, { desc = 'Toggle readonly' })
  vim.keymap.set({ 'i', 'n', 'v' }, '<C-X><C-S>', vim.cmd.update, { desc = 'Save buffer' })

  vim.keymap.set('t', 'jk', '<C-\\><C-N>', { desc = 'Exit terminal INSERT mode' })

  vim.keymap.set('n', '<LocalLeader>xl', vim.cmd.lopen, { desc = 'Location list' })
  vim.keymap.set('n', '<LocalLeader>xL', vim.cmd.lclose, { desc = 'Close location list' })
  vim.keymap.set('n', '<LocalLeader>xq', vim.cmd.copen, { desc = 'Quickfix list' })
  vim.keymap.set('n', '<LocalLeader>xQ', vim.cmd.cclose, { desc = 'Close quickfix list' })
  vim.keymap.set('n', '<LocalLeader>xd', vim.diagnostic.open_float, { desc = 'Display Diagnostics' })
  vim.keymap.set('n', '<LocalLeader>xg', vim.cmd.edit, { desc = 'Revert current buffer' })
  vim.keymap.set('n', '<LocalLeader>xG', vim.cmd.checktime, { desc = 'Revert all buffers' })

  -- Window
  vim.keymap.set('n', '<M-j>', '<C-W>j', { desc = 'Move cursor to the downside window' })
  vim.keymap.set('n', '<M-k>', '<C-W>k', { desc = 'Move cursor to the upside window' })
  vim.keymap.set('n', '<M-h>', '<C-W>h', { desc = 'Move cursor to the leftside window' })
  vim.keymap.set('n', '<M-l>', '<C-W>l', { desc = 'Move cursor to the rightside window' })

  vim.keymap.set('n', '<LocalLeader>sq', '<C-W>q', { desc = 'Close current window' })
  vim.keymap.set('n', '<LocalLeader>sa', '<C-W>s', { desc = 'Split window horizontal' })
  vim.keymap.set('n', '<LocalLeader>sd', '<C-W>v', { desc = 'Split window vertically' })
  vim.keymap.set('n', '<LocalLeader>oo', '<C-W>o', { desc = 'Keep current window only' })
  vim.keymap.set('n', '<C-X>0', '<C-W>q', { desc = 'Delete window' })
  vim.keymap.set('n', '<C-X>1', '<C-W>o', { desc = 'Delete other windows' })
  vim.keymap.set('n', '<C-X>2', '<C-W>s', { desc = 'Split window below' })
  vim.keymap.set('n', '<C-X>3', '<C-W>v', { desc = 'Split window right' })
  vim.keymap.set('n', '<C-X>o', '<C-W><C-W>', { desc = 'Other window' })

  -- Tab
  vim.keymap.set('n', '<Leader>to', vim.cmd.tabnew, { desc = 'Open new tab' })
  vim.keymap.set('n', '<Leader>tx', vim.cmd.tabclose, { desc = 'Close current tab' })
  vim.keymap.set('n', '<Leader>tn', vim.cmd.tabn, { desc = 'Go to next tab' })
  vim.keymap.set('n', '<Leader>tp', vim.cmd.tabp, { desc = 'Go to previous tab' })
  vim.keymap.set('n', '<Leader>tf', '<Cmd>tabnew %<CR>', { desc = 'Open current buffer in new tab' })
  vim.keymap.set('n', '<Leader>tt', '<Cmd>tab terminal<CR>', { desc = 'Toggle terminal in tab' })

  vim.keymap.set('n', '<Leader>th', '<Cmd>tabmove -<CR>', { desc = 'Move tab left' })
  vim.keymap.set('n', '<Leader>tl', '<Cmd>tabmove +<CR>', { desc = 'Move tab left' })
  vim.keymap.set('n', '<Leader>ta', '<Cmd>tabmove 0<CR>', { desc = 'Move tab left' })
  vim.keymap.set('n', '<Leader>te', '<Cmd>tabmove $<CR>', { desc = 'Move tab left' })

  -- Readline like behavior
  vim.keymap.set({ 'c', 'i' }, '<C-A>', '<Home>', { desc = 'Bol' })
  vim.keymap.set({ 'c', 'i' }, '<C-E>', '<End>', { desc = 'Eol' })
  vim.keymap.set({ 'c', 'i' }, '<C-D>', '<Delete>', { desc = 'Delete char' })
  vim.keymap.set({ 'c', 'i' }, '<C-F>', '<Right>', { desc = 'Forward char' })
  vim.keymap.set({ 'c', 'i' }, '<C-B>', '<Left>', { desc = 'Backward char' })
  vim.keymap.set('i', '<C-N>', '<Down>', { desc = 'Next line' })
  vim.keymap.set('i', '<C-P>', '<Up>', { desc = 'Prev line' })

  -- Command
  vim.keymap.set('c', '<C-O>', '<C-F>', { desc = 'Command' })
end)

-- GUI
now(function()
  if vim.fn.has('gui_running') then
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
end)

now(function()
  -- https://vim-jp.org/vim-users-jp/2011/02/20/Hack-202.html
  create_autocmd('BufWritePre', {
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
end)

now(function()
  local icons = require('mini.icons')
  icons.setup()

  later(function()
    icons.mock_nvim_web_devicons()
    icons.tweak_lsp_kind()
  end)
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
      -- Highlight hex color strings (`#rrggbb`) using that color
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

later(function()
  local files = require('mini.files')
  files.setup()
  vim.keymap.set('n', '<Leader>fe', files.open, { desc = 'File explorer' })
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

  create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local buf_id = args.data.buf_id
      vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
    end,
  })
end)

later(function()
  local trailspace = require('mini.trailspace')
  trailspace.setup()
  vim.api.nvim_create_user_command('Trim', function()
    trailspace.trim()
    trailspace.trim_last_lines()
  end, { desc = 'Trim trailing space and last blank lines' })
end)

later(function()
  local bufremove = require('mini.bufremove')
  local remove = function()
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
  local removeforce = function() bufremove.delete(0, true) end
  vim.keymap.set('n', '<Leader>bd', remove, { noremap = true, desc = 'Delete buffer' })
  vim.keymap.set('n', '<Leader>bD', removeforce, { noremap = true, desc = 'Delete buffer (force)' })
end)

later(function() require('mini.ai').setup() end)

later(function() require('mini.align').setup() end)

later(function() require('mini.bracketed').setup() end)

later(function() require('mini.comment').setup() end)

later(function() require('mini.pairs').setup() end)

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
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },

      { mode = 'n', keys = '<LocalLeader>' },
      { mode = 'x', keys = '<LocalLeader>' },

      -- Built-in completion
      { mode = 'i', keys = '<C-X>' },

      -- `g` key
      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },

      -- Marks
      { mode = 'n', keys = "'" },
      { mode = 'n', keys = '`' },
      { mode = 'x', keys = "'" },
      { mode = 'x', keys = '`' },

      -- Registers
      { mode = 'n', keys = '"' },
      { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-R>' },
      { mode = 'c', keys = '<C-R>' },

      -- Window commands
      { mode = 'n', keys = '<C-W>' },

      -- `b` key
      { mode = 'n', keys = 'b' },
      { mode = 'x', keys = 'b' },

      -- `c` key
      { mode = 'n', keys = 'c' },
      { mode = 'x', keys = 'c' },

      -- `z` key
      { mode = 'n', keys = 'z' },
      { mode = 'x', keys = 'z' },

      -- mini.nvim
      { mode = 'n', keys = '\\' },
    },

    clues = {
      -- Enhance this by adding descriptions for <Leader> mapping groups
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),

      { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
      { mode = 'n', keys = '<Leader>c', desc = '+Code' },
      { mode = 'n', keys = '<Leader>f', desc = '+File' },
      { mode = 'n', keys = '<Leader>g', desc = '+Git' },
      { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
      { mode = 'n', keys = '<Leader>p', desc = '+Project' },
      { mode = 'n', keys = '<Leader>s', desc = '+Search' },
      { mode = 'x', keys = '<Leader>s', desc = '+Search' },
      { mode = 'n', keys = '<Leader>t', desc = '+Tab' },
      { mode = 'n', keys = '<Leader>u', desc = '+Undo' },
      { mode = 'n', keys = '<Leader>v', desc = '+View' },
    },
  })
end)

later(function() require('mini.diff').setup() end)

later(function()
  local git = require('mini.git')
  git.setup()
  vim.keymap.set('n', '<Leader>ga', git.show_at_cursor, { desc = 'Git at cursor' })
  vim.keymap.set('n', '<Leader>gd', git.show_diff_source, { desc = 'Git diff source' })
  vim.keymap.set('n', '<Leader>gr', git.show_range_history, { desc = 'Git range history' })
end)

later(function() require('mini.jump').setup() end)

later(function() require('mini.jump2d').setup() end)

later(function() require('mini.splitjoin').setup() end)

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
  -- -- Call after setup
  -- snp.start_lsp_server()
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
  vim.keymap.set('n', '<Leader>bb', builtin.buffers, { noremap = true, desc = 'Switch buffer' })
  vim.keymap.set('n', '<LocalLeader>bb', builtin.buffers, { noremap = true, desc = 'Switch buffer' })
  vim.keymap.set('n', '<C-X>b', builtin.buffers, { noremap = true, desc = 'Switch buffer' })

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
  require('mini.extra').setup()

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
end)

-- later(function()
--    local cmp = require('mini.completion')
--
--    cmp.setup()
--
--    -- To handle conflicts with customized keys for popup menu
--    vim.keymap.set(
--       'i',
--       '<C-F>',
--       function() return cmp.scroll('down') and '' or '<Right>' end,
--       { expr = true, desc = 'Forward' }
--    )
--    vim.keymap.set(
--       'i',
--       '<C-B>',
--       function() return cmp.scroll('up') and '' or '<Left>' end,
--       { expr = true, desc = 'Backward' }
--    )
--
--    vim.lsp.config('*', { capabilities = cmp.get_lsp_capabilities() })
-- end)

later(function()
  add({ source = 'saghen/blink.cmp', checkout = 'v1.9.1' })
  require('blink.cmp').setup({
    keymap = {
      -- -- 'default' for mappings similar to built-in completions (C-y to accept)
      -- -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- -- 'enter' for enter to accept
      -- -- 'none' for no mappings
      -- --
      -- -- All presets have the following mappings:
      -- -- C-space: Open menu or open docs if already open
      -- -- C-n/C-p or Up/Down: Select next/previous item
      -- -- C-e: Hide menu
      -- -- C-k: Toggle signature help (if signature.enabled = true)
      -- --
      -- -- See :h blink-cmp-config-keymap for defining your own keymap
      -- preset = 'enter',

      -- Make 'enter' work also
      ['<CR>'] = { 'accept', 'fallback' },

      ['<C-J>'] = { 'scroll_documentation_down', 'fallback' },
      ['<C-K>'] = { 'scroll_documentation_up', 'fallback' },

      -- Disable from the preset
      ['<C-F>'] = false,
      ['<C-B>'] = false,
    },

    snippets = { preset = 'mini_snippets' },

    completion = {
      menu = {
        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                return kind_icon
              end,
              -- -- (optional) use highlights from mini.icons
              -- highlight = function(ctx)
              --    local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              --    return hl
              -- end,
            },
            kind = {
              -- -- (optional) use highlights from mini.icons
              -- highlight = function(ctx)
              --    local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              --    return hl
              -- end,
            },
          },
        },
      },
    },
  })
end)

now(function()
  local parsers = { 'stable', 'unstable' }

  add({
    source = 'nvim-treesitter/nvim-treesitter',
    hooks = {
      post_install = function(args)
        vim.cmd.packadd(args.name)
        require('nvim-treesitter').install(parsers):wait()
      end,
      post_checkout = function()
        require('nvim-treesitter').install(parsers):wait()
        require('nvim-treesitter').update():wait()
      end,
    },
  })

  create_autocmd('FileType', {
    callback = function(args)
      local lang = vim.treesitter.language.get_lang(args.match)
      if lang and vim.treesitter.language.add(lang) then
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.treesitter.start()
      end
    end,
  })

  add({ source = 'nvim-treesitter/nvim-treesitter-textobjects', checkout = 'main', monitor = 'main' })
  require('nvim-treesitter-textobjects').setup()

  add({ source = 'nvim-treesitter/nvim-treesitter-context' })
  vim.keymap.set(
    'n',
    '<Leader>cc',
    function() require('treesitter-context').go_to_context(vim.v.count1) end,
    { noremap = true, desc = 'Jump to context (upwards)' }
  )
end)

later(function()
  add({ source = 'natecraddock/workspaces.nvim' })

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
  add({ source = 'MagicDuck/grug-far.nvim' })
  vim.keymap.set('n', '<Leader>sr', require('grug-far').open, { noremap = true, desc = 'Search and Replace' })
  vim.keymap.set(
    'v',
    '<Leader>sr',
    require('grug-far').with_visual_selection,
    { noremap = true, desc = 'Search and Replace' }
  )
end)

later(function()
  add({ source = 'neovim/nvim-lspconfig' })

  local pickers = require('mini.extra').pickers
  create_autocmd('LspAttach', {
    callback = function()
      vim.keymap.set('n', '<Leader>la', vim.lsp.buf.code_action, { noremap = true, desc = 'Action' })
      vim.keymap.set('n', '<Leader>ld', vim.lsp.buf.definition, { noremap = true, desc = 'Definition' })
      vim.keymap.set('n', '<Leader>lD', vim.lsp.buf.declaration, { noremap = true, desc = 'Declaration' })
      vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.format, { noremap = true, desc = 'Format' })
      vim.keymap.set('n', '<Leader>lh', vim.lsp.buf.signature_help, { noremap = true, desc = 'Help' })
      vim.keymap.set('n', '<Leader>lk', vim.lsp.buf.hover, { noremap = true, desc = 'Hover' })
      vim.keymap.set('n', '<Leader>li', vim.lsp.buf.implementation, { noremap = true, desc = 'Implementation' })
      vim.keymap.set('n', '<Leader>ln', vim.lsp.buf.rename, { noremap = true, desc = 'Rename' })
      vim.keymap.set('n', '<Leader>lr', vim.lsp.buf.references, { noremap = true, desc = 'References' })
      vim.keymap.set('n', '<Leader>ls', vim.lsp.buf.document_symbol, { noremap = true, desc = 'Symbol (document)' })
      vim.keymap.set('n', '<Leader>lS', vim.lsp.buf.workspace_symbol, { noremap = true, desc = 'Symbol (workspace)' })
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
    'fsautocomplete',
    'gopls',
    'hls',
    'lua_ls',
    'ocamllsp',
    'oxfmt',
    'oxlint',
    'rust_analyzer',
    'tinymist',
    'vtsls',
    'vue_ls',
    'zls',
  })
end)

later(function()
  add({ source = 'folke/ts-comments.nvim' })
  require('ts-comments').setup()
end)

later(function()
  add({ source = 'stevearc/conform.nvim' })
  local conform = require('conform')
  conform.setup({
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
      javascript = { 'oxfmt', 'oxlint' },
      javascriptreact = { 'oxfmt', 'oxlint' },
      json = { 'oxfmt' },
      jsonc = { 'oxfmt' },
      lua = { 'stylua' },
      markdown = { 'oxfmt' },
      nix = { 'nixfmt' },
      ocaml = { 'ocamlformat' },
      python = { 'ruff_format' },
      rust = { 'rustfmt' },
      toml = { 'oxfmt' },
      typescript = { 'oxfmt', 'oxlint' },
      typescriptreact = { 'oxfmt', 'oxlint' },
      typst = { 'typstyle' },
      yaml = { 'oxfmt' },
      vue = { 'oxfmt', 'oxlint' },
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
  add({
    source = 'NeogitOrg/neogit',
    depends = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
  })

  local neogit = require('neogit')
  vim.keymap.set('n', '<Leader>gn', neogit.open, { desc = 'Neogit status' })

  vim.keymap.set(
    'n',
    '<Leader>gg',
    function() neogit.open({ cwd = '%:p:h' }) end,
    { desc = 'Current buffer Neogit status' }
  )

  neogit.setup()
end)

later(function()
  add({ source = 'catppuccin/nvim', name = 'catppuccin' })
  add({ source = 'craftzdog/solarized-osaka.nvim' })
  add({ source = 'ellisonleao/gruvbox.nvim' })
  add({ source = 'folke/tokyonight.nvim' })
  add({ source = 'olimorris/onedarkpro.nvim' })
  add({ source = 'projekt0n/github-nvim-theme' })
  add({ source = 'rebelot/kanagawa.nvim' })
end)
