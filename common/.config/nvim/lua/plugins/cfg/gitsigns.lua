return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "│" },
			change = { text = "│" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true,
		numhl = false,
		linehl = false,
		word_diff = false,
		watch_gitdir = { follow_files = true },
		auto_attach = true,
		attach_to_untracked = true,
		current_line_blame = false,
		sign_priority = 6,
		update_debounce = 100,
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns
			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
			end
			map("n", "]h", gs.next_hunk, "Next hunk")
			map("n", "[h", gs.prev_hunk, "Prev hunk")
			map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
			map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
			map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
			map("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, "Blame line")
		end,
	},
}
