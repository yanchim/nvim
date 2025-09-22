-- Leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- augroup for this config file
local augroup = vim.api.nvim_create_augroup('init.lua', {})

-- wrapper function to use internal augroup
local function create_autocmd(event, opts)
   vim.api.nvim_create_autocmd(
      event,
      vim.tbl_extend('force', {
         group = augroup,
      }, opts)
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

now(function()
   require('mini.basics').setup({
      options = { extra_ui = true },
   })
end)

now(function()
   require('utils')
   require('keymaps')
   if vim.fn.has('gui_running') then require('gui') end

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
            vim.fn.mkdir(vim.fn.iconv(dir, vim.opt.encoding:get(), vim.opt.termencoding:get()), 'p')
         end
      end,
      desc = 'Auto mkdir to save file',
   })
end)

now(function()
   local icons = require('mini.icons')
   icons.setup()
   icons.mock_nvim_web_devicons()
end)

-- now(function() require('mini.tabline').setup() end)

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

-- now(function()
--    local notify = require('mini.notify')
--    notify.setup()
--    vim.notify = notify.make_notify()
--    vim.api.nvim_create_user_command(
--       'NotifyHistory',
--       function() notify.show_history() end,
--       { desc = 'Show notify history' }
--    )
-- end)

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
end)

later(function()
   local files = require('mini.files')
   files.setup()
   vim.keymap.set('n', '<Leader>fe', files.open, { desc = 'File Explorer' })

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
         { mode = 'i', keys = '<C-x>' },

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
         { mode = 'i', keys = '<C-r>' },
         { mode = 'c', keys = '<C-r>' },

         -- Window commands
         { mode = 'n', keys = '<C-w>' },

         -- `b` key
         { mode = 'n', keys = 'b' },
         { mode = 'x', keys = 'b' },

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
   vim.keymap.set('n', '<Leader>gh', git.show_range_history, { desc = 'Git range history' })
end)

later(function() require('mini.jump').setup() end)

later(function() require('mini.jump2d').setup() end)

later(function()
   local snp = require('mini.snippets')
   local lang_patterns = {
      tsx = {
         'snippets/ecma/javascript.json',
         'snippets/ecma/typescript.json',
      },
      typescript = {
         'snippets/ecma/javascript.json',
         'snippets/ecma/typescript.json',
      },
   }
   snp.setup({
      snippets = {
         -- Load custom file with global snippets first.
         snp.gen_loader.from_file(vim.fn.stdpath('config') .. '/snippets/snippets/all.json'),
         -- Load snippets based on current language by reading files from
         -- "snippets/" subdirectories from 'runtimepath' directories.
         snp.gen_loader.from_lang({ lang_patterns = lang_patterns }),
         -- snp.gen_loader.from_lang(),
      },
   })
end)

-- later(function()
--    require("mini.pick").setup()
--    vim.ui.select = MiniPick.ui_select
--    local builtin = MiniPick.builtin
--    vim.keymap.set("n", "<Leader>bb", builtin.buffers, { noremap = true, desc = "Switch buffer" })
--    vim.keymap.set("n", "<LocalLeader>bb", builtin.buffers, { noremap = true, desc = "Switch buffer" })
--    vim.keymap.set("n", "<C-X>b", builtin.buffers, { noremap = true, desc = "Switch buffer" })
--    vim.keymap.set("n", "<C-X><C-F>", builtin.files, { noremap = true, desc = "Find file" })
--    vim.keymap.set("n", "<Leader>sf", builtin.files, { noremap = true, desc = "Find file" })
--    vim.keymap.set("n", "<Leader>sg", builtin.grep_live, { noremap = true, desc = "Grep" })
--    vim.keymap.set("n", "<Leader>vh", builtin.help, { noremap = true, desc = "Help" })
-- end)

-- later(function()
--    require("mini.extra").setup()
--    local pickers = MiniExtra.pickers
--    vim.keymap.set("n", "<Leader>se", pickers.explorer, { noremap = true, desc = "Explorer" })
--    vim.keymap.set("n", "<Leader>ss", pickers.buf_lines, { noremap = true, desc = "Search buffer" })
--    vim.keymap.set("n", "<Leader>st", pickers.hipatterns, { noremap = true, desc = "Search todo" })
--    vim.keymap.set("n", "<Leader>gc", pickers.git_commits, { noremap = true, desc = "Git commits" })
--    vim.keymap.set("n", "<Leader>vc", pickers.colorschemes, { noremap = true, desc = "Colorscheme" })
--    vim.keymap.set("n", "<Leader>vd", pickers.diagnostic, { noremap = true, desc = "Diagnostic" })
--    vim.keymap.set("n", "<Leader>vr", pickers.registers, { noremap = true, desc = "Registers" })
--    vim.keymap.set("n", "<Leader>vk", pickers.keymaps, { noremap = true, desc = "Keymaps" })
--    vim.keymap.set("n", "<Leader>v:", pickers.commands, { noremap = true, desc = "Commands" })
-- end)

