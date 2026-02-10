local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Alias to shorten name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader  key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
-- Normal_mode = "n",
-- Insert_mode = "i",
-- Visual_mode = "v",
-- Visual_Block mode = "x",
-- Term_mode = "t",
-- Command_mode = "c"

-- Normal mode --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

--keymap("n", "<leader>e", ":Lex 30<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +1<CR>", opts)
keymap("n", "<C-Down>", ":resize -1<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -1<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +1<CR>", opts)

-- Split options
keymap("n", "<leader>sv", "<C-w>v", opts) -- vertical split
keymap("n", "<leader>sh", "<C-w>s", opts) -- horizontal split
keymap("n", "<leader>se", "<C-w>=", opts) -- equalize
keymap("n", "<leader>sx", "<cmd>close<CR>", opts) -- close split

-- Navigate Buffer
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)


-- Insert mode --
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move selected text up/down and keep selection
keymap("v", "<S-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<S-k>", ":m '<-2<CR>gv=gv", opts)

-- Paste over selection without overwriting yank register
keymap("v", "p", '"_dP', opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- In terminal mode, make Shift-h / Shift-l switch buffers instead of typing H/L
keymap("t", "<S-l>", "<C-\\><C-n>:bnext<CR>", term_opts)
keymap("t", "<S-h>", "<C-\\><C-n>:bprevious<CR>", term_opts) 

