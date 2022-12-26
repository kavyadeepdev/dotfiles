-- Setting colorscheme
local colorscheme = "ayu" -- For ayu

-- Colorscheme config
require("ayu").setup({
    mirage = false, -- Set to `true` to use `mirage` variant instead of `dark` for dark background.
    overrides = {}, -- A dictionary of group names, each associated with a dictionary of parameters (`bg`, `fg`, `sp` and `style`) and colors in hex.
})

-- Setting colorscheme
local status, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status then
	print("Colorscheme " .. colorscheme .. " not found.")
	return
end

