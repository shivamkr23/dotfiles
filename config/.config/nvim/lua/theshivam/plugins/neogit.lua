return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		{
			"sindrets/diffview.nvim",
			dependencies = {
				"nvim-tree/nvim-web-devicons",
			},
			setup = function()
				require("diffview").setup({
					use_icons = false,
				})
			end,
		}, -- optional - Diff integration

		-- Only one of these is needed, not both.
		"nvim-telescope/telescope.nvim", -- optional
	},
	config = function()
		require("neogit").setup()

		vim.keymap.set("n", "<leader>gn", "<cmd>Neogit<cr>")
	end,
}
