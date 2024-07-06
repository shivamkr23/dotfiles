return {
	"hrsh7th/cmp-nvim-lsp",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lua",
		"petertriho/cmp-git",
		{
			"nat-418/cmp-color-names.nvim",
			config = function()
				require("cmp-color-names").setup()
			end,
		},
		{
			"saecki/crates.nvim",
			event = { "BufRead Cargo.toml" },
			config = function()
				require("crates").setup({
					lsp = {
						enabled = true,
						actions = true,
						completion = true,
						hover = true,
					},
					completion = {
						cmp = {
							enabled = true,
						},
						crates = {
							enabled = true, -- disabled by default
							max_results = 8, -- The maximum number of search results to display
							min_chars = 3, -- The minimum number of charaters to type before completions begin appearing
						},
					},
				})
			end,
		},
		{
			"David-Kunz/cmp-npm",
			dependencies = { "nvim-lua/plenary.nvim" },
			ft = "json",
			config = function()
				require("cmp-npm").setup({})
			end,
		},
		"micangl/cmp-vimtex",
		"SergioRibera/cmp-dotenv",
	},

	config = function()
		-- Set up nvim-cmp.
		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				-- REQUIRED - you must specify a snippet engine
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<M-Space>"] = cmp.mapping.complete(),
				["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			}),
			sources = cmp.config.sources({
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "path" },
				{ name = "color_names" },
				{
					name = "html-css",
					option = {
						max_count = {}, -- not ready yet
						enable_on = {
							"html",
						}, -- set the file types you want the plugin to work on
						file_extensions = { "css", "sass", "less" }, -- set the local filetypes from which you want to derive classes
						style_sheets = {
							"https://cdn.jsdelivr.net/npm/bootstrap@latest/dist/css/bootstrap.min.css",
						},
					},
				},
				{ name = "crates" },
				{ name = "npm", keyword_length = 2 },
				{ name = "vimtex" },
				{ name = "dotenv" },
			}),
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			formatting = {
				format = function(entry, vim_item)
					vim_item.menu = ({
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[Lua]",
						path = "[Path]",
						color_names = "[Color]",
						["html-css"] = entry.completion_item.menu,
						crates = "[Crates]",
						npm = "[NPM]",
						dotenv = "[DotEnv]",
						vimtex = "[VimTeX]",
						git = "[Git]",
						cmdline = "[Cmdline]",
						obsidian = "[Obsidian]",
						obsidian_tags = "[Obsidian Tags]",
						obsidian_new = "[Obsidian New]",
					})[entry.source.name]
					return vim_item
				end,
			},
		})

		-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
		-- Set configuration for specific filetype.
		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "git" },
			}, {
				{ name = "buffer" },
			}),
		})
		require("cmp_git").setup()

		-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline(),
			sources = {
				{ name = "buffer" },
			},
		})

		-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})
	end,
}
