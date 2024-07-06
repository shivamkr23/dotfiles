return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"mfussenegger/nvim-jdtls",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")
		-- enable mason and configure icons
		mason.setup({
			ui = {
				border = "rounded",
				icons = {
					package_installed = "I",
					package_pending = "P",
					package_uninstalled = "U",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"angularls",
				"ansiblels",
				"bashls",
				"clangd",
				"cssls",
				"emmet_ls",
				"gopls",
				"graphql",
				"html",
				"intelephense",
				"jdtls",
				"jinja_lsp",
				"jsonls",
				"kotlin_language_server",
				"ltex",
				"lua_ls",
				"marksman",
				"pyright",
				"ruby_lsp",
				"rust_analyzer",
				"solidity_ls_nomicfoundation",
				"svelte",
				"tailwindcss",
				"tsserver",
				"vimls",
				"volar",
				"yamlls",
				"zls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint", -- python linter
				"eslint_d", -- js linter
			},
		})
	end,
}
