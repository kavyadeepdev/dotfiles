local opt = vim.opt
local cmd = vim.cmd

-- Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Basic Options
opt.backup = false
opt.swapfile = false
opt.writebackup = false

-- Number Line
opt.number = true

-- Text Display
opt.tabstop = 4 -- Sets tab width
opt.smarttab = true
opt.shiftwidth = 4 -- Sets indentation width
opt.smartindent = true
opt.autoindent = true
opt.showtabline = 2
opt.wrap = true
opt.conceallevel = 0

-- Editor Display
opt.cursorline = true
opt.showmode = false
opt.pumheight = 10
opt.termguicolors = true
opt.splitright = true
opt.splitbelow = true

-- Autocompletion
opt.completeopt = { "menuone", "noselect" }

-- Search
opt.hlsearch = true
opt.ignorecase = true

-- Timings
opt.updatetime = 300

-- Accessibility
opt.clipboard = "unnamedplus"
opt.mouse = "a"

-- Additional Settings
opt.shortmess:append "c"
cmd "set whichwrap+=<,>,[,],h,l" -- Enable movement from last character of one line to first character of next line
cmd [[set iskeyword+=-]] -- Makes a word seperated by - to be considered as one word instead of two

