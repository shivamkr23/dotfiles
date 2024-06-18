local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

-- Setup Workspace
local home = os.getenv("HOME")
local workspace_path = home .. "/.local/share/jdtls/jdtls-workspace/"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = workspace_path .. project_name

-- Determine OS
local os_config = "linux"

-- Setup Capabilities
local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local cmp_lsp = require("cmp_nvim_lsp")
local capabilities =
	vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_lsp.default_capabilities())

local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/")

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-javaagent:" .. mason_path .. "packages/jdtls/lombok.jar",
		"-jar",
		vim.fn.glob(mason_path .. "packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		mason_path .. "packages/jdtls/config_" .. os_config,
		"-data",
		workspace_dir,
	},

	root_dir = require("jdtls.setup").find_root({
		".git",
		"mvnw",
		"gradlew",
		"pom.xml",
		"build.gradle",
		"build.xml",
		"settings.gradle",
		"settings.gradle.kts",
		"build.gradle.kts",
	}),
	capabilities = capabilities,
	settings = {
		java = {
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			inlayHints = {
				parametersNames = {
					enabled = "all",
				},
			},
			format = {
				enabled = true,
				settings = {
					url = {
						"https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml",
					},
					profile = {
						"GoogleStyle",
					},
				},
			},
			signatureHelp = { enabled = true },
		},
	},
	init_options = {
		extendedClientCapabilities = extendedClientCapabilities,
	},
}
config.on_init = function(client, _)
	client.notify("workspace/didChangeConfiguration", { settings = config.settings })
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*.java" },
	callback = function()
		local _, _ = pcall(vim.lsp.codelens.refresh)
	end,
})

vim.api.nvim_create_autocmd("JdtlsAttach", {
	group = vim.api.nvim_create_augroup("JdtlsLspConfig", {}),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf, silent = true }

		vim.keymap.set("n", "<A-o>", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
		vim.keymap.set("n", "crv", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
		vim.keymap.set("v", "crv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
		vim.keymap.set("n", "crc", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
		vim.keymap.set("v", "crc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
		vim.keymap.set("v", "crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts) -- set keybinds
		vim.keymap.set("n", "crm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts) -- set keybinds
	end,
})

require("jdtls").start_or_attach(config)
