local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.lsp").diagnostic_signs

local config = function()
	-- require("neoconf").setup({})
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local lspconfig = require("lspconfig")

	for type, icon in pairs(diagnostic_signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- lua
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = { -- custom settings for lua
			Lua = {
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})

	-- C/C++
	lspconfig.clangd.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = {
			"clangd",
			"--offset-encoding=utf-16",
			"--clang-tidy",
		},
	})

	-- CMake & Makefile
	lspconfig.cmake.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = {
			"cmake-language-server",
		},
		filetypes = {
			"cmake",
		},
		init_options = {
			buildDirectory = "build",
		},
		root_dir = lspconfig.util.root_pattern("CMakePresets.json", "CTestConfig.cmake", ".git", "build", "cmake"),
		single_file_support = true,
	})

	-- rust
	lspconfig.rust_analyzer.setup({
		capabilities = {
			experimental = {
				serverStatusNotification = true,
			},
		},
		on_attach = on_attach,
		settings = {
			["rust-analyzer"] = {
				diagnostics = {
					enable = false,
				},
			},
		},
		cmd = { "rust-analyzer" },
		filetypes = { "rust" },
		root_dir = lspconfig.util.root_pattern("Cargo.toml", "rust-project.json"),
		single_file_support = true,
	})

	-- html
	local html_capabilities = vim.lsp.protocol.make_client_capabilities()
	html_capabilities.textDocument.completion.completionItem.snippetSupport = true
	lspconfig.html.setup({
		capabilities = html_capabilities,
		on_attach = on_attach,
		cmd = { "vscode-html-language-server", "--stdio" },
		filetypes = { "html", "templ" },
		init_options = {
			configurationSection = { "html", "css", "javascript" },
			embeddedLanguages = {
				css = true,
				javascript = true,
			},
			provideFormatter = true,
		},
		settings = {},
		single_file_support = true,
	})

	-- css
	lspconfig.cssls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = { "vscode-css-language-server", "--stdio" },
		filetypes = { "css", "scss", "less" },
		init_options = {
			provideFormatter = true,
		},
		-- root_dir = lspconfig.root_pattern("package.json", ".git"),
		settings = {
			css = {
				validate = true,
			},
			less = {
				validate = true,
			},
			scss = {
				validate = true,
			},
		},
		single_file_support = true,
	})

	-- tailwindcss
	lspconfig.tailwindcss.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = { "tailwindcss-language-server", "--stdio" },
		filetypes = {
			"aspnetcorerazor",
			"astro",
			"astro-markdown",
			"blade",
			"clojure",
			"django-html",
			"htmldjango",
			"edge",
			"eelixir",
			"elixir",
			"ejs",
			"erb",
			"eruby",
			"gohtml",
			"gohtmltmpl",
			"haml",
			"handlebars",
			"hbs",
			"html",
			"html-eex",
			"heex",
			"jade",
			"leaf",
			"liquid",
			"markdown",
			"mdx",
			"mustache",
			"njk",
			"nunjucks",
			"php",
			"razor",
			"slim",
			"twig",
			"css",
			"less",
			"postcss",
			"sass",
			"scss",
			"stylus",
			"sugarss",
			"javascript",
			"javascriptreact",
			"reason",
			"rescript",
			"typescript",
			"typescriptreact",
			"vue",
			"svelte",
			"templ",
		},
		init_options = {
			userLanguages = {
				eelixir = "html-eex",
				eruby = "erb",
				templ = "html",
			},
		},
		-- root_dir = lspconfig.root_pattern(
		-- 	"tailwind.config.js",
		-- 	"tailwind.config.cjs",
		-- 	"tailwind.config.mjs",
		-- 	"tailwind.config.ts",
		-- 	"postcss.config.js",
		-- 	"postcss.config.cjs",
		-- 	"postcss.config.mjs",
		-- 	"postcss.config.ts",
		-- 	"package.json",
		-- 	"node_modules",
		-- 	".git"
		-- ),
		settings = {
			tailwindCSS = {
				classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
				lint = {
					cssConflict = "warning",
					invalidApply = "error",
					invalidConfigPath = "error",
					invalidScreen = "error",
					invalidTailwindDirective = "error",
					invalidVariant = "error",
					recommendedVariantOrder = "warning",
				},
				validate = true,
			},
		},
		single_file_support = true,
	})

	-- json
	lspconfig.jsonls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = { "vscode-json-language-server", "--stdio" },
		filetypes = { "json", "jsonc" },
		init_options = {
			provideFormatter = true,
		},
		-- root_dir = lspconfig.util.find_git_ancestor,
		single_file_support = true,
	})

	-- python
	lspconfig.pyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = {
				disableOrganizeImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})

	-- typescript
	lspconfig.tsserver.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		cmd = { "typescript-language-server", "--stdio" },
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
		init_options = {
			hostInfo = "neovim",
		},
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
		single_file_support = true,
	})

	-- bash
	lspconfig.bashls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = {
			"bash-language-server",
			"start",
		},
		root_dir = lspconfig.util.find_git_ancestor,
		settings = {
			bashIde = {
				globPattern = "*@(.sh|.inc|.bash|.command)",
			},
		},
		filetypes = { "sh" },
	})

	-- html, typescriptreact, javascriptreact, css, sass, scss, less, svelte, vue
	lspconfig.emmet_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = {
			"astro",
			"css",
			"eruby",
			"html",
			"htmldjango",
			"javascriptreact",
			"less",
			"pug",
			"sass",
			"scss",
			"svelte",
			"typescriptreact",
			"vue",
		},
		single_file_support = true,
	})

	-- astro
	lspconfig.astro.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = { "astro-ls", "--stdio" },
		filetypes = { "astro" },
		init_options = {
			typescript = {},
		},
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
	})

	-- assembly
	lspconfig.asm_lsp.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = {
			"asm",
			"vmasm",
		},
	})

	-- docker
	lspconfig.dockerls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	-- lua
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	-- C/C++
	local clang_tidy = require("efmls-configs.linters.clang_tidy")
	local clang_format = require("efmls-configs.formatters.clang_format")
	-- python
	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")
	-- js/ts
	local eslint_d = require("efmls-configs.linters.eslint_d")
	local prettierd = require("efmls-configs.formatters.prettier_d")
	local fixjson = require("efmls-configs.formatters.fixjson")
	-- sh/md, etc
	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")
	local markdownlint = require("efmls-configs.linters.markdownlint")
	local hadolint = require("efmls-configs.linters.hadolint")

	-- configure efm server
	lspconfig.efm.setup({
		filetypes = {
			"html",
			"css",
			"lua",
			"c",
			"cpp",
			"python",
			"json",
			"jsonc",
			"sh",
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"astro",
			"svelte",
			"vue",
			"markdown",
			"docker",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				html = { nil, prettierd },
				lua = { luacheck, stylua },
				cpp = { clang_tidy, clang_format },
				c = { clang_tidy, clang_format },
				python = { flake8, black },
				typescript = { eslint_d, prettierd },
				json = { eslint_d, fixjson },
				jsonc = { eslint_d, fixjson },
				sh = { shellcheck, shfmt },
				javascript = { eslint_d, prettierd },
				javascriptreact = { eslint_d, prettierd },
				typescriptreact = { eslint_d, prettierd },
				astro = { eslint_d, prettierd },
				svelte = { eslint_d, prettierd },
				vue = { eslint_d, prettierd },
				markdown = { markdownlint, prettierd },
				docker = { hadolint, prettierd },
			},
		},
	})

	-- Format on Save
	local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = lsp_fmt_group,
		callback = function()
			local efm = vim.lsp.get_active_clients({ name = "efm" })

			if vim.tbl_isempty(efm) then
				return
			end

			vim.lsp.buf.format({ name = "efm" })
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
	},
}
