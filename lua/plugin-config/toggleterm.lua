local status, toggleterm = pcall(require, "toggleterm")
if not status then
	vim.notify("没有找到 toggleterm")
	return
end

toggleterm.setup({
	size = function(term)
		if term.direction == "horizontal" then
			return vim.o.lines * 0.35
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.3
		end
	end,
	start_in_insert = true,
	highlights = {
		FloatBorder = {
			link = "FloatBorder",
		},
	},
})
local Terminal = require("toggleterm.terminal").Terminal

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
	-- function to run on opening the terminal
	---@diagnostic disable-next-line: unused-local
	on_open = function(term)
		vim.cmd("startinsert!")
	end,
})

local ta = Terminal:new({
	direction = "float",
	float_opts = {
		border = "rounded",
	},
	close_on_exit = true,
	-- function to run on opening the terminal
	---@diagnostic disable-next-line: unused-local
	on_open = function(term)
		vim.cmd("startinsert!")
	end,
})

local tb = Terminal:new({
	direction = "vertical",
	close_on_exit = true,
	-- function to run on opening the terminal
	---@diagnostic disable-next-line: unused-local
	on_open = function(term)
		vim.cmd("startinsert!")
	end,
})

local tc = Terminal:new({
	direction = "horizontal",
	close_on_exit = true,
	-- function to run on opening the terminal
	---@diagnostic disable-next-line: unused-local
	on_open = function(term)
		vim.cmd("startinsert!")
	end,
})

local M = {}

M.toggleA = function(cmd)
	if ta:is_open() then
		ta:close()
		return
	end
	tb:close()
	tc:close()
	lazygit:close()
	ta:open()
	if cmd ~= nil then
		ta:send(cmd)
	end
end

M.toggleB = function()
	if tb:is_open() then
		tb:close()
		return
	end
	ta:close()
	tc:close()
	lazygit:close()
	tb:open()
end

M.toggleC = function()
	if tc:is_open() then
		tc:close()
		return
	end
	ta:close()
	tb:close()
	lazygit:close()
	tc:open()
end

M.toggleG = function()
	if lazygit:is_open() then
		lazygit:close()
		return
	end
	ta:close()
	tb:close()
	tc:close()
	lazygit:open()
end

require("keybindings").pluginKeys.mapToggleTerm(M)
