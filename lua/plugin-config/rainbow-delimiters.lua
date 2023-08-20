local status, rainbow_delimiters = pcall(require, "rainbow-delimiters")
if not status then
	vim.notify("没有找到 rainbow_delimiters")
	return
end
local commConf = require("commConf")

vim.g.rainbow_delimiters = {
	strategy = {
		-- [""] = rainbow_delimiters.strategy["global"],
		vim = rainbow_delimiters.strategy["local"],
		[""] = function()
			-- Disabled for very large files, global strategy for large files,
			-- local strategy otherwise
			local max_filesize = commConf.largefileEdge -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
			if ok and stats and stats.size > max_filesize then
				return nil
			end

			if vim.fn.line("$") > 10000 then
				return nil
			elseif vim.fn.line("$") > 1000 then
				return rainbow_delimiters.strategy["global"]
			end
			return rainbow_delimiters.strategy["local"]
			-- return rainbow_delimiters.strategy["global"]
		end,
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
vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#fb4934" })
vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#83a598" })
vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#98C379" })
vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#ebdbb2" })
