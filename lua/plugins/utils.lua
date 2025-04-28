-- [nfnl] fnl/plugins/utils.fnl
local function _1_()
  local telescope = require("telescope")
  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "<Leader>bb", builtin.buffers, {noremap = true, desc = "Switch buffer"})
  vim.keymap.set("n", "<C-X>b", builtin.buffers, {noremap = true, desc = "Switch buffer"})
  local function _2_()
    return telescope.extensions.file_browser.file_browser({path = "%:p:h", select_buffer = true})
  end
  vim.keymap.set("n", "<LocalLeader>ff", _2_, {noremap = true, desc = "Open file browser with current buffer"})
  local function _3_()
    return telescope.extensions.file_browser.file_browser({path = "%:p:h", select_buffer = true})
  end
  vim.keymap.set("n", "<Leader>fc", _3_, {noremap = true, desc = "Open file browser with current buffer"})
  vim.keymap.set("n", "<Leader>ff", telescope.extensions.file_browser.file_browser, {noremap = true, desc = "Open file browser"})
  vim.keymap.set("n", "<Leader>fr", builtin.oldfiles, {noremap = true, desc = "Recent files"})
  local function _4_()
    return telescope.extensions.file_browser.file_browser({path = "%:p:h", select_buffer = true})
  end
  vim.keymap.set("n", "<C-X><C-F>", _4_, {noremap = true, desc = "Find file"})
  vim.keymap.set("n", "<Leader>gt", builtin.git_status, {noremap = true, desc = "Git status"})
  vim.keymap.set("n", "<Leader>sc", builtin.grep_string, {noremap = true, desc = "Find string under cursor"})
  vim.keymap.set("n", "<Leader>sf", builtin.find_files, {noremap = true, desc = "Find file"})
  vim.keymap.set("n", "<Leader>sg", builtin.live_grep, {noremap = true, desc = "Grep"})
  vim.keymap.set("n", "<Leader>ss", builtin.current_buffer_fuzzy_find, {noremap = true, desc = "Search buffer"})
  vim.keymap.set("n", "<LocalLeader>ss", builtin.current_buffer_fuzzy_find, {noremap = true, desc = "Search buffer"})
  vim.keymap.set("n", "<LocalLeader>gg", builtin.live_grep, {noremap = true, desc = "Grep"})
  vim.keymap.set("n", "<Leader>v:", builtin.commands, {noremap = true, desc = "Commands"})
  vim.keymap.set("n", "<Leader>vc", builtin.colorscheme, {noremap = true, desc = "Colorscheme"})
  vim.keymap.set("n", "<Leader>vh", builtin.help_tags, {noremap = true, desc = "Help tags"})
  vim.keymap.set("n", "<Leader>vk", builtin.keymaps, {noremap = true, desc = "Keymaps"})
  vim.keymap.set("n", "<Leader>vm", builtin.marks, {noremap = true, desc = "Marks"})
  vim.keymap.set("n", "<Leader>vo", builtin.vim_options, {noremap = true, desc = "Options"})
  vim.keymap.set("n", "<Leader>vr", builtin.registers, {noremap = true, desc = "Registers"})
  return vim.keymap.set("n", "<Leader>vt", vim.cmd.TSContextToggle, {noremap = true, desc = "Treesitter context"})
end
local function _5_()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local fb_actions = require("telescope._extensions.file_browser.actions")
  telescope.setup({defaults = {file_ignore_patterns = {"node_modules"}, vimgrep_arguments = {"rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--iglob", "!.git", "--hidden"}}, pickers = {find_files = {find_command = {"fd", "--full-path", "--color=never"}}, live_grep = {mappings = {i = {["<C-F>"] = actions.to_fuzzy_refine}}}, colorscheme = {enable_preview = true}}, extensions = {file_browser = {collapse_dirs = true, mappings = {n = {g = fb_actions.toggle_respect_gitignore}, i = {["<C-G>"] = fb_actions.toggle_respect_gitignore}}}}})
  return telescope.load_extension("file_browser")
