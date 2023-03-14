-- mixed

-- vim.api.nvim_create_user_command("MessageRedirect", function()
-- 	vim.cmd("enew | put=execute('messages')")
-- 	-- vim.cmd([[let @a='' | redir @a | silent messages | redir END | enew | put! a | let @a='']])
-- end, {
-- 	desc = "redirect messages",
-- 	nargs = "?",
-- })

vim.api.nvim_create_user_command("RecommandTo", function(args)
	local cmd = ""
	for _, v in ipairs(args.fargs) do
		cmd = cmd .. v .. " "
	end
	cmd = cmd:gsub("^%s*(.-)%s*$", "%1")
	local text = vim.api.nvim_exec(cmd, true)
	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(text, "\n", { trimempty = true, plain = true }))
	vim.api.nvim_set_current_buf(buf)
end, {
	desc = "redirect command output",
	nargs = "*",
	complete = function(_, _, _)
		return {
			"messages",
		}
	end,
})

-- buffer operation
vim.api.nvim_create_user_command("BufferOperation", function(args)
	local args_table = {
		"saveSingleBuffer",
		"saveALL",
		"delSingleBuffer",
		"delOthers",
		"delOthersForce",
		"bufferGoto",
	}
	local bufnrs = vim.tbl_filter(function(b)
		-- vim.api.nvim_buf_get_option(bufnr, "buflisted")
		-- only listed buffers
		if 1 ~= vim.fn.buflisted(b) then
			return false
		end
		-- only loaded buffers
		if not vim.api.nvim_buf_is_loaded(b) then
			return false
		end
		-- don't include current buffer
		if b == vim.api.nvim_get_current_buf() then
			return false
		end
		return true
	end, vim.api.nvim_list_bufs())
	local function path_tail(path)
		local on_windows = vim.loop.os_uname().version:match("Windows")
		local os_sep = on_windows and "\\" or "/"
		for i = #path, 1, -1 do
			if path:sub(i, i) == os_sep then
				return path:sub(i + 1, -1)
			end
		end
		return path
	end

	local caselist = {
		saveALL = function()
			for _, bufnr in ipairs(bufnrs) do
				vim.api.nvim_buf_call(bufnr, function()
					vim.cmd("w")
				end)
			end
		end,
		saveSingleBuffer = function(buffer_name)
			for _, bufnr in ipairs(bufnrs) do
				if path_tail(vim.api.nvim_buf_get_name(bufnr)) == buffer_name[2] then
					vim.api.nvim_buf_call(bufnr, function()
						vim.cmd("w")
					end)
				end
			end
		end,
		delSingleBuffer = function(buffer_name)
			for _, bufnr in ipairs(bufnrs) do
				if path_tail(vim.api.nvim_buf_get_name(bufnr)) == buffer_name[2] then
					vim.api.nvim_buf_delete(bufnr, {})
				end
			end
		end,
		delOthers = function()
			for _, bufnr in ipairs(bufnrs) do
				vim.api.nvim_buf_delete(bufnr, {})
			end
		end,
		delOthersForce = function()
			for _, bufnr in ipairs(bufnrs) do
				vim.api.nvim_buf_delete(bufnr, { force = true })
			end
		end,
		bufferGoto = function(buffer_name)
			for _, bufnr in ipairs(bufnrs) do
				if path_tail(vim.api.nvim_buf_get_name(bufnr)) == buffer_name[2] then
					vim.api.nvim_set_current_buf(bufnr)
				end
			end
		end,
	}
	if vim.tbl_contains(args_table, args.fargs[1]) then
		caselist[args.fargs[1]](args.fargs)
	end
end, {
	desc = "delete and save buffers",
	nargs = "*",
	complete = function(_, L, P)
		local bufnrs = vim.tbl_filter(function(b)
			if 1 ~= vim.fn.buflisted(b) then
				return false
			end
			if not vim.api.nvim_buf_is_loaded(b) then
				return false
			end
			if b == vim.api.nvim_get_current_buf() then
				return false
			end
			return true
		end, vim.api.nvim_list_bufs())
		local function path_tail(path)
			local on_windows = vim.loop.os_uname().version:match("Windows")
			local os_sep = on_windows and "\\" or "/"
			for i = #path, 1, -1 do
				if path:sub(i, i) == os_sep then
					return path:sub(i + 1, -1)
				end
			end
			return path
		end
		if L == "BufferOperation saveSingleBuffer " then
			local complete_list = {}
			for _, v in ipairs(bufnrs) do
				if vim.fn.getbufinfo(v)[1].changed == 1 then
					table.insert(complete_list, path_tail(vim.api.nvim_buf_get_name(v)))
				end
			end
			return complete_list
		end
		if L == "BufferOperation delSingleBuffer " then
			local complete_list = {}
			for _, v in ipairs(bufnrs) do
				table.insert(complete_list, path_tail(vim.api.nvim_buf_get_name(v)))
			end
			return complete_list
		end
		if L == "BufferOperation bufferGoto " then
			local complete_list = {}
			for _, v in ipairs(bufnrs) do
				table.insert(complete_list, path_tail(vim.api.nvim_buf_get_name(v)))
			end
			return complete_list
		end
		if P == 16 then
			return { "saveSingleBuffer", "saveALL", "delSingleBuffer", "delOthers", "delOthersForce", "bufferGoto" }
		end
	end,
})

