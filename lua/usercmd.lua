local api = vim.api
-- command open dapui float
-- refer: https://github.com/rcarriga/nvim-dap-ui
api.nvim_create_user_command("DapFloatWin", function(args)
	local dapfloat = {
		"scopes",
		"stacks",
		"console",
		"breakpoints",
		"watches",
		"repl",
	}
	if vim.tbl_contains(dapfloat, args.fargs[1]) then
		require("dapui").float_element(args.fargs[1], { enter = true })
	else
		---@diagnostic disable-next-line: missing-parameter
		require("dapui").float_element()
	end
end, {
	desc = "load dapui float",
	nargs = "?",
	---@diagnostic disable-next-line: unused-local
	complete = function(A, L, P)
		return {
			"scopes",
			"stacks",
			"console",
			"breakpoints",
			"watches",
			"repl",
		}
	end,
})

-- INFO: test
-- vim.api.nvim_create_user_command("Eefwfawfwf", function(a)
-- 	vim.pretty_print(a.fargs)
-- end, {
-- 	desc = "dap test",
-- 	nargs = "?",
-- 	---@diagnostic disable-next-line: unused-local
-- 	complete = function(A, L, P)
-- 		-- A 补全时，单词的首部  例如输abcd时 A的值 依次为 a ab abc abcd
-- 		-- L 整个cmd的内容
-- 		-- P cmd 的位置
-- 		-- https://neovim.io/doc/user/map.html#%3Acommand-completion-customlist
-- 		-- test input 234
-- 		if A == "2" then
-- 			return { "1", "2", "3" }
-- 		end
-- 		if A == "23" then
-- 			return { "a", "b", "c" }
-- 		end
-- 		vim.pretty_print(A)
-- 		vim.pretty_print(L)
-- 		vim.pretty_print(P)
-- 	end,
-- })

-- command close dap
-- refer: https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt
api.nvim_create_user_command("DapCloseWin", function()
	local ok, dap = pcall(require, "dap")
	if not ok then
		vim.notify("没有找到 dap")
		return
	end
	-- local repl = dap.repl
	-- require("dapui").close({})
	-- repl.close()
	-- dap.close()
	dap.terminate()
	-- api.nvim_command([[exe "normal \<c-w>o"]])
	-- vim.api.nvim_command([[exe "normal \<Esc>0"]])
	--  refer:https://vi.stackexchange.com/questions/27796/how-to-change-editor-mode-from-lua-or-viml
	-- vim.cmd("stopinsert")
	-- dap.clear_breakpoints()
end, { desc = "close dap session" })

-- TODO: add some description
--
-- local function setUndotreeWinSize()
-- 	local winList = api.nvim_list_wins()
-- 	for _, winHandle in ipairs(winList) do
-- 		if
-- 			api.nvim_win_is_valid(winHandle)
-- 			and api.nvim_buf_get_option(api.nvim_win_get_buf(winHandle), "filetype") == "undotree"
-- 		then
-- 			api.nvim_win_set_width(winHandle, vim.g.undotree_SplitWidth)
-- 		end
-- 	end
-- end
--
-- api.nvim_create_user_command("Ut", function()
-- 	api.nvim_cmd(api.nvim_parse_cmd("UndotreeToggle", {}), {})
-- 	setUndotreeWinSize()
-- end, { desc = "load undotree" })

-- TODO: add some description
-- use vim.tbl.contains to simpfy this
local ftAndCmandLeft = {
	undotree = "UndotreeToggle",
	NvimTree = "NvimTreeToggle",
}
local function leftSidebarAutoClose(ftAcmdLeft, currentSelfLeft)
	local winList = vim.api.nvim_list_wins()
	for _, winHandle in ipairs(winList) do
		for k, v in pairs(ftAcmdLeft) do
			if
				vim.api.nvim_win_is_valid(winHandle)
				and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(winHandle), "filetype") == k
				and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(winHandle), "filetype") ~= currentSelfLeft
			then
				vim.api.nvim_cmd(api.nvim_parse_cmd(v, {}), {})
			end
		end
	end
end

api.nvim_create_user_command("Ut", function()
	vim.api.nvim_cmd(api.nvim_parse_cmd("CloseAllterm", {}), {})
	leftSidebarAutoClose(ftAndCmandLeft, "undotree")
	vim.api.nvim_cmd(api.nvim_parse_cmd("UndotreeToggle", {}), {})
end, { desc = "undotree enhanced" })
api.nvim_create_user_command("NvimTrr", function()
	vim.api.nvim_cmd(api.nvim_parse_cmd("CloseAllterm", {}), {})
	leftSidebarAutoClose(ftAndCmandLeft, "NvimTree")
	vim.api.nvim_cmd(api.nvim_parse_cmd("NvimTreeToggle", {}), {})
end, { desc = "NvimTree enhanced" })

local ftAndCmandRight = {
	dapui_scopes = "DapCloseWin",
	-- lspsagaoutline = "Lspsaga outline",
	Outline = "SymbolsOutline",
}
local function rightSidebarAutoClose(ftAcmdRight, currentSelfRight)
	local winList = vim.api.nvim_list_wins()
	for _, winHandle in ipairs(winList) do
		for k, v in pairs(ftAcmdRight) do
			-- print(vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(winHandle), "filetype"))
			if
				vim.api.nvim_win_is_valid(winHandle)
				and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(winHandle), "filetype") == k
				and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(winHandle), "filetype") ~= currentSelfRight
			then
				vim.api.nvim_cmd(api.nvim_parse_cmd(v, {}), {})
			end
		end
	end
end

api.nvim_create_user_command("LSoutline", function()
	vim.api.nvim_cmd(api.nvim_parse_cmd("CloseAllterm", {}), {})
	rightSidebarAutoClose(ftAndCmandRight, "Outline")
	vim.api.nvim_cmd(api.nvim_parse_cmd("SymbolsOutline", {}), {})
end, { desc = "LSoutlineToggle enhanced" })
api.nvim_create_user_command("DapContinuee", function()
	vim.api.nvim_cmd(api.nvim_parse_cmd("CloseAllterm", {}), {})
	rightSidebarAutoClose(ftAndCmandRight, "dapui_scopes")
	vim.api.nvim_cmd(api.nvim_parse_cmd("DapContinue", {}), {})
end, { desc = "DapContinue enhanced" })
