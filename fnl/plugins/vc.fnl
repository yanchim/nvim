[{1 :lewis6991/gitsigns.nvim
  :event [:BufReadPre :BufNewFile]
  :opts {:on_attach (fn [buf]
                      (let [gs (require :gitsigns)]
                        (vim.keymap.set :n :<leader>glb #(gs.blame_line {:full true}) {:desc "Blame line"})
                        (vim.keymap.set :n :<leader>glB gs.toggle_current_line_blame {:desc "Toggle line blame"})
                        (vim.keymap.set :n :<leader>gbs gs.stage_buffer {:desc "Stage buffer"})
                        (vim.keymap.set :n :<leader>gbr gs.reset_buffer {:desc "Reset buffer"})
                        (vim.keymap.set :n :<leader>gd gs.diffthis {:desc "Diff this"})
                        (vim.keymap.set :n :<leader>ghs gs.stage_hunk {:desc "Stage hunk"})
                        (vim.keymap.set :n :<leader>ghr gs.reset_hunk {:desc "Reset hunk"})
                        (vim.keymap.set :n "[h" gs.prev_hunk {:desc "Prev hunk"})
                        (vim.keymap.set :n "]h" gs.next_hunk {:desc "Next hunk"})))}}

 {1 :NeogitOrg/neogit
  :dependencies [:nvim-lua/plenary.nvim
                 :sindrets/diffview.nvim
                 :nvim-telescope/telescope.nvim]
  :config #(let [neogit (require :neogit)]
             (vim.keymap.set :n :<leader>gc #(neogit.open [:commit]) {:desc "Open commit popup"})
             (vim.keymap.set :n :<leader>gn neogit.open {:desc "Neogit status"})
             (vim.keymap.set :n :<leader>gg #(neogit.open {:cwd :%:p:h}) {:desc "Current buffer Neogit status"})
             (neogit.setup))}]
