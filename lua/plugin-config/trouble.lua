local status, trouble = pcall(require, "trouble")
if not status then
	vim.notify("ζ²‘ζζΎε° trouble.nvim")
	return
end
trouble.setup({
	signs = {
		-- icons / text used for a diagnostic
		error = "π€",
		-- error = "π₯΅",
		-- warning = "π’",
		warning = "π¦",
		hint = "π",
		information = "π€",
		other = "π€¨",
	},
})
