-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- normal mode
-- keymap.set("n", "<leader>`", "<cmd>Ex<cr>")
keymap.set("n", "q", "<cmd>wq<cr>") -- quit
keymap.set("n", "J", "mzJ`z")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("n", "<C-a>", "ggVG") -- select all
keymap.set("n", "<C-s>", ":w<CR>") -- quick save
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>") -- tmux fzf
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

keymap.set("n", "<leader>Y", [["+Y]])
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- insert mode
-- keymap.set("i", "<C-h>", "<Left>")
-- keymap.set("i", "<C-j>", "<Down>")
-- keymap.set("i", "<C-k>", "<Up>")
-- keymap.set("i", "<C-l>", "<Right>")

-- visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- idk
keymap.set("x", "<leader>p", [["_dP]])

-- combine normal and visual
keymap.set({ "v", "i" }, "<C-c>", "<Esc>")
keymap.set({ "n", "v" }, "<leader>d", [["_d]])
keymap.set({ "n", "v" }, ";", ":")
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- end keymap
