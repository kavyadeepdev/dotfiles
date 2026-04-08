local opts = {
	ensure_installed = {
		"efm",
		"lua_ls",
		"clangd",
		"cmake",
		"rust_analyzer",
		"gopls",
		"html",
		"cssls",
		"tailwindcss",
		"jsonls",
		"pyright",
		"ts_ls",
		"bashls",
		"emmet_ls",
		"astro",
		"asm_lsp",
		"dockerls",
	},
	automatic_installation = true,
}

return {
	"williamboman/mason-lspconfig.nvim",
	opts = opts,
	event = "BufReadPre",
	dependencies = {
		"williamboman/mason.nvim",
	},
}

