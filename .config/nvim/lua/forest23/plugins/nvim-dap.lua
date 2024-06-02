return {
	"mfussenegger/nvim-dap",

	dependecies = {},

	config = function()
		local dap = require("dap")
		local keymap = vim.keymap

		--[[ dap.adapters.cpp = {
			type = "executable",
			attach = {
				pidProperty = "pid",
				pidSelect = "ask",
			},
			command = "lldb-vscode-14", -- my binary was called 'lldb-vscode-11'
			env = {
				LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES",
			},
			name = "lldb",
		} ]]

		dap.adapters.lldb = {
			type = "executable",
			attach = {
				pidProperty = "pid",
				pidSelect = "ask",
			},
			command = "/usr/bin/lldb-vscode-14", -- adjust as needed, must be absolute path
			name = "lldb",
		}

		keymap.set("n", "<leader>dc", function()
			-- (Re-)reads launch.json if present
			local launchJson = "./launch.json"
			if vim.fn.filereadable(launchJson) then
				require("dap.ext.vscode").load_launchjs(launchJson, { lldb = { "c", "cpp" } })
			end
			dap.continue()
		end, { desc = "Continue" })
		keymap.set("n", "<leader>ds", function()
			dap.step_over()
		end, { desc = "Step over" })
		keymap.set("n", "<leader>di", function()
			dap.step_into()
		end, { desc = "Step into" })
		keymap.set("n", "<leader>do", function()
			dap.step_out()
		end, { desc = "Step out" })
		keymap.set("n", "<Leader>db", function()
			dap.toggle_breakpoint()
		end, { desc = "Toggle breakpoint" })
		keymap.set("n", "<Leader>dx", function()
			dap.terminate()
		end, { desc = "Terminate debugger" })
	end,
}
