return {
	"stevearc/conform.nvim",

	event = { "BufReadPre", "BufNewFile" },

	config = function()
		local conform = require("conform")

		local keymap = vim.keymap

		keymap.set("n", "<leader>lf", function()
			vim.lsp.buf.format({ async = true })
		end, { desc = "Format current document" }) -- show definition, references

		conform.setup({
			formatters_by_ft = {
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "ruff" },
				-- cpp = { "clang-format" },
				-- c = { "clang-format" },
			},

			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		conform.formatters.ruff = {
			env = {
				RUFF_EXPERIMENTAL_FORMATTER = true,
			},
		}
	end,
}
