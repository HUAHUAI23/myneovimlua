---@diagnostic disable-next-line: unused-local
local api = vim.api
vim.o.t_Co = 256
vim.opt.termguicolors = true

vim.g.lumiere_dim_inactive_windows = 0

vim.o.background = "dark"
local colorscheme = "lumiere"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
	return
end

api.nvim_set_hl(0, "Normal", { fg = "#424242", bg = "#e4e4e4" })
