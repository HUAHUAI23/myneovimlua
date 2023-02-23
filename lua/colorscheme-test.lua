vim.opt.runtimepath:append("/home/i42/pro/vimPlug/theme/*")
vim.o.t_Co = 256
vim.opt.termguicolors = true

vim.o.background = "light"
-- vim.o.background = "dark"

local colorscheme = "quietlight"

---@diagnostic disable-next-line: param-type-mismatch
local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
	vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
	return
end
vim.cmd("highlight clear ColorColumn")
-- local palette = { darkpurple = "#5f005f" }
-- vim.api.nvim_set_hl(0, "Keyword", { fg = palette.darkpurple, bg = "none" })
-- vim.api.nvim_set_hl(0, "Normal", { fg = "#333333", bg = "#f3f3f3" })
-- vim.api.nvim_set_hl(0, "Normal", { fg = "#333333", bg = "#f2f2f2" })
-- vim.api.nvim_set_hl(0, "Normal", { fg = "#333333", bg = "#f0f0f0" })
vim.api.nvim_set_hl(0, "WarningMsg", { fg = "#777777", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeNormal", { fg = "#333333", bg = "#EDEDF5" })
vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { fg = "#333333", bg = "#EDEDF5" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#6d705b", bg = "#f3f3f3" })
vim.api.nvim_set_hl(0, "VertSplit", { fg = "#f3f3f3", bg = "#f3f3f3" })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#333333", bg = "#EDEDF5" })

-- indentline
vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#9E9E9E", bg = "none" })
vim.api.nvim_set_hl(0, "IndentBlanklineSpaceCharBlankline", { ctermfg = 142, fg = "#D9D9D9", nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineSpaceChar", { ctermfg = 142, fg = "#D9D9D9", nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineChar", { ctermfg = 142, fg = "#D9D9D9", nocombine = true })
