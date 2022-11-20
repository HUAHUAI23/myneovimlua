local api = vim.api
-- command open dapui float
-- refer: https://github.com/rcarriga/nvim-dap-ui
api.nvim_create_user_command("DapFloatWin", function()
	require("dapui").float_element()
end, { desc = "load dapui float" })

-- command close dap
-- refer: https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt
api.nvim_create_user_command("DapCloseWin", function()
	local ok, dap = pcall(require, "dap")
	require("dapui").close()
	dap.close()
	dap.terminate()
	local repl = dap.repl
	repl.close()
	api.nvim_command([[exe "normal \<c-w>o"]])
	-- vim.api.nvim_command([[exe "normal \<Esc>0"]])
	--  refer:https://vi.stackexchange.com/questions/27796/how-to-change-editor-mode-from-lua-or-viml
	vim.cmd("stopinsert")
	-- dap.clear_breakpoints()
end, { desc = "close dap session" })

local function setUndotreeWinSize()
	local winList = api.nvim_list_wins()
	for _, winHandle in ipairs(winList) do
		if
			api.nvim_win_is_valid(winHandle)
			and api.nvim_buf_get_option(api.nvim_win_get_buf(winHandle), "filetype") == "undotree"
		then
			api.nvim_win_set_width(winHandle, vim.g.undotree_SplitWidth)
		end
	end
end
api.nvim_create_user_command("Ut", function()
	api.nvim_cmd(api.nvim_parse_cmd("UndotreeToggle", {}), {})
	setUndotreeWinSize()
end, { desc = "load undotree" })