now(function()
   local parsers = { 'stable', 'unstable' }

   add({
      source = 'nvim-treesitter/nvim-treesitter',
      checkout = 'main',
      monitor = 'main',
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
   add({ source = 'saghen/blink.cmp', checkout = 'v1.7.0' })
   require('blink.cmp').setup({
      keymap = {
         ['<CR>'] = { 'select_and_accept', 'fallback' },
      },
      cmdline = {
         keymap = {
            ['<C-g>'] = { 'cancel' },
            -- disable a keymap from the preset
            ['<C-e>'] = false,
         },
      },
      sources = {
         -- 'buffer' is for text completions, by default it's only enabled when LSP returns no items
         default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      snippets = { preset = 'mini_snippets' },
   })
end)

later(function()
   add({ source = 'ibhagwan/fzf-lua' })

   local fzf = require('fzf-lua')
   fzf.register_ui_select()

   vim.keymap.set('n', '<Leader>bb', fzf.buffers, { noremap = true, desc = 'Switch buffer' })
   vim.keymap.set('n', '<LocalLeader>bb', fzf.buffers, { noremap = true, desc = 'Switch buffer' })
   vim.keymap.set('n', '<C-X>b', fzf.buffers, { noremap = true, desc = 'Switch buffer' })
   vim.keymap.set(
      'n',
      '<LocalLeader>ff',
      function() fzf.files({ cwd = '%:p:h' }) end,
      { noremap = true, desc = 'Open file browser with current buffer' }
   )
   vim.keymap.set(
      'n',
      '<Leader>fc',
      function() fzf.files({ cwd = '%:p:h' }) end,
      { noremap = true, desc = 'Open file browser with current buffer' }
   )
   vim.keymap.set('n', '<Leader>ff', fzf.files, { noremap = true, desc = 'Open file browser' })
   vim.keymap.set('n', '<Leader>fr', fzf.oldfiles, { noremap = true, desc = 'Recent files' })
   vim.keymap.set(
      'n',
      '<C-X><C-F>',
      function() fzf.files({ cwd = '%:p:h' }) end,
      { noremap = true, desc = 'Find file' }
   )

   vim.keymap.set('n', '<Leader>gc', fzf.git_commits, { noremap = true, desc = 'Git commits' })
   vim.keymap.set('n', '<Leader>gf', fzf.git_files, { noremap = true, desc = 'Git files' })
   vim.keymap.set('n', '<Leader>gs', fzf.git_status, { noremap = true, desc = 'Git status' })

   vim.keymap.set('n', '<Leader>sc', fzf.grep_cword, { noremap = true, desc = 'Find string under cursor' })
   vim.keymap.set('v', '<Leader>sc', fzf.grep_visual, { noremap = true, desc = 'Search selected text' })
   vim.keymap.set('n', '<Leader>sf', fzf.files, { noremap = true, desc = 'Find file' })
   vim.keymap.set('n', '<Leader>sg', fzf.live_grep, { noremap = true, desc = 'Grep' })
   vim.keymap.set('n', '<Leader>ss', fzf.grep_curbuf, { noremap = true, desc = 'Search buffer' })
   vim.keymap.set('v', '<Leader>ss', fzf.grep_visual, { noremap = true, desc = 'Search selected text' })
   vim.keymap.set('n', '<Leader>sd', fzf.zoxide, { noremap = true, desc = 'Recent directories' })
   vim.keymap.set('n', '<Leader>sp', fzf.global, { noremap = true, desc = 'Global pickers' })
   vim.keymap.set('n', '<LocalLeader>ss', fzf.grep_curbuf, { noremap = true, desc = 'Search buffer' })
   vim.keymap.set('n', '<LocalLeader>gg', fzf.live_grep, { noremap = true, desc = 'Grep' })
   vim.keymap.set('n', '<Leader>v:', fzf.commands, { noremap = true, desc = 'Commands' })
   vim.keymap.set('n', '<Leader>vc', fzf.colorschemes, { noremap = true, desc = 'Colorscheme' })
   vim.keymap.set('n', '<Leader>vh', fzf.helptags, { noremap = true, desc = 'Help tags' })
   vim.keymap.set('n', '<Leader>vk', fzf.keymaps, { noremap = true, desc = 'Keymaps' })
   vim.keymap.set('n', '<Leader>vm', fzf.marks, { noremap = true, desc = 'Marks' })
   vim.keymap.set('n', '<Leader>vr', fzf.registers, { noremap = true, desc = 'Registers' })

   fzf.setup({
      keymap = {
         builtin = {
            ['<C-g>'] = 'toggle-preview',
            ['<C-f>'] = 'preview-page-down',
            ['<C-b>'] = 'preview-page-up',
            ['<C-d>'] = 'preview-half-page-down',
            ['<C-u>'] = 'preview-half-page-up',
            ['<C-j>'] = 'preview-down',
            ['<C-k>'] = 'preview-up',
         },
      },
      -- Cycle among results
      fzf_opts = { ['--cycle'] = true },
   })
end)

later(function()
   add({ source = 'natecraddock/workspaces.nvim' })

   local ws = require('workspaces')
   local fzf = require('fzf-lua')

   local function openws()
      local workspaces = ws.get()

      local function preview(item)
         local name = item[1]
         local matched = vim.iter(workspaces):filter(function(workspace) return workspace.name == name end):next()
         return matched.path
      end

      return fzf.fzf_exec(function(cb)
         for _, workspace in ipairs(workspaces) do
            cb(workspace.name)
         end
      end, {
         prompt = 'Workspace> ',
         actions = {
            enter = { fn = function(selected) ws.open(selected[1]) end },
            ['ctrl-t'] = {
               fn = function(selected)
                  vim.cmd.tabnew()
                  ws.open(selected[1])
               end,
            },
         },
         preview = preview,
      })
   end
   vim.keymap.set('n', '<Leader>pp', openws, { noremap = true, desc = 'Open workspace' })
   vim.keymap.set('n', '<Leader>pa', ws.add, { noremap = true, desc = 'Add workspace' })
   vim.keymap.set('n', '<Leader>pr', ws.remove, { noremap = true, desc = 'Remove workspace' })
   vim.keymap.set('n', '<Leader>pl', ws.list_dirs, { noremap = true, desc = 'List dirs which contain workspaces' })
   vim.keymap.set('n', '<Leader>ps', ws.sync_dirs, { noremap = true, desc = 'Sync workspaces in dir' })

   ws.setup({ cd_type = 'tab', hooks = { open = { 'FzfLua files' } } })
end)

later(function()
   add({ source = 'MagicDuck/grug-far.nvim' })
   vim.keymap.set({ 'n', 'v' }, '<Leader>sr', function()
      local grug = require('grug-far')
      local ext = ((vim.bo.buftype == '') and vim.fn.expand('%:e'))
      return grug.open({
         prefills = { filesFilter = (((ext and (ext ~= '')) and ('*.' .. ext)) or nil) },
         transient = true,
      })
   end, { noremap = true, desc = 'Search and Replace' })
end)

later(function()
   add({ source = 'neovim/nvim-lspconfig' })

   local fzf = require('fzf-lua')
   create_autocmd('LspAttach', {
      callback = function()
         vim.keymap.set('n', '<Leader>lh', vim.lsp.buf.signature_help, { noremap = true })
         vim.keymap.set('n', '<Leader>ln', vim.lsp.buf.rename, { noremap = true })
         vim.keymap.set('n', '<Leader>le', vim.diagnostic.open_float, { noremap = true })
         vim.keymap.set('n', '<Leader>lq', vim.diagnostic.setloclist, { noremap = true })
         vim.keymap.set('n', '<Leader>lf', vim.lsp.buf.format, { noremap = true })
         vim.keymap.set('n', '<Leader>la', vim.lsp.buf.code_action, { noremap = true })
         vim.keymap.set('v', '<Leader>la', vim.lsp.buf.code_action, { noremap = true })

         vim.keymap.set('n', '<Leader>ld', fzf.lsp_definitions, { noremap = true })
         vim.keymap.set('n', '<Leader>lD', fzf.lsp_declarations, { noremap = true })
         vim.keymap.set('n', '<Leader>lt', fzf.lsp_typedefs, { noremap = true })
         vim.keymap.set('n', '<Leader>lx', fzf.diagnostics_document, { noremap = true })
         vim.keymap.set('n', '<Leader>lX', fzf.diagnostics_workspace, { noremap = true })
         vim.keymap.set('n', '<Leader>lr', fzf.lsp_references, { noremap = true })
         vim.keymap.set('n', '<Leader>ls', fzf.lsp_document_symbols, { noremap = true })
         vim.keymap.set('n', '<Leader>lS', fzf.lsp_workspace_symbols, { noremap = true })
         vim.keymap.set('n', '<Leader>li', fzf.lsp_implementations, { noremap = true })
      end,
      desc = 'On LSP Attach',
   })

   vim.lsp.config('lua_ls', {
      on_init = function(client)
         if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if
               path ~= vim.fn.stdpath('config')
               and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
            then
               return
            end
         end

         client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
               -- Most likely LuaJIT in the case of Neovim.
               version = 'LuaJIT',
               -- Tell the language server how to find Lua modules same way as Neovim.
               -- (see `:h lua-module-load`)
               path = {
                  'lua/?.lua',
                  'lua/?/init.lua',
               },
            },
            -- Make the server aware of Neovim runtime files.
            workspace = {
               checkThirdParty = false,
               library = {
                  vim.env.VIMRUNTIME,
                  -- Add additional paths here.
                  '${3rd}/luv/library',
                  -- '${3rd}/busted/library'
               },
               -- Or pull in all of 'runtimepath'.
               -- NOTE: this is a lot slower and will cause issues when working on
               -- your own configuration.
               -- See https://github.com/neovim/nvim-lspconfig/issues/3189
               -- library = {
               --   vim.api.nvim_get_runtime_file('', true),
               -- }
            },
         })
      end,
      settings = {
         Lua = {},
      },
   })

   local vue_language_server_path = vim.fn.expand('~') .. '/.bun/install/global/node_modules/@vue/language-server'
   local vue_plugin = {
      name = '@vue/typescript-plugin',
      location = vue_language_server_path,
      languages = { 'vue' },
      configNamespace = 'typescript',
   }
   vim.lsp.config('vtsls', {
      settings = { vtsls = { tsserver = { globalPlugins = { vue_plugin } } } },
      filetypes = {
         'javascript',
         'javascriptreact',
         'javascript.jsx',
         'typescript',
         'typescriptreact',
         'typescript.tsx',
         'vue',
      },
   })

   vim.lsp.enable({
      'clangd',
      'csharp_ls',
      'eslint',
      'fsautocomplete',
      'gopls',
      'hls',
      'lua_ls',
      'ocamllsp',
      'rust_analyzer',
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
         css = { 'prettier', 'eslint_d' },
         fsharp = { 'fantomas' },
         go = { 'gofmt' },
         haskell = { 'ormolu' },
         html = { 'prettier', 'eslint_d' },
         javascript = { 'prettier', 'eslint_d' },
         javascriptreact = { 'prettier', 'eslint_d' },
         ['javascript.jsx'] = { 'prettier', 'eslint_d' },
         json = { 'prettier', 'eslint_d' },
         jsonc = { 'prettier', 'eslint_d' },
         lua = { 'stylua' },
         markdown = { 'prettier', 'eslint_d' },
         nix = { 'nixfmt' },
         ocaml = { 'ocamlformat' },
         odin = { 'odinfmt' },
         python = { 'ruff_format' },
         rust = { 'rustfmt' },
         toml = { 'taplo' },
         typescript = { 'prettier', 'eslint_d' },
         typescriptreact = { 'prettier', 'eslint_d' },
         ['typescript.tsx'] = { 'prettier', 'eslint_d' },
         typst = { 'typstyle' },
         vue = { 'prettier', 'eslint_d' },
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

later(function() add({ source = 'MunifTanjim/nui.nvim' }) end)

later(function()
   add({ source = 'rcarriga/nvim-notify' })
   vim.keymap.set('n', '<Leader>vl', require('notify.integrations').pick, { noremap = true, desc = 'View logs' })
   vim.keymap.set(
      'n',
      '<Leader>un',
      function() require('notify').dismiss({ silent = true, pending = true }) end,
      { noremap = true, desc = 'View logs' }
   )
end)

later(function()
   add({ source = 'folke/noice.nvim' })
   require('noice').setup({
      cmdline = {
         format = {
            cmdline = { icon = '>' },
            filter = { icon = '$' },
            help = { icon = 'H' },
            search_down = { icon = '/' },
            search_up = { icon = '?' },
         },
      },
      lsp = {
         -- override markdown rendering to use **Treesitter**
         override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
         },
      },
      presets = {
         bottom_search = true,
         command_palette = true,
         long_message_to_split = true,
         lsp_doc_border = false,
      },
      routes = {
         {
            view = 'notify',
            filter = {
               event = 'msg_showmode',
               any = { { find = 'recording' } },
            },
         },
         {
            filter = { event = 'notify', find = 'No information available' },
            opts = { skip = true },
         },
      },
   })
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
