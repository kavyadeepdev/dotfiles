local colorscheme = "ayu"

local color_status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not color_status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

local transparent_status_ok, _ = pcall(require, "transparent")
if not transparent_status_ok then
  return
end
require("transparent").setup{
  enable = true
}

