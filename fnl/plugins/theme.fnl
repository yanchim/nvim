[{1 :folke/tokyonight.nvim
  :lazy false
  :priority 1000
  :config (fn []
            (let [theme (require :tokyonight) ]
              (theme.setup {:style :night :terminal_colors true})
              (vim.cmd "colorscheme tokyonight")))}]
