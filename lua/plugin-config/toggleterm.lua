local status, toggleterm = pcall(require, "toggleterm")
if not status then
	---@diagnostic disable-next-line: param-type-mismatch
	vim.notify("没有找到 toggleterm", "error")
	return
end
local Term = require("toggleterm.terminal")
local Terminal = Term.Terminal

if vim.env.NVIM_LIGHTTT == "1" then
	toggleterm.setup({
		size = function(term)
			if term.direction == "horizontal" then
				return math.floor(vim.o.lines * 0.35)
			elseif term.direction == "vertical" then
				return math.floor(vim.o.columns * 0.3)
			end
		end,
		start_in_insert = true,
		persist_size = false,
		-- shading_factor = 1,
		shade_terminals = false,
		highlights = {
			NormalFloat = {
				-- link = "NormalFloat",
				guifg = "#444963",
				guibg = "#f5f5f5",
			},
			FloatBorder = {
				link = "FloatBorder",
			},
			Normal = {
				-- link = "Normal",
				guifg = "#444963",
				guibg = "#f5f5f5",
			},
			StatusLine = {
				link = "StatusLine",
			},
			StatusLineNC = {
				link = "StatusLine",
			},
			-- EndOfBuffer
			-- SignColumn
			-- WinBarActive
			-- WinBarInactive

			-- NormalFloat = {
			-- 	guifg = "#ebdbb2",
			-- 	guibg = "#2c323b",
			-- },
			-- FloatBorder = {
			-- 	guifg = "#2c323b",
			-- 	guibg = "#2c323b",
			-- },
			-- Normal = {
			-- 	guifg = "#ebdbb2",
			-- 	guibg = "#2c323b",
			-- },
			-- WinBarActive = {
			-- 	guifg = "#2c323b",
			-- 	guibg = "#2c323b",
			-- },
		},
	})
else
	toggleterm.setup({
		size = function(term)
			if term.direction == "horizontal" then
				return math.floor(vim.o.lines * 0.35)
			elseif term.direction == "vertical" then
				return math.floor(vim.o.columns * 0.3)
			end
		end,
		start_in_insert = true,
		persist_size = false,
		highlights = {
			FloatBorder = {
				link = "FloatBorder",
			},
			NormalFloat = {
				link = "Normal",
			},
			Normal = {
				link = "Normal",
			},
		},
	})
end

local lazygit = Terminal:new({
	cmd = "lazygit",
	dir = "git_dir",
	direction = "float",
	-- hidden = true,
	float_opts = {
		border = "rounded",
		width = math.floor(vim.o.columns * 0.9),
		height = math.floor(vim.o.lines * 0.9),
	},
	env = {
		EDITOR = 'env VIMINIT="source ${HOME1}/.config/nvim/minimalStart/init.mini.dev.lua" nvim',
	},
	close_on_exit = true,
	on_stderr = function(t, job, data, name)
		vim.pretty_print(name)
		vim.pretty_print(data)
		vim.cmd("call jobstop(" .. job .. ")")
		t:shutdown()
	end,
})
lazygit.id = 23
lazygit.user_definename = "lazygit"

local ta = Terminal:new({
	direction = "float",
	float_opts = {
		border = "rounded",
	},
	close_on_exit = true,
	on_stderr = function(t, job, data, name)
		vim.pretty_print(name)
		vim.pretty_print(data)
		vim.cmd("call jobstop(" .. job .. ")")
		t:shutdown()
	end,
})
ta.id = 11
ta.user_definename = "float_term"

local tb = Terminal:new({
	direction = "vertical",
	close_on_exit = true,
	on_stderr = function(t, job, data, name)
		vim.pretty_print(name)
		vim.pretty_print(data)
		vim.cmd("call jobstop(" .. job .. ")")
		t:shutdown()
	end,
})
tb.id = 22
tb.user_definename = "vertical_term"

local tc = Terminal:new({
	direction = "horizontal",
	close_on_exit = true,
	on_stderr = function(t, job, data, name)
		vim.pretty_print(name)
		vim.pretty_print(data)
		vim.cmd("call jobstop(" .. job .. ")")
		t:shutdown()
	end,
})
tc.id = 33
tc.user_definename = "horizontal_term"

local td = Terminal:new({
	direction = "vertical",
	close_on_exit = true,
	on_open = function(t)
		vim.api.nvim_win_set_width(t.window, math.floor(vim.o.columns * 0.8))
	end,
	on_stderr = function(t, job, data, name)
		vim.pretty_print(name)
		vim.pretty_print(data)
		vim.cmd("call jobstop(" .. job .. ")")
		t:shutdown()
	end,
})
td.id = 42
td.user_definename = "80vertical_term"

