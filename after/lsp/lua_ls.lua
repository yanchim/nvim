return {
  on_attach = function(client)
    -- Reduce very long list of triggers for better 'mini.completion' experience
    client.server_capabilities.completionProvider.triggerCharacters = {
      '.',
      ':',
      '#',
      '(',
    }

    -- Use this function to define buffer-local mappings and behavior that depend
    -- on attached client or only makes sense if there is language server attached.
  end,
  -- LuaLS Structure of these settings comes from LuaLS, not Neovim
  settings = {
    Lua = {
      -- Define runtime properties. Use 'LuaJIT', as it is built into Neovim.
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },

      -- Make the server aware of Neovim runtime files.
      workspace = {
        -- Don't analyze code from submodules
        ignoreSubmodules = true,
        -- Add Neovim's methods for easier code writing
        library = {
          vim.env.VIMRUNTIME,
          -- Add additional paths here.
          '${3rd}/luv/library',
          -- '${3rd}/busted/library'
        },
        -- Or pull in all of 'runtimepath'.
        -- NOTE: this is a lot slower and will cause issues when working on
        -- your own configuration.
        -- See https://github.com/neovim/nvim-lspconfig/issues/3189
        -- library = {
        --   vim.api.nvim_get_runtime_file('', true),
        -- }
      },
    },
  },
}
