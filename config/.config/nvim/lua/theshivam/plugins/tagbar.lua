return {
	"majutsushi/tagbar",
	config = function()
		vim.keymap.set("n", "<leader>qt", "<cmd>TagbarToggle<CR>")
	end,
}
