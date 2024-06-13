-- [nfnl] Compiled from fnl/plugins/common.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "<localleader><localleader>", builtin.commands, {noremap = true, desc = "Commands"})
  vim.keymap.set("n", "<leader>bb", builtin.buffers, {noremap = true, desc = "Find buffer"})
  vim.keymap.set("n", "<leader>sc", builtin.grep_string, {noremap = true, desc = "Find string under cursor"})
  vim.keymap.set("n", "<leader>sf", builtin.find_files, {noremap = true, desc = "Fd file"})
  vim.keymap.set("n", "<leader>sg", builtin.live_grep, {noremap = true, desc = "Ripgrep"})
  vim.keymap.set("n", "<leader>sr", builtin.oldfiles, {noremap = true, desc = "Find recent buffer"})
  vim.keymap.set("n", "<leader>tt", builtin.colorscheme, {noremap = true, desc = "Colorscheme"})
  vim.keymap.set("n", "<leader>tq", builtin.quickfix, {noremap = true, desc = "Quickfix"})
  vim.keymap.set("n", "<leader>tl", builtin.quickfix, {noremap = true, desc = "Loclist"})
  vim.keymap.set("n", "<leader>tj", builtin.quickfix, {noremap = true, desc = "Jumplist"})
  vim.keymap.set("n", "<leader>gt", builtin.git_status, {noremap = true, desc = "Git status"})
  vim.keymap.set("n", "<leader>fb", builtin.buffers, {noremap = true, desc = "Find buffer"})
  vim.keymap.set("n", "<leader>ff", builtin.find_files, {noremap = true, desc = "Find file"})
  vim.keymap.set("n", "<leader>fg", builtin.live_grep, {noremap = true, desc = "Find grep"})
  vim.keymap.set("n", "<leader>fc", builtin.grep_string, {noremap = true, desc = "Find string under cursor"})
  vim.keymap.set("n", "<leader>fb", builtin.buffers, {noremap = true, desc = "Find buffer"})
  vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {noremap = true, desc = "Find recent buffer"})
  vim.keymap.set("n", "<leader>fh", builtin.help_tags, {noremap = true, desc = "Find help"})
  vim.keymap.set("n", "<leader>ee", ":Telescope file_browser<CR>", {noremap = true, desc = "Open file browser"})
  return vim.keymap.set("n", "<leader>ef", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", {noremap = true, desc = "Open file browser with current buffer"})
end
local function _2_()
  local telescope = require("telescope")
  telescope.setup({defaults = {file_ignore_patterns = {"node_modules"}, vimgrep_arguments = {"rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case", "--iglob", "!.git", "--hidden"}}, pickers = {find_files = {find_command = {"fd", "--full-path", "--color=never"}}}, extensions = {file_browser = {collapse_dirs = true}}})
  return telescope.load_extension("file_browser")
end
local function _3_()
  local surround = require("nvim-surround")
  return surround.setup()
end
local function _4_()
  return (require("flash")).jump()
end
local function _5_()
  return (require("flash")).treesitter()
end
local function _6_()
  return (require("flash")).remote()
end
local function _7_()
  return (require("treesitter_search")).remote()
end
local function _8_()
  return (require("flash")).toggle()
end
local function _9_()
  vim.o.timeout = true
  vim.o.timeoutlen = 500
  return nil
end
local function _10_()
  local wk = require("which-key")
  return wk.register({["<leader>c"] = {name = "Code"}, ["<leader>e"] = {name = "Explore"}, ["<leader>f"] = {name = "Find"}, ["<leader>g"] = {name = "Git", b = {name = "Buffer"}, h = {name = "Hunk"}, l = {name = "Line"}}, ["<leader>s"] = {name = "Search"}, ["<leader>t"] = {name = "Toggle"}})
end
return {{"nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "nvim-telescope/telescope-file-browser.nvim"}, init = _1_, config = _2_}, {"stevearc/dressing.nvim", opts = {}}, {"tummetott/unimpaired.nvim", event = "VeryLazy", opts = {}}, {"kylechui/nvim-surround", event = "VeryLazy", config = _3_}, {"folke/flash.nvim", event = "VeryLazy", opts = {}, keys = {{"<localleader>aa", _4_, mode = {"n", "o", "x"}, desc = "Flash"}, {"<localleader>at", _5_, mode = {"n", "o", "x"}, desc = "Flash Treesitter"}, {"<localleader>ar", _6_, mode = "o", desc = "Remote Flash"}, {"<localleader>as", _7_, mode = {"o", "x"}, desc = "Treesitter Search"}, {"<C-s>", _8_, mode = "c", desc = "Toggle Flash Search"}}}, {"folke/which-key.nvim", event = "VeryLazy", init = _9_, opts = {}, config = _10_}}