local tx = Terminal:new({
	direction = "horizontal",
	close_on_exit = true,
	on_open = function(t)
		vim.api.nvim_win_set_height(t.window, math.floor(vim.o.lines * 0.5))
		vim.keymap.set({ "n", "t" }, "<M-q>", function()
			t:close()
		end, { buffer = t.bufnr })
	end,
	on_stderr = function(t, job, data, name)
		vim.pretty_print(name)
		vim.pretty_print(data)
		vim.cmd("call jobstop(" .. job .. ")")
		t:shutdown()
	end,
})
tx.id = 13
tx.user_definename = "80compile_term"

local M = {}

local others_win_close = function()
	local filetype = {
		"undotree",
		"NvimTree",
		"dapui_scopes",
		"Outline",
	}
	local filetype_cmd = {
		undotree = "UndotreeToggle",
		NvimTree = "NvimTreeToggle",
		dapui_scopes = "DapCloseWin",
		Outline = "SymbolsOutline",
	}
	for _, win_handle in ipairs(vim.api.nvim_list_wins()) do
		local win_buf = vim.api.nvim_win_get_buf(win_handle)
		local win_buf_filetype = vim.api.nvim_buf_get_option(win_buf, "filetype")
		if vim.api.nvim_win_is_valid(win_handle) and vim.tbl_contains(filetype, win_buf_filetype) then
			vim.api.nvim_cmd(vim.api.nvim_parse_cmd(filetype_cmd[win_buf_filetype], {}), {})
		end
	end
end

M.toggleA = function()
	if tb:is_open() then
		tb:close()
	end
	if tc:is_open() then
		tc:close()
	end
	if td:is_open() then
		td:close()
	end
	if tx:is_open() then
		tx:close()
	end
	if lazygit:is_open() then
		lazygit:close()
	end
	if ta:is_open() then
		ta:close()
	else
		others_win_close()
		ta:open()
	end
end

M.toggleB = function()
	if ta:is_open() then
		ta:close()
	end
	if tc:is_open() then
		tc:close()
	end
	if td:is_open() then
		td:close()
	end
	if tx:is_open() then
		tx:close()
	end
	if lazygit:is_open() then
		lazygit:close()
	end
	if tb:is_open() then
		tb:close()
	else
		others_win_close()
		tb:open()
	end
end

M.toggleC = function()
	if ta:is_open() then
		ta:close()
	end
	if tb:is_open() then
		tb:close()
	end
	if td:is_open() then
		td:close()
	end
	if tx:is_open() then
		tx:close()
	end
	if lazygit:is_open() then
		lazygit:close()
	end
	if tc:is_open() then
		tc:close()
	else
		others_win_close()
		tc:open()
	end
end

M.toggleD = function()
	if ta:is_open() then
		ta:close()
	end
	if tb:is_open() then
		tb:close()
	end
	if tc:is_open() then
		tc:close()
	end
	if tx:is_open() then
		tx:close()
	end
	if lazygit:is_open() then
		lazygit:close()
	end
	if td:is_open() then
		td:close()
	else
		others_win_close()
		td:open()
	end
end

M.toggleG = function()
	if ta:is_open() then
		ta:close()
	end
	if tb:is_open() then
		tb:close()
	end
	if tc:is_open() then
		tc:close()
	end
	if td:is_open() then
		td:close()
	end
	if tx:is_open() then
		tx:close()
	end
	if lazygit:is_open() then
		lazygit:close()
	else
		others_win_close()
		lazygit:open()
	end
end
M.toggleCompile = function()
	local compiler = {
		javascript = "node",
		python = "python",
		c = "gcc -g -Wall",
	}
	local compile_cmd = compiler[vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "filetype")] or "ls"
	local filepath = vim.fn.expand(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())):gsub(" ", "\\ ")
	local cmd = nil
	local parent_dir = vim.fn.expand("%:p:h"):gsub(" ", "\\ ")
	-- local path = "/home/user/documents/file.txt"
	-- local parentDir = path:match("(.*/)")
	-- local cmd = { "clear", compile_cmd .. " " .. filepath }

	if vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "filetype") == "c" then
		cmd = {
			"cd" .. " " .. parent_dir,
			compile_cmd .. " " .. filepath .. " " .. "-o" .. " " .. filepath .. ".exe",
			filepath .. ".exe",
		}
	else
		cmd = compile_cmd .. " " .. filepath
	end
	if ta:is_open() then
		ta:close()
	end
	if tb:is_open() then
		tb:close()
	end
	if tc:is_open() then
		tc:close()
	end
	if td:is_open() then
		td:close()
	end
	if lazygit:is_open() then
		lazygit:close()
	end
	if tx:is_open() then
		tx:close()
	else
		others_win_close()
		vim.cmd([[write]]) -- must before tx:open(), tx:open() will change the current window
		tx:open()
		-- vim.pretty_print(cmd)
		tx:send(cmd)
	end
end

