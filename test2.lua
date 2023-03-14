-- for pack, _ in pairs(package.loaded) do
-- 	if string.find(pack, "^" .. vim.pesc("indent_blankline")) then
-- 		vim.pretty_print(pack)
-- 	end
-- end
local luacache = (_G.__luacache or {}).cache
for pack, _ in pairs(package.loaded) do
	if string.find(pack, "^" .. vim.pesc("indent_blankline")) then
		package.loaded[pack] = nil

		if luacache then
			luacache[pack] = nil
		end
	end
end
require("indent_blankline").setup({
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
	filetype_exclude = {
		"null-ls-info",
		"dashboard",
		"packer",
		"terminal",
		"help",
		"log",
		"markdown",
		"TelescopePrompt",
		"lspinfo",
		"mason.nvim",
		"toggleterm",
		"lspsagaoutline",
		"text",
	},
	char = "▏",
})
