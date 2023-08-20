local status, aerial = pcall(require, "aerial")
if not status then
	vim.notify("没有找到 aerial")
	return
end
aerial.setup({
	backends = { "lsp", "treesitter", "markdown", "man" },
	-- optionally use on_attach to set keymaps when aerial has attached to a buffer
	on_attach = function(bufnr)
		-- Jump forwards/backwards with '{' and '}'
		vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
		vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
	end,
	layout = {
		max_width = { 80, 0.5 },
		width = 0.3,
		min_width = 10,
		default_direction = "prefer_right",
		resize_to_content = true,
	},
})
