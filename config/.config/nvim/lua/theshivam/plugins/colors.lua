return {
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		require("rose-pine").setup({
			disable_background = true,
			styles = {
				italic = false,
				transparency = true,
			},
			highlight_groups = {
				StatusLine = { bg = "#111111" },
				StatusLineNC = { bg = "#111111" },
			},
		})

		vim.cmd("colorscheme rose-pine")
		vim.api.nvim_set_hl(0, "LspInlayHint", { fg = "#403d52", bg = "none" })
	end,
}
