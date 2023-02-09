vim.opt.runtimepath:append("/home/i42/pro/vimPlug/theme/*")
vim.o.t_Co = 256
vim.opt.termguicolors = true

vim.o.background = "light"

local colorscheme = "quietlight"

---@diagnostic disable-next-line: param-type-mismatch
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
	return
end
vim.cmd("highlight clear ColorColumn")
-- local palette = { darkpurple = "#5f005f" }
-- vim.api.nvim_set_hl(0, "Keyword", { fg = palette.darkpurple, bg = "none" })
