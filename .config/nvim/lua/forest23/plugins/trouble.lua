return {
	"folke/trouble.nvim",

	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },

	keys = {
		{ "<leader>ht", "<cmd>TroubleToggle<CR>", desc = "Open/close trouble list" },
		{ "<leader>hw", "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "Open trouble workspace diagnostics" },
		{ "<leader>hd", "<cmd>TroubleToggle document_diagnostics<CR>", desc = "Open trouble document diagnostics" },
		{ "<leader>hq", "<cmd>TroubleToggle quickfix<CR>", desc = "Open trouble quickfix list" },
		{ "<leader>hl", "<cmd>TroubleToggle loclist<CR>", desc = "Open trouble location list" },
		{ "<leader>lT", "<cmd>TodoTrouble<CR>", desc = "Open todos in trouble" },
	},
}
