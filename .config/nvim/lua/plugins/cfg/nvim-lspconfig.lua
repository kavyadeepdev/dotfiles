local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.lsp").diagnostic_signs

local config = function()
	local on_attach = require("util.lsp").on_attach
	local diagnostic_signs = require("util.lsp").diagnostic_signs

	-- Diagnostic Signs
	for type, icon in pairs(diagnostic_signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	-- LspAttach
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			on_attach(client, ev.buf)
		end,
	})

	local lsp = vim.lsp.config
	-- blink.cmp capabilities
	local capabilities = require("blink.cmp").get_lsp_capabilities()

	-- lua
	lsp.lua_ls = {
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	}

	-- C/C++
	lsp.clangd = {
		capabilities = capabilities,
		cmd = { "clangd", "--offset-encoding=utf-16", "--clang-tidy" },
	}

	-- CMake
	lsp.cmake = {
		capabilities = capabilities,
		cmd = { "cmake-language-server" },
		filetypes = { "cmake" },
		init_options = { buildDirectory = "build" },
	}

	-- rust
	lsp.rust_analyzer = {
		capabilities = vim.tbl_deep_extend("force", capabilities, {
			experimental = { serverStatusNotification = true },
		}),
		settings = {
			["rust-analyzer"] = { diagnostics = { enable = false } },
		},
	}

	-- html
	local html_caps = vim.lsp.protocol.make_client_capabilities()
	html_caps.textDocument.completion.completionItem.snippetSupport = true
	lsp.html = {
		capabilities = html_caps,
		cmd = { "vscode-html-language-server", "--stdio" },
		filetypes = { "html", "templ" },
		init_options = {
			configurationSection = { "html", "css", "javascript" },
			embeddedLanguages = { css = true, javascript = true },
			provideFormatter = true,
		},
	}

	-- css
	lsp.cssls = {
		capabilities = capabilities,
		cmd = { "vscode-css-language-server", "--stdio" },
		filetypes = { "css", "scss", "less" },
		init_options = { provideFormatter = true },
		settings = {
			css = { validate = true },
			less = { validate = true },
			scss = { validate = true },
		},
	}

	-- tailwindcss
	lsp.tailwindcss = {
		capabilities = capabilities,
		cmd = { "tailwindcss-language-server", "--stdio" },
		filetypes = {
			"aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure",
			"django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs",
			"erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs",
			"html", "html-eex", "heex", "jade", "leaf", "liquid", "markdown",
			"mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig",
			"css", "less", "postcss", "sass", "scss", "stylus", "sugarss",
			"javascript", "javascriptreact", "reason", "rescript",
			"typescript", "typescriptreact", "vue", "svelte", "templ",
		},
		init_options = {
			userLanguages = { eelixir = "html-eex", eruby = "erb", templ = "html" },
		},
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
	}

	-- json
	lsp.jsonls = {
		capabilities = capabilities,
		cmd = { "vscode-json-language-server", "--stdio" },
		filetypes = { "json", "jsonc" },
		init_options = { provideFormatter = true },
	}

	-- python
	lsp.pyright = {
		capabilities = capabilities,
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
	}

	-- typescript
	lsp.ts_ls = {
		capabilities = capabilities,
		cmd = { "typescript-language-server", "--stdio" },
		filetypes = {
			"javascript", "javascriptreact", "javascript.jsx",
			"typescript", "typescriptreact", "typescript.tsx",
		},
		init_options = { hostInfo = "neovim" },
	}

	-- bash
	lsp.bashls = {
		capabilities = capabilities,
		cmd = { "bash-language-server", "start" },
		settings = { bashIde = { globPattern = "*@(.sh|.inc|.bash|.command)" } },
		filetypes = { "sh" },
	}

	-- emmet
	lsp.emmet_ls = {
		capabilities = capabilities,
		filetypes = {
			"astro", "css", "eruby", "html", "htmldjango", "javascriptreact",
			"less", "pug", "sass", "scss", "svelte", "typescriptreact", "vue",
		},
	}

	-- astro
	lsp.astro = {
		capabilities = capabilities,
		cmd = { "astro-ls", "--stdio" },
		filetypes = { "astro" },
		init_options = { typescript = {} },
	}

	-- assembly
	lsp.asm_lsp = {
		capabilities = capabilities,
		filetypes = { "asm", "vmasm" },
	}

	-- docker
	lsp.dockerls = {
		capabilities = capabilities,
	}

	-- golang
	lsp.gopls = {
		capabilities = capabilities,
		cmd = { "gopls" },
		filetypes = { "go", "gomod", "gowork", "gotmpl" },
		settings = {
			gopls = {
				completeUnimported = true,
				usePlaceholders = true,
				analyses = { unusedparams = true },
			},
		},
	}

	-- efm setup
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	local clang_tidy = require("efmls-configs.linters.clang_tidy")
	local clang_format = require("efmls-configs.formatters.clang_format")
	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")
	local eslint_d = require("efmls-configs.linters.eslint_d")
	local prettierd = require("efmls-configs.formatters.prettier_d")
	local fixjson = require("efmls-configs.formatters.fixjson")
	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")
	local markdownlint = require("efmls-configs.linters.markdownlint")
	local hadolint = require("efmls-configs.linters.hadolint")

	lsp.efm = {
		filetypes = {
			"html", "css", "lua", "c", "cpp", "python", "json", "jsonc", "sh",
			"javascript", "javascriptreact", "typescript", "typescriptreact",
			"astro", "svelte", "vue", "markdown", "docker",
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
	}

	-- Activate all configured servers
	vim.lsp.enable({
		"lua_ls", "clangd", "cmake", "rust_analyzer", "html", "cssls",
		"tailwindcss", "jsonls", "pyright", "ts_ls", "bashls",
		"emmet_ls", "astro", "asm_lsp", "dockerls", "efm", "gopls",
	})

	-- Format on Save
	local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = lsp_fmt_group,
		callback = function()
			local efm = vim.lsp.get_clients({ name = "efm" })
			if not vim.tbl_isempty(efm) then
				vim.lsp.buf.format({ name = "efm" })
			end
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
		"saghen/blink.cmp",
	},
}
