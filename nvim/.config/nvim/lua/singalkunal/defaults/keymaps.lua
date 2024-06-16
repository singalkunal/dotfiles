-- local comment_utils = require("singalkunal.utils.comment")
local keymap = vim.keymap
local default_opts = { noremap = true, silent = true }


local keymap_set_default= function(modes, lhs, rhs)
    keymap_set_default(modes, lhs, rhs, {});
end

local keymap_set_default = function(modes, lhs, rhs, opts)
    if opts == nil then
        opts = {}
    end
    for k, v in pairs(default_opts) do
        opts[k] = v
    end
    keymap.set(modes, lhs, rhs, opts)
end

-- remap key bindings
keymap_set_default("n", "<leader>pv", vim.cmd.Ex)

keymap_set_default({"v", "x"}, "J", ":m '>+1<CR>gv=gv") -- move current selected lines up 1 line
keymap_set_default({"v", "x"}, "K", ":m '<-2<CR>gv=gv") -- move current selected lines down 1 line

keymap_set_default({ "n", "x" }, "<leader>p", [["0p]], { desc = "paste from yank register" })

keymap_set_default({"v", "x"}, "(", "<Esc>`>a)<Esc>`<i(<Esc>")
keymap_set_default({"v", "x"}, "'", "<Esc>`>a'<Esc>`<i'<Esc>")
keymap_set_default({"v", "x"}, '"', "<Esc>`>a\"<Esc>`<i\"<Esc>")
keymap_set_default({"v", "x"}, "[", "<Esc>`>a]<Esc>`<i[<Esc>")
keymap_set_default({"v", "x"}, "{", "<Esc>`>a}<Esc>`<i{<Esc>")


keymap_set_default("i", "<C-a>", "<Esc>ggVG<CR>") -- select all [INSERT]

-- TO-DO: fix toggle_comment fn
--[=[ 
keymap.set("v", "cc", function()
    comment_utils.toggle_comment()
end, {expr = true})
--]=]

-- Resizing panes
keymap_set_default("n", "<Left>", ":vertical resize +1<CR>")
keymap_set_default("n", "<Right>", ":vertical resize -1<CR>")
keymap_set_default("n", "<Up>", ":resize -1<CR>")
keymap_set_default("n", "<Down>", ":resize +1<CR>")


-- Navigate split panes
keymap_set_default("n", "<C-h>", ":wincmd h<CR>")
keymap_set_default("n", "<C-j>", ":wincmd j<CR>")
keymap_set_default("n", "<C-k>", ":wincmd k<CR>")
keymap_set_default("n", "<C-l>", ":wincmd l<CR>", { buffer = true})

keymap_set_default("n", "<leader>o", "o<Esc>")
keymap_set_default("n", "<leader>O", "O<Esc>")

-- Hack to clear existing netrw buffer's C-l key mapping
-- and replacing it for split pane navigation
vim.cmd [[
    augroup netwr_mapping
        autocmd!
        autocmd filetype netrw lua vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { noremap = true, buffer = true})
    augroup end
]]


