local status, navic = pcall(require, "nvim-navic")
if not status then
	vim.notify("没有找到 navic")
	return
end
--
navic.setup({
	icons = {
		File = " ",
		Module = " ",
		Namespace = " ",
		-- Package = " ",
		Package = " ",
		Class = " ",
		Method = " ",
		Property = " ",
		Field = " ",
		Constructor = " ",
		Enum = "練",
		Interface = " ",
		Function = " ",
		Variable = " ",
		Constant = " ",
		String = " ",
		Number = " ",
		Boolean = " ",
		Array = " ",
		Object = " ",
		Key = " ",
		Null = "ﳠ ",
		EnumMember = " ",
		Struct = " ",
		Event = " ",
		Operator = " ",
		-- TypeParameter = " ",
		TypeParameter = " ",
	},
	separator = " → ",
	hlight = true,
})
--
