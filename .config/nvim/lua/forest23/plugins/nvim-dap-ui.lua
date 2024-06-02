return {
	"rcarriga/nvim-dap-ui",

	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
	},

	config = function()
		local dap, dapui = require("dap"), require("dapui")

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end

		local keymap = vim.keymap

		keymap.set("n", "<leader>du", function()
			dapui.toggle()
		end, { desc = "Toggle UI" })

		vim.fn.sign_define("DapBreakpoint", { text = "" })

		local opts = {

			layouts = {
				{
					elements = {
						{
							id = "scopes",
							size = 0.5,
						},
						{
							id = "stacks",
							size = 0.5,
						},
					},
					position = "left",
					size = 70,
				},
				{
					elements = {
						{
							id = "repl",
							size = 0.5,
						},
						{
							id = "console",
							size = 0.5,
						},
					},
					position = "bottom",
					size = 15,
				},
			},
		}

		dapui.setup(opts)
	end,
}
