local M = {}

function M.is_template()
	local unpack = table.unpack or unpack

	local line = vim.api.nvim_get_current_line()
	local r, c = unpack(vim.api.nvim_win_get_cursor(0))
	if not (vim.o.filetype == "cpp" or vim.o.filetype == "c") then
		line = line:sub(1, c) .. "<" .. line:sub(c + 1)
		vim.api.nvim_set_current_line(line)
		vim.api.nvim_win_set_cursor(0, { r, c + 1 })
		return
	end

	if vim.fn.match({ line }, "template") == 0 then
		line = line:sub(1, c) .. "<>" .. line:sub(c + 1)
		vim.api.nvim_set_current_line(line)
		vim.api.nvim_win_set_cursor(0, { r, c + 1 })
		return
	end

	if vim.fn.match({ line }, "#include") == 0 then
		line = line:sub(1, c) .. "<>" .. line:sub(c + 1)
		if line:sub(c, c) ~= " " then
			line = line:sub(1, c) .. " " .. line:sub(c + 1)
			c = c + 1
		end
		vim.api.nvim_set_current_line(line)
		vim.api.nvim_win_set_cursor(0, { r, c + 1 })
		return
	end
	if vim.fn.match({ line:sub(0, c) }, "cast\\s*$") == 0 then
		-- c - 1 = 2 chars before the cursor
		line = line:sub(1, c) .. "<>" .. line:sub(c + 1)
		vim.api.nvim_set_current_line(line)
		vim.api.nvim_win_set_cursor(0, { r, c + 1 })
		return
	end

	line = line:sub(1, c) .. "<" .. line:sub(c + 1)
	vim.api.nvim_set_current_line(line)
	vim.api.nvim_win_set_cursor(0, { r, c + 1 })
	vim.cmd("redraw") -- redraw to add the first <

	local old_handler = vim.lsp.handlers["textDocument/signatureHelp"]
	vim.lsp.handlers["textDocument/signatureHelp"] = function(_, info)
		if info and info.signatures and info.signatures[1] and info.signatures[1].label then
			local functionsig = info.signatures[1].label
			if vim.fn.match({ functionsig }, "^\\w\\+<") == 0 then
				-- c + 1 is after including the openning pair very shady code lol
				vim.api.nvim_set_current_line(line:sub(0, c + 1) .. ">" .. line:sub(c + 2))
			end
		end
	end
	vim.lsp.buf.signature_help()
	vim.lsp.handlers["textDocument/signatureHelp"] = old_handler
end

function M.struct_class_semicolon()
	local line = vim.api.nvim_get_current_line()
	-- match for() while() functions()
	local pattern = "\\m^.*(.*)"

	if vim.fn.match(line, pattern) ~= -1 or vim.fn.match(line, "namespace") ~= -1 then
		return false
	end
end

return M
