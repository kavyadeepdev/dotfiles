local opt = vim.opt
-- Encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- Basic Options
opt.backup = false
opt.swapfile = false
opt.writebackup = false
opt.autoread = true

-- Number Line
opt.number = true
opt.signcolumn = "yes"

-- Text Display
opt.tabstop = 4 -- Sets tab width
opt.smarttab = true
opt.shiftwidth = 4 -- Sets indentation width
opt.smartindent = true
opt.autoindent = true
opt.showtabline = 2
opt.wrap = true
opt.breakindent = true
opt.conceallevel = 0

-- Editor Display
opt.cursorline = true
opt.showmode = false
opt.pumheight = 10
opt.termguicolors = true
opt.background = "dark"
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
opt.backspace = "indent,eol,start"
opt.clipboard = "unnamedplus"
opt.mouse = "a"

-- Additional Settings
opt.shortmess:append "c"

-- Auto-reload files changed on disk (e.g. by AI agents / external tools)
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