-- diagnostic opration
vim.api.nvim_create_user_command("DiagnosticExtension", function(args)
	local args_table = {
		"disableDiagnostic",
		"enableDiagnostic",
		"hideDiagnostic",
		"showDiagnostic",
		"removeDiagnostic",
		"shownamespace",
	}

	local caselist = {
		disableDiagnostic = function()
			vim.diagnostic.disable()
		end,
		enableDiagnostic = function()
			vim.diagnostic.enable()
		end,
		hideDiagnostic = function()
			vim.diagnostic.hide()
		end,
		showDiagnostic = function()
			vim.diagnostic.show()
		end,
		removeDiagnostic = function()
			vim.diagnostic.reset()
		end,
		shownamespace = function()
			vim.pretty_print(vim.diagnostic.get_namespaces())
		end,
	}
	if vim.tbl_contains(args_table, args.fargs[1]) then
		caselist[args.fargs[1]](args.fargs)
	end
end, {
	desc = "about vim.diagnostic",
	nargs = "?",
	complete = function(_, _, P)
		if P == 20 then
			return {
				"disableDiagnostic",
				"enableDiagnostic",
				"hideDiagnostic",
				"showDiagnostic",
				"removeDiagnostic",
				"shownamespace",
			}
		end
	end,
})

-- LSP opration
vim.api.nvim_create_user_command("LspExtension", function(args)
	local args_table = {
		"stop_lsp",
		"get_all_active_clients",
		"get_single_active_client",
		"stop_semantic_tokens",
		"start_semantic_tokens",
		"get_semantic_tokens_cursor",
	}

	local caselist = {
		stop_lsp = function()
			---@diagnostic disable-next-line: missing-parameter
			vim.lsp.stop_client(vim.lsp.get_active_clients())
		end,
		get_all_active_clients = function()
			for _, value in ipairs(vim.lsp.get_active_clients()) do
				vim.pretty_print(value)
			end
		end,
		get_single_active_client = function(active_client_name)
			for _, value in ipairs(vim.lsp.get_active_clients()) do
				if value.name == active_client_name[2] then
					vim.pretty_print(value)
				end
			end
		end,
		get_semantic_tokens_cursor = function()
			vim.pretty_print(vim.lsp.semantic_tokens.get_at_pos())
		end,
		start_semantic_tokens = function()
			vim.lsp.semantic_tokens.start()
		end,
		stop_semantic_tokens = function()
			vim.lsp.semantic_tokens.stop()
		end,
	}
	if vim.tbl_contains(args_table, args.fargs[1]) then
		caselist[args.fargs[1]](args.fargs)
	end
end, {
	desc = "about vim.lsp",
	nargs = "*",
	complete = function(_, L, P)
		if L == "LspExtension get_single_active_client " then
			local complete_list = {}
			for _, value in ipairs(vim.lsp.get_active_clients()) do
				table.insert(complete_list, value.name)
			end
			return complete_list
		end
		if P == 13 then
			return {
				"stop_lsp",
				"get_all_active_clients",
				"get_single_active_client",
				"stop_semantic_tokens",
				"start_semantic_tokens",
				"get_semantic_tokens_cursor",
			}
		end
	end,
})
