local config = function()
	require("nvim-treesitter.configs").setup({
		highlight = { enable = true },
		indent = { enable = true },
		autotag = { enable = true },
		ensure_installed = {
			"c",
			"json",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"html",
			"css",
			"markdown",
			"svelte",
			"graphql",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
		},
		auto_install = true,
		sync_install = false,
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	config = config,
}
