vim.opt.background = "dark"
require("nvim-tundra").setup({
	transparent_background = true,
	plugins = {
		lsp = true,
		treesitter = true,
		cmp = true,
		context = true,
		dbui = true,
		gitsigns = true,
		telescope = true,
	},
	syntax = {
		booleans = { bold = true, italic = true },
		comments = { bold = true, italic = true },
		conditionals = {},
		constants = { bold = true },
		fields = {},
		functions = { bold = true },
		keywords = {},
		loops = {},
		numbers = { bold = true },
		operators = { bold = true },
		punctuation = {},
		strings = { italic = true },
		types = { italic = true },
	},
})

local colorscheme = "tundra"
---@diagnostic disable-next-line: param-type-mismatch
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
	return
end
