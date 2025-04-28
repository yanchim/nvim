-- [nfnl] fnl/plugins/markup.fnl
return {{"chomosuke/typst-preview.nvim", build = ":TypstPreviewUpdate", ft = "typst", opts = {dependencies_bin = {["typst-preview"] = "tinymist", websocat = "websocat"}}}, {"nvim-orgmode/orgmode", event = "VeryLazy", ft = "org", opts = {org_agenda_files = "~/org/**/*", org_default_notes_file = "~/org/notes.org"}}}
