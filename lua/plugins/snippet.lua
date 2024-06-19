-- [nfnl] Compiled from fnl/plugins/snippet.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  if vim.snippet.active({direction = 1}) then
    local function _2_()
      return vim.snippet.jump(1)
    end
    return vim.schedule(_2_)
  else
    return "<C-K>"
  end
end
local function _4_()
  local function _5_()
    return vim.snippet.jump(1)
  end
  return vim.schedule(_5_)
end
local function _6_()
  if vim.snippet.active({direction = -1}) then
    local function _7_()
      return vim.snippet.jump(-1)
    end
    return vim.schedule(_7_)
  else
    return "<C-J>"
  end
end
return {{"garymjr/nvim-snippets", event = "InsertEnter", opts = {}, keys = {{"<C-K>", _1_, expr = true, silent = true, mode = "i"}, {"<C-L>", _4_, expr = true, silent = true, mode = {"i", "s"}}, {"<C-J>", _6_, expr = true, silent = true, mode = {"i", "s"}}}}}
