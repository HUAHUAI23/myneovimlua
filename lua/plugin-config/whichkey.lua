local status, whichkey = pcall(require, "which-key")
if not status then
	vim.notify("没有找到 which-key")
	return
end
-- disable some operators
local presets = require("which-key.plugins.presets")
presets.operators["v"] = nil

whichkey.setup({
	window = {
		border = "rounded", -- none, single, double, shadow
	},
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		["<space>"] = "SPC",
		["<cr>"] = "RET",
		["<tab>"] = "TAB",
	},
	disable = {
		buftypes = {},
		filetypes = { "TelescopePrompt" },
	},
})
-- local wk = require("which-key")
-- wk.register({
-- 	f = {
-- 		name = "file", -- optional group name
-- 		f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
-- 		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap = false }, -- additional options for creating the keymap
-- 		n = { "New File" }, -- just a label. don't create any mapping
-- 		e = "Edit File", -- same as above
-- 		["1"] = "which_key_ignore", -- special label to hide it in the popup
-- 		b = {
-- 			function()
-- 				print("bar")
-- 			end,
-- 			"Foobar",
-- 		}, -- you can also pass functions!
-- 	},
-- }, { prefix = "<leader>" })
