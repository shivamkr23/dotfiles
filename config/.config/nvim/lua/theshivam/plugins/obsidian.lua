return {
	"epwalsh/obsidian.nvim",
	lazy = true,
	event = {
		-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		"BufReadPre /home/king/vaults/obvault/**.md",
		"BufNewFile /home/king/valuts/obvault/**.md",
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		dir = "~/vaults/obvault",
		notes_subdir = "notes",
		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "notes/dailies",
			default_tags = { "daily-notes" },
		},
		completion = {
			nvim_cmp = true,
			nvim_cmp_format = "[Obsidian]",
			min_chars = 2,
		},
		templates = {
			folder = "~/vaults/obvault/templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			-- A map for custom variables, the key should be the variable and the value a function
			substitutions = {},
		},
		new_notes_location = "notes_subdir",
		preferred_link_style = "wiki",
		picker = {
			name = "telescope.nvim",
		},
		ui = {
			checkboxes = {
				[" "] = { char = "☐", hl_group = "ObsidianTodo" },
				["x"] = { char = "✔", hl_group = "ObsidianDone" },
				[">"] = { char = ">", hl_group = "ObsidianRightArrow" },
				["~"] = { char = "~", hl_group = "ObsidianTilde" },
				["!"] = { char = "!", hl_group = "ObsidianImportant" },
				-- Replace the above with this if you don't have a patched font:
				-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
				-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

				-- You can also add more custom ones...
			},
		},
	},
}
