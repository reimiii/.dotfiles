require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>") -- tmux fzf
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local builtin = require('telescope.builtin')
map('n', '<A-f>', builtin.find_files, {})
map('n', '<leader>fg', builtin.live_grep, {})
map('n', '<leader>fb', builtin.buffers, {})
map('n', '<leader>fh', builtin.help_tags, {})
