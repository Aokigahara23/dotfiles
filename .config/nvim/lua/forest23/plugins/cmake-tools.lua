return {
	"Civitasv/cmake-tools.nvim",

	config = function()
		local cmake_tools = require("cmake-tools")

		local keymap = vim.keymap

		cmake_tools.setup({
			cmake_tools = "cmake",
			cmake_build_directory = "build",
			cmake_build_type = "Debug",
			cmake_build_options = {},
			cmake_show_console = "always",

			cmake_runner = {
				name = "terminal",
				toggleterm = {
					direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
					close_on_exit = false, -- whether close the terminal when exit
					auto_scroll = true, -- whether auto scroll to the bottom
					singleton = true, -- single instance, autocloses the opened one, if present
				},
			},

			cmake_executor = {
				name = "quickfix",

				toggleterm = {
					direction = "float", -- 'vertical' | 'horizontal' | 'tab' | 'float'
					close_on_exit = false, -- whether close the terminal when exit
					auto_scroll = true, -- whether auto scroll to the bottom
					singleton = true, -- single instance, autocloses the opened one, if present
				},
			},
		})

		keymap.set("n", "<leader>bb", "<cmd>CMakeQuickBuild<cr>", { desc = "Build CMake project" })
		keymap.set("n", "<leader>bg", "<cmd>CMakeGenerate<cr>", { desc = "Generate CMake project" })
		keymap.set("n", "<leader>br", "<cmd>CMakeQuickRun<cr>", { desc = "Run CMake project" })
		keymap.set("n", "<leader>bs", "<cmd>CMakeSettings<cr>", { desc = "Show settings for CMake project" })
		keymap.set("n", "<leader>bt", "<cmd>CMakeSelectBuildType<cr>", { desc = "CMake select build type" })
	end,
}
