-- lspsage offers some interesting stuff eg: outline floatterm
-- TODO:设置saga的高亮组
local status, lspsaga = pcall(require, "lspsaga")

if not status then
	---@diagnostic disable-next-line: param-type-mismatch
	vim.notify("没有找到 lspsaga 插件", "error")
	return
end
lspsaga.setup({
	-- request_timeout = 2000,
	lightbulb = {
		enable = false,
		sign = true,
		virtual_text = false,
	},
	symbol_in_winbar = {
		enable = false,
	},
	-- #1d1536
	ui = {
		border = "rounded",
		code_action = "💡",
	},
	outline = {
		win_width = 30,
	},
})
-- vim.api.nvim_set_hl(0, "SagaBeacon", { fg = "#98c379" })
-- vim.api.nvim_set_hl(0, "SagaBeacon", { fg = "#83a598" })
-- vim.api.nvim_set_hl(0, "SagaBeacon", { fg = "#fe8019" })
vim.api.nvim_set_hl(0, "SagaBeacon", { fg = "#50de60" })
-- test packer lazy load for lspsaga, lazy cmd
-- vim.g.testtt = 1
