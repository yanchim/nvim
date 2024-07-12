-- [nfnl] Compiled from fnl/plugins/basic.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  do
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>bb", builtin.buffers, {noremap = true, desc = "Switch buffer"})
    vim.keymap.set("n", "<C-x>b", builtin.buffers, {noremap = true, desc = "Switch buffer"})
    vim.keymap.set("n", "<leader>fc", "<Cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", {noremap = true, desc = "Open file browser with current buffer"})
    vim.keymap.set("n", "<leader>ff", "<Cmd>Telescope file_browser<CR>", {noremap = true, desc = "Open file browser"})
    vim.keymap.set("n", "<C-x><C-f>", "<Cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", {noremap = true, desc = "Find file"})
    vim.keymap.set("n", "<leader>gt", builtin.git_status, {noremap = true, desc = "Git status"})
    vim.keymap.set("n", "<leader>sc", builtin.grep_string, {noremap = true, desc = "Find string under cursor"})
    vim.keymap.set("n", "<leader>sf", builtin.find_files, {noremap = true, desc = "Find file"})
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, {noremap = true, desc = "Grep"})
    vim.keymap.set("n", "<leader>sr", builtin.oldfiles, {noremap = true, desc = "Find recent buffer"})
    vim.keymap.set("n", "<leader>ss", builtin.current_buffer_fuzzy_find, {noremap = true, desc = "Search buffer"})
    vim.keymap.set("n", "<leader>v:", builtin.commands, {noremap = true, desc = "Commands"})
    vim.keymap.set("n", "<leader>vc", builtin.colorscheme, {noremap = true, desc = "Colorscheme"})
    vim.keymap.set("n", "<leader>vh", builtin.help_tags, {noremap = true, desc = "Help tags"})
    vim.keymap.set("n", "<leader>vk", builtin.keymaps, {noremap = true, desc = "Keymaps"})
    vim.keymap.set("n", "<leader>vm", builtin.marks, {noremap = true, desc = "Marks"})
    vim.keymap.set("n", "<leader>vo", builtin.vim_options, {noremap = true, desc = "Options"})
    vim.keymap.set("n", "<leader>vr", builtin.registers, {noremap = true, desc = "Registers"})
    vim.keymap.set("n", "<leader>vt", vim.cmd.TSContextToggle, {noremap = true, desc = "Treesitter context"})
  end
  local telescope = require("telescope")
  return telescope.load_extension("file_browser")
end
local function _2_()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local fb_actions = require("telescope._extensions.file_browser.actions")
  return telescope.setup({defaults = {file_ignore_patterns = {"node_modules"}, vimgrep_arguments = {"rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--iglob", "!.git", "--hidden"}}, pickers = {find_files = {find_command = {"fd", "--full-path", "--color=never"}}, live_grep = {mappings = {i = {["<C-f>"] = actions.to_fuzzy_refine}}}, colorscheme = {enable_preview = true}}, extensions = {file_browser = {collapse_dirs = true, mappings = {n = {g = fb_actions.toggle_respect_gitignore}, i = {["<C-g>"] = fb_actions.toggle_respect_gitignore}}}}})
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
  vim.o.timeout = true
  vim.o.timeoutlen = 500
  return nil
end
local function _14_()
  local wk = require("which-key")
  local function _15_()
    return (require("which-key")).show({global = false})
  end
  return wk.add({{"<leader>?", _15_, desc = "Buffer local keymaps"}, {"<leader>b", group = "Buffer"}, {"<leader>c", group = "Code"}, {"<leader>e", group = "Explore"}, {"<leader>f", group = "File"}, {"<leader>g", group = "Git"}, {"<leader>gb", group = "Buffer"}, {"<leader>gh", group = "Hunk"}, {"<leader>gl", group = "Line"}, {"<leader>l", group = "Lsp"}, {"<leader>o", group = "Org"}, {"<leader>s", group = "Search"}, {"<leader>t", group = "Tab"}, {"<leader>v", group = "View"}})
end
return {{"nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "nvim-telescope/telescope-file-browser.nvim"}, init = _1_, config = _2_}, {"stevearc/dressing.nvim", opts = {}}, {"kylechui/nvim-surround", event = "VeryLazy", config = _3_}, {"echasnovski/mini.pairs", event = "VeryLazy", opts = {modes = {insert = true, command = true, terminal = false}, skip_ts = {"string"}, skip_unbalanced = true, markdown = true}, config = _4_, version = false}, {"folke/todo-comments.nvim", dependencies = {"nvim-lua/plenary.nvim"}, opts = {signs = false}, keys = {{"[c", _5_, mode = "n", desc = "Prev todo comment"}, {"]c", _6_, mode = "n", desc = "Next todo comment"}, {"<leader>st", "<cmd>TodoTelescope<CR>", mode = "n", desc = "Search todo comment"}}}, {"folke/flash.nvim", event = "VeryLazy", opts = {}, keys = {{"<localleader>aa", _7_, mode = {"n", "o", "x"}, desc = "Flash"}, {"<localleader>al", _8_, mode = {"n", "o", "x"}, desc = "Flash Line"}, {"<localleader>at", _9_, mode = {"n", "o", "x"}, desc = "Flash Treesitter"}, {"<localleader>ar", _10_, mode = "o", desc = "Remote Flash"}, {"<localleader>as", _11_, mode = {"o", "x"}, desc = "Treesitter Search"}, {"<C-s>", _12_, mode = "c", desc = "Toggle Flash Search"}}}, {"folke/which-key.nvim", event = "VeryLazy", init = _13_, opts = {}, config = _14_}}
