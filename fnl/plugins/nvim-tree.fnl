[{1 :nvim-tree/nvim-tree.lua
  :dependencies [:nvim-tree/nvim-web-devicons]
  :lazy false
  :init (fn []
          ; Use nvim-tree to replace netrw.
          (set vim.g.loaded_netrw 1)
          (set vim.g.loaded_netrwPlugin 1))
  :config (fn []
            (let [nvimtree (require :nvim-tree)]
              ; Keybind.
              (vim.keymap.set :n :<leader>ee :<cmd>NvimTreeToggle<CR> {:desc "Toggle file explorer" })
              (vim.keymap.set :n :<leader>ef :<cmd>NvimTreeFindFileToggle<CR> {:desc "Toggle file explorer on current buffer" })
              (vim.keymap.set :n :<leader>ec :<cmd>NvimTreeCollapse<CR> {:desc "Collapse file explorer" })
              (vim.keymap.set :n :<leader>er :<cmd>NvimTreeRefresh<CR> {:desc "Toggle file explorer on current buffer" })

              (nvimtree.setup)))}]
