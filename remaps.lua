-- because i like it
vim.g.mapleader = ","

-- buffer navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- I work on files with long lines (weird data formats, latex, etc), so i remap this so that i scroll per buffer line and not per line.
vim.keymap.set("n", "j", "gj", {silent = true})
vim.keymap.set("n", "k", "gk", {silent = true})

-- Ctrl+Backspace functionality
vim.keymap.set("i", "<C-BS>", "<C-w>")
vim.keymap.set("i", "<C-h>", "<C-w>")

-- Go a buffer back
vim.keymap.set("n", "gb", ":bprev<Enter>", {silent=true})
