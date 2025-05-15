-- [nfnl] fnl/plugins/ui.fnl
local function _1_()
  local icons = require("mini.icons")
  local function _2_()
    icons.mock_nvim_web_devicons()
    return package.loaded("nvim-web-devicons")
  end
  package.preload["nvim-web-devicons"] = _2_
  return nil
end
local function _3_()
  return require("telescope").extensions.notify.notify({})
end
local function _4_()
  return require("notify").dismiss({silent = true, pending = true})
end
return {{"MunifTanjim/nui.nvim", lazy = true}, {"echasnovski/mini.icons", lazy = true, opts = {}, init = _1_}, {"rcarriga/nvim-notify", keys = {{"<Leader>vl", _3_, desc = "View logs"}, {"<Leader>un", _4_, desc = "Dismiss All Notifications"}}}, {"stevearc/dressing.nvim", opts = {}}, {"folke/noice.nvim", event = "VeryLazy", opts = {cmdline = {format = {cmdline = {icon = ">"}, filter = {icon = "$"}, search_down = {icon = "/"}, search_up = {icon = "?"}}}, lsp = {override = {["cmp.entry.get_documentation"] = true, ["vim.lsp.util.convert_input_to_markdown_lines"] = true, ["vim.lsp.util.stylize_markdown"] = true}}, presets = {bottom_search = true, command_palette = true, long_message_to_split = true, lsp_doc_border = false}, routes = {{view = "notify", filter = {event = "msg_showmode", any = {{find = "recording"}}}}, {filter = {event = "notify", find = "No information available"}, opts = {skip = true}}}}}, {"nvim-lualine/lualine.nvim", opts = {options = {theme = "auto", section_separators = "", component_separators = "", icons_enabled = false}, sections = {lualine_a = {"mode"}, lualine_b = {{"diagnostics", sections = {"error", "warn", "info", "hint"}, sources = {"nvim_lsp"}}}, lualine_c = {{"filename", file_status = true, path = 1, shorting_target = 40}}, lualine_x = {"lsp_status", "filesize", "encoding", "fileformat", "filetype"}, lualine_y = {"progress"}, lualine_z = {"location"}}, inactive_sections = {lualine_a = {}, lualine_b = {}, lualine_c = {{"filename", file_status = true, path = 1}}, lualine_x = {"location"}, lualine_y = {}, lualine_z = {}}}}}