-- http://neovim.io/doc/user/job_control.html
-- https://neovim.io/doc/user/channel.html
-- vim.api.nvim_chan_send -- https://neovim.io/doc/user/api.html#nvim_chan_send()
vim.api.nvim_create_user_command("CloseAllterm", function(_)
	if ta:is_open() then
		ta:close()
	end
	if tb:is_open() then
		tb:close()
	end
	if tc:is_open() then
		tc:close()
	end
	if td:is_open() then
		td:close()
	end
	if lazygit:is_open() then
		lazygit:close()
	end
	if tx:is_open() then
		tx:close()
	end
end, {
	desc = "close all opend terminal",
	nargs = 0,
})

vim.api.nvim_create_user_command("JobAndTerm", function(args)
	local args_table = {
		"allterm",
		"singleterm",
		"killsingleterm",
		"killallterm",
		"alljob",
		"onejob",
		"killjob",
		"jobpid",
	}
	local caselist = {
		allterm = function()
			vim.pretty_print(#Term.get_all(true))
			vim.pretty_print(Term.get_all(true))
		end,
		-- singleterm = function(term_id)
		-- 	vim.pretty_print(Term.get(tonumber(term_id[2])))
		-- end,

		singleterm = function(term_name)
			for _, term in ipairs(Term.get_all(true)) do
				if term.user_definename == term_name[2] then
					vim.pretty_print(term)
				end
			end
		end,
		-- killsingleterm = function(term_id)
		-- 	vim.cmd("call jobstop(" .. Term.get(tonumber(term_id[2])).job_id .. ")")
		-- 	vim.pretty_print(Term.get(tonumber(term_id[2])):shutdown())
		-- end,
		killsingleterm = function(term_name)
			for _, term in ipairs(Term.get_all(true)) do
				if term.user_definename == term_name[2] then
					vim.cmd("call jobstop(" .. term.job_id .. ")")
					vim.pretty_print(term:shutdown())
				end
			end
		end,
		killallterm = function()
			for _, term in ipairs(Term.get_all(true)) do
				vim.cmd("call jobstop(" .. term.job_id .. ")")
				vim.pretty_print(term:shutdown())
			end
		end,
		alljob = function()
			vim.pretty_print(#vim.api.nvim_list_chans())
			vim.pretty_print(vim.api.nvim_list_chans())
		end,
		onejob = function(chan_id)
			-- vim.pretty_print(vim.api.nvim_get_chan_info(tonumber(chan_id[2]) or chan_id[2]))
			-- 整除法将字符串转换为integer 数字
			vim.pretty_print(vim.api.nvim_get_chan_info(chan_id[2] / 1))
		end,
		killjob = function(job_id)
			-- error capture ?
			-- local ok, res = pcall(vim.cmd, "call jobstop(" .. job_id[2] .. ")")
			-- if not ok then
			-- 	vim.cmd("echo 'jobstop(" .. job_id[2] .. ")' failed")
			-- end
			vim.cmd("call jobstop(" .. job_id[2] .. ")")
		end,
		jobpid = function(job_id)
			vim.cmd("echo jobpid(" .. job_id[2] .. ")")
		end,
	}
	if vim.tbl_contains(args_table, args.fargs[1]) then
		caselist[args.fargs[1]](args.fargs)
	end
end, {
	desc = "close all opend terminal",
	nargs = "*",
	complete = function(_, L, P)
		-- if L == "JobAndTerm singleterm " then
		-- 	local complete_list = {}
		-- 	for _, v in ipairs(Term.get_all(true)) do
		-- 		table.insert(complete_list, tostring(v.id))
		-- 	end
		-- 	return complete_list
		-- end
		if L == "JobAndTerm singleterm " then
			local complete_list = {}
			for _, v in ipairs(Term.get_all(true)) do
				table.insert(complete_list, v.user_definename)
			end
			return complete_list
		end
		-- if L == "JobAndTerm killsingleterm " then
		-- 	local complete_list = {}
		-- 	for _, v in ipairs(Term.get_all(true)) do
		-- 		table.insert(complete_list, tostring(v.id))
		-- 	end
		-- 	return complete_list
		-- end
		if L == "JobAndTerm killsingleterm " then
			local complete_list = {}
			for _, v in ipairs(Term.get_all(true)) do
				table.insert(complete_list, v.user_definename)
			end
			return complete_list
		end
		if L == "JobAndTerm onejob " then
			local complete_list = {}
			for _, v in ipairs(vim.api.nvim_list_chans()) do
				table.insert(complete_list, tostring(v.id))
			end
			return complete_list
		end
		if L == "JobAndTerm killjob " then
			local complete_list = {}
			for _, v in ipairs(vim.api.nvim_list_chans()) do
				table.insert(complete_list, tostring(v.id))
			end
			return complete_list
		end
		if L == "JobAndTerm jobpid " then
			local complete_list = {}
			for _, v in ipairs(vim.api.nvim_list_chans()) do
				table.insert(complete_list, tostring(v.id))
			end
			return complete_list
		end
		if P == 11 then
			return { "killallterm", "killsingleterm", "allterm", "singleterm", "alljob", "onejob", "killjob", "jobpid" }
		end
	end,
})

require("keybindings").pluginKeys.mapToggleTerm(M)
