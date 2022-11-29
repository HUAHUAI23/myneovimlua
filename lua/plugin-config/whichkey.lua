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

local wk = require("which-key")
wk.register({
	[require("keybindingAlias").telescope.session_load] = {
		"<cmd>Telescope xray23 list<cr>",
		"vim session list",
	},
})
