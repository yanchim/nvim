-- [nfnl] Compiled from fnl/core/gui.fnl by https://github.com/Olical/nfnl, do not edit.
if vim.g.neovide then
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
  local function set_ime(args)
    if (args.event):match("Enter$") then
      vim.g.neovide_input_ime = true
      return nil
    else
      vim.g.neovide_input_ime = false
      return nil
    end
  end
  local ime_input = vim.api.nvim_create_augroup("ime_input", {clear = true})
  vim.api.nvim_create_autocmd({"InsertEnter", "InsertLeave"}, {group = ime_input, pattern = "*", callback = set_ime})
  vim.api.nvim_create_autocmd({"CmdlineEnter", "CmdlineLeave"}, {group = ime_input, pattern = "[/\\?]", callback = set_ime})
else
end
return {}
