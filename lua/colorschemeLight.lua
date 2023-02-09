vim.o.t_Co = 256
vim.opt.termguicolors = true
vim.o.background = "light"
local caselist = {
	a = function()
		local colorscheme = "iceberg"
		---@diagnostic disable-next-line: param-type-mismatch
		local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
		if not status_ok then
			vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
			return
		end
		vim.cmd("highlight clear ColorColumn")
		vim.api.nvim_set_hl(0, "SignColumn", { fg = "#9fa7bd", bg = "none" })
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#9fa7bd", bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#3f83a6", bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#8389a3", bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#c57339", bg = "none" })
		vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#cc517a", bg = "none" })
		-- vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#747ca4", bold = true })
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#9fa7bd", bg = "none", bold = true })
		vim.api.nvim_set_hl(0, "VertSplit", { fg = "#9fa7bd", bg = "none", bold = true })
		-- vim.api.nvim_set_hl(0, "Cursor", { fg = "#ffffff", bg = "#ffffff", bold = true })
	end,
	b = function()
		local colorscheme = "quietlight"

		---@diagnostic disable-next-line: param-type-mismatch
		local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
		if not status_ok then
			vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
			return
		end
		vim.cmd("highlight clear ColorColumn")
	end,
}

caselist["b"]()
