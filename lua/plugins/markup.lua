-- [nfnl] Compiled from fnl/plugins/markup.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local org = require("orgmode")
  return org.setup({org_agenda_files = "~/org/**/*", org_default_notes_file = "~/org/notes.org"})
end
return {{"nvim-orgmode/orgmode", event = "VeryLazy", ft = {"org"}, config = _1_}}
