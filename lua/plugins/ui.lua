-- [nfnl] Compiled from fnl/plugins/ui.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local lsp = autoload("core.lsp")
local function lsp_connection()
  local message = lsp["get-progress-message"]()
  if ((message.status == "begin") or (message.status == "report")) then
    return (message.msg .. " : " .. message.percent .. "%% \239\130\150")
  elseif (message.status == "end") then
    return "\239\131\136"
  elseif ((message.status == "") and not vim.tbl_isempty(vim.lsp.get_clients({bufnr = vim.api.nvim_get_current_buf()}))) then
    return "\239\131\136"
  else
    return "\239\130\150"
  end
end
local function _3_()
  local icons = require("mini.icons")
  local function _4_()
    icons.mock_nvim_web_devicons()
    return package.loaded("nvim-web-devicons")
  end
  package.preload["nvim-web-devicons"] = _4_
  return nil
end
local function _5_()
  return require("telescope").extensions.notify.notify({})
end
local function _6_()
  return require("notify").dismiss({silent = true, pending = true})
end
local function _7_()
  local noice = require("noice")
  return noice.setup({cmdline = {format = {cmdline = {icon = ">"}, filter = {icon = "$"}, help = {icon = "H"}, search_down = {icon = "/"}, search_up = {icon = "?"}}}, lsp = {override = {["cmp.entry.get_documentation"] = true, ["vim.lsp.util.convert_input_to_markdown_lines"] = true, ["vim.lsp.util.stylize_markdown"] = true}}, presets = {bottom_search = true, command_palette = true, long_message_to_split = true, lsp_doc_border = false}, routes = {{view = "notify", filter = {event = "msg_showmode", any = {{find = "recording"}}}}}})
end
local function _8_()
  local lualine = require("lualine")
  return lualine.setup({options = {theme = "auto", section_separators = "", component_separators = "", icons_enabled = false}, sections = {lualine_a = {"mode"}, lualine_b = {{"diagnostics", sections = {"error", "warn", "info", "hint"}, sources = {"nvim_lsp"}}}, lualine_c = {{"filename", file_status = true, path = 1, shorting_target = 40}}, lualine_x = {{lsp_connection}, "filesize", "encoding", "fileformat", "filetype"}, lualine_y = {"progress"}, lualine_z = {"location"}}, inactive_sections = {lualine_a = {}, lualine_b = {}, lualine_c = {{"filename", file_status = true, path = 1}}, lualine_x = {"location"}, lualine_y = {}, lualine_z = {}}})
end
return {{"MunifTanjim/nui.nvim", lazy = true}, {"echasnovski/mini.icons", lazy = true, opts = {}, init = _3_}, {"rcarriga/nvim-notify", keys = {{"<Leader>vl", _5_, desc = "View logs"}, {"<Leader>un", _6_, desc = "Dismiss All Notifications"}}}, {"stevearc/dressing.nvim", opts = {}}, {"folke/noice.nvim", event = "VeryLazy", opts = {}, config = _7_}, {"nvim-lualine/lualine.nvim", config = _8_}}
