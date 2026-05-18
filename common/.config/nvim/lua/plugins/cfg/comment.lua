return {
	"numToStr/Comment.nvim",
	opts = {},
	lazy = false,
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "python",
			callback = function()
				vim.bo.commentstring = "# %s"
			end,
		})
	end,
}
