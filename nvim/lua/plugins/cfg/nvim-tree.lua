return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	config = {
		sort_by = "case_sensitive",
		-- view = {
		-- 	adaptive_size = true,
		-- 	mappings = {
		-- 		list = {
		-- 			{ key = "u", action = "dir_up" },
		-- 		},
		-- 	},
		-- },
		renderer = {
			group_empty = true,
		},
		filters = {
			dotfiles = false,
		},
		actions = {
			open_file = {
				window_picker = {
					enable = false,
				},
			},
		},
	},
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
}
