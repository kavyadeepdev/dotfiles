return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = {
		"williamboman/mason.nvim",
	},
	opts = {
		ensure_installed = {
			"luacheck",
			"stylua",
			"flake8",
			"black",
			"eslint_d",
			"prettierd",
			"fixjson",
			"shellcheck",
			"shfmt",
			"markdownlint",
			"hadolint",
			"fd",
		},
		auto_install = true,
	},
}