end
local function _6_()
  local ws = require("workspaces")
  local ts = require("telescope")
  ts.load_extension("workspaces")
  vim.keymap.set("n", "<Leader>pp", ts.extensions.workspaces.workspaces, {noremap = true, desc = "Open workspace"})
  vim.keymap.set("n", "<Leader>pa", ws.add, {noremap = true, desc = "Add workspace"})
  vim.keymap.set("n", "<Leader>pr", ws.remove, {noremap = true, desc = "Remove workspace"})
  vim.keymap.set("n", "<Leader>pl", ws.list_dirs, {noremap = true, desc = "List dirs which contain workspaces"})
  vim.keymap.set("n", "<Leader>ps", ws.sync_dirs, {noremap = true, desc = "Sync workspaces in dir"})
  return ws.setup({cd_type = "tab", hooks = {open = {"Telescope find_files"}}})
end
local function _7_()
  local grug = require("grug-far")
  local ext = ((vim.bo.buftype == "") and vim.fn.expand("%:e"))
  return grug.open({prefills = {filesFilter = (((ext and (ext ~= "")) and ("*." .. ext)) or nil)}, transient = true})
end
local function _8_()
  return require("todo-comments").jump_prev()
end
local function _9_()
  return require("todo-comments").jump_next()
end
local function _10_()
  return require("flash").jump()
end
local function _11_()
  return require("flash").jump({label = {after = {0, 0}}, pattern = "^", search = {max_length = 0, mode = "search"}})
end
local function _12_()
  return require("flash").treesitter()
end
local function _13_()
  return require("flash").remote()
end
local function _14_()
  return require("treesitter_search").remote()
end
local function _15_()
  return require("flash").toggle()
end
local function _16_()
  local wk = require("which-key")
  local function _17_()
    return require("which-key").show({global = false})
  end
  return wk.add({{"<Leader>?", _17_, desc = "Buffer local keymaps"}, {"<Leader>b", group = "Buffer"}, {"<Leader>c", group = "Code"}, {"<Leader>e", group = "Explore"}, {"<Leader>f", group = "File"}, {"<Leader>g", group = "Git"}, {"<Leader>gb", group = "Buffer"}, {"<Leader>gh", group = "Hunk"}, {"<Leader>gl", group = "Line"}, {"<Leader>l", group = "Lsp"}, {"<Leader>m", group = "Mine"}, {"<Leader>o", group = "Org"}, {"<Leader>p", group = "Project"}, {"<Leader>s", group = "Search"}, {"<Leader>t", group = "Tab"}, {"<Leader>u", group = "Undo"}, {"<Leader>v", group = "View"}})
end
return {{"nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim"}, init = _1_, config = _5_}, {"natecraddock/workspaces.nvim", dependencies = {"nvim-telescope/telescope.nvim"}, config = _6_}, {"MagicDuck/grug-far.nvim", opts = {}, keys = {{"<Leader>sr", _7_, mode = {"n", "v"}, desc = "Search and Replace"}}}, {"kylechui/nvim-surround", event = "VeryLazy", opts = {}}, {"echasnovski/mini.align", opts = {}}, {"echasnovski/mini.pairs", event = "VeryLazy", opts = {modes = {insert = true, command = true, terminal = false}, skip_ts = {"string"}, skip_unbalanced = true, markdown = true}}, {"folke/todo-comments.nvim", dependencies = {"nvim-lua/plenary.nvim"}, opts = {signs = false}, keys = {{"[c", _8_, mode = "n", desc = "Prev todo comment"}, {"]c", _9_, mode = "n", desc = "Next todo comment"}, {"<Leader>st", "<Cmd>TodoTelescope<CR>", mode = "n", desc = "Search todo comment"}}, lazy = false}, {"folke/flash.nvim", event = "VeryLazy", opts = {}, keys = {{"<LocalLeader>aa", _10_, mode = {"n", "o", "x"}, desc = "Flash"}, {"<LocalLeader>al", _11_, mode = {"n", "o", "x"}, desc = "Flash Line"}, {"<LocalLeader>at", _12_, mode = {"n", "o", "x"}, desc = "Flash Treesitter"}, {"<LocalLeader>ar", _13_, mode = "o", desc = "Remote Flash"}, {"<LocalLeader>as", _14_, mode = {"o", "x"}, desc = "Treesitter Search"}, {"<C-S>", _15_, mode = "c", desc = "Toggle Flash Search"}}}, {"folke/which-key.nvim", event = "VeryLazy", opts = {}, config = _16_}}
