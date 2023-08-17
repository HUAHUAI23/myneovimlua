local rainbow_delimiters = require("rainbow-delimiters")

vim.g.rainbow_delimiters = {
	strategy = {
		[""] = rainbow_delimiters.strategy["global"],
		vim = rainbow_delimiters.strategy["local"],
	},
	query = {
		[""] = "rainbow-delimiters",
		lua = "rainbow-blocks",
	},
	highlight = {
		"RainbowDelimiterRed",
		"RainbowDelimiterYellow",
		"RainbowDelimiterBlue",
		"RainbowDelimiterOrange",
		"RainbowDelimiterGreen",
		"RainbowDelimiterViolet",
		"RainbowDelimiterCyan",
	},
}

-- #ee6985 #C678DD
vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#98C379" })
vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#83a598" })
vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#ebdbb2" })
vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#fe8019" })
vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#83a598" })
vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#98C379" })
vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#ffa6ff" })
