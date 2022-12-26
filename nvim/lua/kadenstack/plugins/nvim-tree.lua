local status, nvimtree = pcall(require, "nvim-tree")
if not status then
	return
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true

vim.cmd([[ highlight NvimTreeIndentMarker guifg=#F9AF4F ]])

nvimtree.setup({
	sort_by = "case_sensitive",
	view = {
		adaptive_size = true,
		mappings = {
			list = {
				{ key = "u", action = "dir_up" },
			},
		},
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		}
	}
})
