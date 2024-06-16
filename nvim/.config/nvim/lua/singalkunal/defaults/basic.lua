local api = vim.api
local g = vim.g
local opt = vim.opt
local env = vim.env

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = "\\"

api.nvim_set_hl(0, "Normal", { bg = "none" })
api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.mouse = "a" --Enable mouse mode
opt.clipboard:append "unnamedplus" -- Access system clipboard

opt.tabstop = 4 -- show existing tab with 4 spaces width
opt.softtabstop = 4
opt.shiftwidth = 4 -- when indenting with '>', use 4 spaces width
opt.expandtab = true -- use spaces instead of tab to indent
opt.breakindent = true

-- opt.termguicolors = true -- Enable colors in terminal
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case

-- persist undo even in case of restart session
opt.undodir = env.HOME .. "/.config/nvim/undodir"
opt.undofile = true

opt.scrolloff = 8
opt.colorcolumn = "80"

-- set path for native file search like :find
opt.path:append "**" -- add all subdirectories of working direc
opt.wildignorecase = true

-- ignore directories for file search
opt.wildignore:append "**/.git/*"
opt.wildignore:append "**/build/*"

opt.fillchars:append "vert:║" -- character for vertical pane split separator

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]
