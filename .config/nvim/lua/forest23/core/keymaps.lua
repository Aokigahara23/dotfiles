-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- General Keymaps -------------------

-- clear search highlights
keymap.set("n", "<leader>ch", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
keymap.set("n", "<C-Down>", "<PageDown>", { desc = "Scroll down one page" })
keymap.set("n", "<C-Up>", "<PageUp>", { desc = "Scroll up one page" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- move visual blocks
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- window management
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- tab management
keymap.set("n", "<C-t>", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<C-w>", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<C-Right>", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<C-Left>", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab

-- window navigation
keymap.set("n", "<M-Left>", "<C-w><C-h>", { desc = "Move focus to the left window" })
keymap.set("n", "<M-Right>", "<C-w><C-l>", { desc = "Move focus to the right window" })
keymap.set("n", "<M-Down>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
keymap.set("n", "<M-Up>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- FIXME: Bind resize
-- resize windows
-- keymap.set("n", "<M-+>", [[<cmd>vertical resize +2<cr>]]) -- make the window biger vertically
-- keymap.set("n", "<M-Left>", [[<cmd>vertical resize -2<cr>]]) -- make the window smaller vertically
-- keymap.set("n", "<M-Up>", [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally by pressing shift and =
-- keymap.set("n", "<M-Down>", [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally by pressing shift and -
