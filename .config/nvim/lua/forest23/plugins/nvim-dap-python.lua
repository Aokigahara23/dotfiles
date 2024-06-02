return {
	"mfussenegger/nvim-dap-python",

	ft = "python",

	dependencies = {
		"mfussenegger/nvim-dap",
	},

	config = function()
		local python_dap = require("dap-python")

		python_dap.test_runner = "pytest"
		python_dap.setup("~/workspace/venvs/nvimpy/bin/python")

		local keymap = vim.keymap

		keymap.set("n", "<leader>dm", function()
			python_dap.test_method()
		end, { desc = "[Python] test method" })
	end,
}
