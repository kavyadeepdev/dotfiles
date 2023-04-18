-- Basic Settings
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

--Remap Space as Leader Key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

--   Basic Settings --
keymap("n", "<leader>nh", ":nohl<CR>", opts) -- Clear search
keymap("n", "x", '"_x', opts) -- Set pressing x to not copy to clipboard

-- Normal --
-- Split window
keymap("n", "<leader>sv", "<C-w>v", opts) -- Split vertically
keymap("n", "<leader>sh", "<C-w>s", opts) -- Split horizontally
keymap("n", "<leader>sr", "<C-w>=", opts) -- Reset window width and height
keymap("n", "<leader>sx", ":close<CR>", opts) -- Close window
-- Navigate windows
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<leader>sm", ":MaximizerToggle<CR>", opts) -- Maximize window (plugin)
-- Resize windows
keymap("n", "<C-S-k>", ":resize -2<CR>", opts)
keymap("n", "<C-S-j>", ":resize +2<CR>", opts)
keymap("n", "<C-S-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-S-l>", ":vertical resize +2<CR>", opts)
-- Open tab
keymap("n", "<leader>tn", ":tabnew<CR>", opts) -- New tab
keymap("n", "<leader>tx", ":tabclose<CR>", opts) -- Close tab
-- Navigate tabs
keymap("n", "<S-l>", ":tabn<CR>", opts)
keymap("n", "<S-h>", ":tabN<CR>", opts)
-- Open buffer
keymap("n", "<leader>bo", ":new<CR>", opts) -- Open buffer
keymap("n", "<leader>bx", ":bd<CR>", opts) -- Close buffer (don't force)
keymap("n", "<leader>bf", ":bd!<CR>", opts) -- Close buffer (don't force)
keymap("n", "<leader>br", ":bw<CR>", opts) -- Close buffer and remove from buffer list
-- Navigate buffers
keymap("n", "<S-j>", ":bnext<CR>", opts)
keymap("n", "<S-k>", ":bprevious<CR>", opts)
keymap("n", "<S-x>", ":Bdelete!<CR>", opts)
-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
-- Toggle file explorer
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
-- ToggleTerm
keymap("n", "<C-t>", ":ToggleTerm<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Telescope

keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
