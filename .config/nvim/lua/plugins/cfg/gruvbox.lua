return {
	"ellisonleao/gruvbox.nvim",
	name = "gruvbox",
	lazy = true,
	priority = 1000,
	opts = ...,
	config = function()
		vim.o.background = "dark"
		vim.cmd("colorscheme gruvbox")
	end,
}
