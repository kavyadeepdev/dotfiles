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
		view = {
			side = "left",
		},
		filters = {
			dotfiles = false,
		},
		actions = {
			open_file = {
				quit_on_open = true,
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
