-- [nfnl] Compiled from fnl/plugins/utils.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  do
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<Leader>bb", builtin.buffers, {noremap = true, desc = "Switch buffer"})
    vim.keymap.set("n", "<C-X>b", builtin.buffers, {noremap = true, desc = "Switch buffer"})
    vim.keymap.set("n", "<LocalLeader>ff", "<Cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", {noremap = true, desc = "Open file browser with current buffer"})
    vim.keymap.set("n", "<Leader>fc", "<Cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", {noremap = true, desc = "Open file browser with current buffer"})
    vim.keymap.set("n", "<Leader>ff", "<Cmd>Telescope file_browser<CR>", {noremap = true, desc = "Open file browser"})
    vim.keymap.set("n", "<C-X><C-F>", "<Cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", {noremap = true, desc = "Find file"})
    vim.keymap.set("n", "<Leader>gt", builtin.git_status, {noremap = true, desc = "Git status"})
    vim.keymap.set("n", "<Leader>sc", builtin.grep_string, {noremap = true, desc = "Find string under cursor"})
    vim.keymap.set("n", "<Leader>sf", builtin.find_files, {noremap = true, desc = "Find file"})
    vim.keymap.set("n", "<Leader>sg", builtin.live_grep, {noremap = true, desc = "Grep"})
    vim.keymap.set("n", "<Leader>sr", builtin.oldfiles, {noremap = true, desc = "Find recent buffer"})
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
    vim.keymap.set("n", "<Leader>vt", vim.cmd.TSContextToggle, {noremap = true, desc = "Treesitter context"})
  end
  local telescope = require("telescope")
  return telescope.load_extension("file_browser")
end
local function _2_()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local fb_actions = require("telescope._extensions.file_browser.actions")
  return telescope.setup({defaults = {file_ignore_patterns = {"node_modules"}, vimgrep_arguments = {"rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--iglob", "!.git", "--hidden"}}, pickers = {find_files = {find_command = {"fd", "--full-path", "--color=never"}}, live_grep = {mappings = {i = {["<C-F>"] = actions.to_fuzzy_refine}}}, colorscheme = {enable_preview = true}}, extensions = {file_browser = {collapse_dirs = true, mappings = {n = {g = fb_actions.toggle_respect_gitignore}, i = {["<C-G>"] = fb_actions.toggle_respect_gitignore}}}}})
end
local function _3_()
  local surround = require("nvim-surround")
  return surround.setup()
end
local function _4_()
  local mp = require("mini.pairs")
  return mp.setup()
end
local function _5_()
  return (require("todo-comments")).jump_prev()
end
local function _6_()
  return (require("todo-comments")).jump_next()
end
local function _7_()
  return (require("flash")).jump()
end
local function _8_()
  return (require("flash")).jump({label = {after = {0, 0}}, pattern = "^", search = {max_length = 0, mode = "search"}})
end
local function _9_()
  return (require("flash")).treesitter()
end
local function _10_()
  return (require("flash")).remote()
end
local function _11_()
  return (require("treesitter_search")).remote()
end
local function _12_()
  return (require("flash")).toggle()
end
local function _13_()
  local wk = require("which-key")
  local function _14_()
    return (require("which-key")).show({global = false})
  end
  return wk.add({{"<Leader>?", _14_, desc = "Buffer local keymaps"}, {"<Leader>b", group = "Buffer"}, {"<Leader>c", group = "Code"}, {"<Leader>e", group = "Explore"}, {"<Leader>f", group = "File"}, {"<Leader>g", group = "Git"}, {"<Leader>gb", group = "Buffer"}, {"<Leader>gh", group = "Hunk"}, {"<Leader>gl", group = "Line"}, {"<Leader>l", group = "Lsp"}, {"<Leader>o", group = "Org"}, {"<Leader>s", group = "Search"}, {"<Leader>t", group = "Tab"}, {"<Leader>v", group = "View"}})
end
return {{"nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "nvim-telescope/telescope-file-browser.nvim"}, init = _1_, config = _2_}, {"stevearc/dressing.nvim", opts = {}}, {"kylechui/nvim-surround", event = "VeryLazy", config = _3_}, {"echasnovski/mini.pairs", event = "VeryLazy", opts = {modes = {insert = true, command = true, terminal = false}, skip_ts = {"string"}, skip_unbalanced = true, markdown = true}, config = _4_, version = false}, {"folke/todo-comments.nvim", dependencies = {"nvim-lua/plenary.nvim"}, opts = {signs = false}, keys = {{"[c", _5_, mode = "n", desc = "Prev todo comment"}, {"]c", _6_, mode = "n", desc = "Next todo comment"}, {"<Leader>st", "<Cmd>TodoTelescope<CR>", mode = "n", desc = "Search todo comment"}}}, {"folke/flash.nvim", event = "VeryLazy", opts = {}, keys = {{"<LocalLeader>aa", _7_, mode = {"n", "o", "x"}, desc = "Flash"}, {"<LocalLeader>al", _8_, mode = {"n", "o", "x"}, desc = "Flash Line"}, {"<LocalLeader>at", _9_, mode = {"n", "o", "x"}, desc = "Flash Treesitter"}, {"<LocalLeader>ar", _10_, mode = "o", desc = "Remote Flash"}, {"<LocalLeader>as", _11_, mode = {"o", "x"}, desc = "Treesitter Search"}, {"<C-S>", _12_, mode = "c", desc = "Toggle Flash Search"}}}, {"folke/which-key.nvim", event = "VeryLazy", opts = {}, config = _13_}}
