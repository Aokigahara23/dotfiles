return {
	"numToStr/Comment.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		-- import comment plugin safely
		local comment = require("Comment")

		-- enable comment
		comment.setup({

			toggler = {
				---Line-comment toggle keymap
				line = "<leader>cl",
				block = "<leader>cb",
			},
			opleader = {
				---Block-comment keymap
				line = "cl",
				block = "cb",
			},
		})
	end,
}
