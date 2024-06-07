local keymap = vim.keymap

-- remap key bindings
keymap.set("n", "<leader>pv", vim.cmd.Ex)

keymap.set({"v", "x"}, "J", ":m '>+1<CR>gv=gv") -- move current selected lines up 1 line
keymap.set({"v", "x"}, "K", ":m '<-2<CR>gv=gv") -- move current selected lines down 1 line

keymap.set({ "n", "x" }, "<leader>p", [["0p]], { desc = "paste from yank register" })


-- Resizing panes
-- keymap.set("n", "<Left>", ":vertical resize +1<CR>")
-- keymap.set("n", "<Right>", ":vertical resize -1<CR>")
-- keymap.set("n", "<Up>", ":resize -1<CR>")
-- keymap.set("n", "<Down>", ":resize +1<CR>")
