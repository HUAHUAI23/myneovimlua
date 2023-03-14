-- vim.opt.background = "dark"
-- require("nvim-tundra").setup({
-- 	transparent_background = true,
-- 	plugins = {
-- 		lsp = true,
-- 		treesitter = true,
-- 		cmp = true,
-- 		context = true,
-- 		dbui = true,
-- 		gitsigns = true,
-- 		telescope = true,
-- 	},
-- 	syntax = {
-- 		booleans = { bold = true, italic = true },
-- 		comments = { bold = true, italic = true },
-- 		conditionals = {},
-- 		constants = { bold = true },
-- 		fields = {},
-- 		functions = { bold = true },
-- 		keywords = {},
-- 		loops = {},
-- 		numbers = { bold = true },
-- 		operators = { bold = true },
-- 		punctuation = {},
-- 		strings = { italic = true },
-- 		types = { italic = true },
-- 	},
-- })
--
-- local colorscheme = "tundra"
-- ---@diagnostic disable-next-line: param-type-mismatch
-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- if not status_ok then
-- 	vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
-- 	return
-- end

-- vim.o.t_Co = 256
-- -- vim.o.termguicolors = true
-- vim.opt.termguicolors = true
-- vim.o.t_ut = ""
-- vim.o.t_ul = ""
--
-- vim.o.t_8f = "<Esc>[38;2;%lu;%lu;%lum"
-- vim.o.t_8b = "<Esc>[48;2;%lu;%lu;%lum"
--
-- -- 已经定义在basic.lua文件中
-- -- vim.opt.list = false
-- -- vim.opt.listchars:append("space:⋅")
-- -- vim.opt.listchars:append("eol:↴")
--
-- vim.o.background = "dark"
-- local colorscheme = "deus"
-- ---@diagnostic disable-next-line: param-type-mismatch
-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- if not status_ok then
-- 	---@diagnostic disable-next-line: param-type-mismatch
-- 	vim.notify("colorscheme: " .. colorscheme .. " 没有找到！", "error")
-- 	return
-- end
-- vim.g.deus_termcolors = 256
vim.o.termguicolors = true
vim.opt.runtimepath:append("/home/i42/pro/test/visual_studio_code")
require("visual_studio_code").setup({
	mode = "dark",
})
vim.cmd("colorscheme colors")
