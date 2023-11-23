-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- normal mode
-- keymap.set("n", "<leader>`", "<cmd>Ex<cr>")
keymap.set("n", "q", "<cmd>wq<cr>", { desc = "Quit Save" }) -- quit
keymap.set("n", "J", "mzJ`z")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("n", "<C-a>", "ggVG") -- select all
keymap.set("n", "<C-s>", ":w<CR>") -- quick save
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>") -- tmux fzf
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line" })
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename a word" })

-- insert mode
-- keymap.set("i", "<C-h>", "<Left>")
-- keymap.set("i", "<C-j>", "<Down>")
-- keymap.set("i", "<C-k>", "<Up>")
-- keymap.set("i", "<C-l>", "<Right>")
-- undo
-- undo
-- undo
-- undo
-- undo
-- undo
-- visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>")

-- idk
-- test
-- test
keymap.set("x", "<leader>p", [["_dP]], { desc = "Paster deleted registery" })

-- combine normal and visual
keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line" })
keymap.set({ "v", "i" }, "<C-c>", "<Esc>")
keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to registery" })
keymap.set({ "n", "v" }, ";", ":")
keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy With Visual Mode" })
-- end keymap
