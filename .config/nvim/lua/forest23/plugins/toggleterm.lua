return {
	-- amongst your other plugins
	{
		"akinsho/toggleterm.nvim",
		version = "*",

		config = function()
			require("toggleterm").setup({

				open_mapping = [[<C-r>]],
				hide_numbers = true,
				autochdir = true,
				start_in_insert = true,
				insert_mappings = true, -- whether or not the open mapping applies in insert mode
				persist_size = true,
				direction = "float", -- | 'horizontal' | 'horizontal' | 'tab' | 'float',,
				close_on_exit = true, -- close the terminal window when the process exits
			})
		end,
	},
}
