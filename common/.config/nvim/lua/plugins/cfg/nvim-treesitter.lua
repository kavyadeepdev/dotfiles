local config = function()
	-- Runtimepath Fix
	local parser_path = vim.fn.stdpath("data") .. "/site"
	vim.opt.rtp:append(parser_path)

	-- Treesitter Highlighting
	vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
		group = vim.api.nvim_create_augroup("TsHighlight", {}),
		callback = function()
			local ok, _ = pcall(vim.treesitter.start)
			if not ok then
				-- Fallback or silent failure if parser not available
			end
		end,
	})

	-- Enable Indentation
	vim.api.nvim_create_autocmd("FileType", {
		group = vim.api.nvim_create_augroup("TsIndent", {}),
		callback = function()
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	})

	-- Automatic Parser Management
	local ensure_installed = {
		"c", "json", "javascript", "typescript", "tsx", "yaml", "html",
		"css", "markdown", "svelte", "graphql", "bash", "lua", "vim",
		"dockerfile", "gitignore", "vimdoc", "query",
	}

	-- Use a small delay or defer to ensure plugin is fully loaded before installing
	vim.defer_fn(function()
		local ok, ts = pcall(require, "nvim-treesitter")
		if not ok then return end

		local installed = ts.get_installed()
		local to_install = {}
		for _, p in ipairs(ensure_installed) do
			if not vim.tbl_contains(installed, p) then
				table.insert(to_install, p)
			end
		end

		if #to_install > 0 then
			ts.install(to_install)
		end
	end, 100)
end

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	config = config,
}
