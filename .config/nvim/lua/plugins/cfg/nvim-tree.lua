return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	opts = {
		filters = {
			dotfiles = false,
			custom = { "^\\.git$" },
		},
		sync_root_with_cwd = true,
		respect_buf_cwd = true,
		update_focused_file = {
			enable = true,
			update_root = true,
		},
		view = {
			side = "right",
			width = 45,
			adaptive_size = true,
		},
		git = {
			enable = true,
			ignore = false,
		},
		renderer = {
			root_folder_label = false,
			icons = {
				glyphs = {
					git = {
						unstaged = "✗",
						staged = "✓",
						unmerged = "",
						renamed = "➜",
						untracked = "★",
						deleted = "",
						ignored = "◌",
					},
				},
			},
		},
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
}
