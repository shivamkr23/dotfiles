return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	keys = {
		{ "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer Prev" },
		{ "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer Next" },
		{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Other Buffers" },
		{ "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
	},
	opts = {
		options = {
			mode = "buffers",
			separator_style = "slant",
			always_show_bufferline = false,
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(_, _, diagnostics_dict, _)
				local s = " "
				for e, n in pairs(diagnostics_dict) do
					local sym = e == "error" and " "
						or (e == "warning" and " " or (e == "hint" and " " or " "))
					s = s .. n .. sym
				end
				return s
			end,
			numbers = true,
			custom_areas = {
				right = function()
					local result = {}
					local seve = vim.diagnostic.severity
					local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
					local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
					local info = #vim.diagnostic.get(0, { severity = seve.INFO })
					local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

					if error ~= 0 then
						table.insert(result, { text = "  " .. error, fg = "#EC5241" })
					end

					if warning ~= 0 then
						table.insert(result, { text = "  " .. warning, fg = "#EFB839" })
					end

					if hint ~= 0 then
						table.insert(result, { text = "  " .. hint, fg = "#A3BA5E" })
					end

					if info ~= 0 then
						table.insert(result, { text = "  " .. info, fg = "#7EA9A7" })
					end
					return result
				end,
			},
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					highlight = "Directory",
					text_align = "center",
					separator = true,
				},
			},
		},
	},
	config = function(_, opts)
		require("bufferline").setup(opts)
		-- Fix bufferline when restoring a session
		vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
			callback = function()
				vim.schedule(function()
					pcall(nvim_bufferline)
				end)
			end,
		})
	end,
}
