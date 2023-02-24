vim.opt.runtimepath:append("/home/i42/pro/vimPlug/theme/*")
vim.o.t_Co = 256
vim.opt.termguicolors = true

vim.o.background = "light"
-- vim.o.background = "dark"

local colorscheme = "quietlight"

---@diagnostic disable-next-line: param-type-mismatch
local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
	vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
	return
end

local a = require("nvim-web-devicons").get_icons()
for _, v in pairs(a) do
	vim.api.nvim_set_hl(0, "DevIcon" .. v.name, { fg = "#6C6C6C" })
end

vim.cmd("highlight clear ColorColumn")
-- local palette = { darkpurple = "#5f005f" }
-- #f2f2f2 #333333 #777777 #424242 #6d705b #9E9E9E #EDEDF5 #D9D9D9 #959595 #DBD1EB #c2c2c2 #dfdfdf
-- #6C6C6C
-- vim.api.nvim_set_hl(0, "Keyword", { fg = palette.darkpurple, bg = "none" })
vim.api.nvim_set_hl(0, "WarningMsg", { fg = "#777777", bold = true })
-- cmd
vim.api.nvim_set_hl(0, "MsgArea", { fg = "#424242" })
vim.api.nvim_set_hl(0, "MoreMsg", { fg = "#424242", bold = true })
vim.api.nvim_set_hl(0, "Question", { fg = "#448c27", bold = true })

vim.api.nvim_set_hl(0, "LineNr", { fg = "#6d705b", bg = "#f3f3f3" })

vim.api.nvim_set_hl(0, "VertSplit", { fg = "#9E9E9E", bold = true })

vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#424242", bg = "#EDEDF5" })

vim.api.nvim_set_hl(0, "MatchParen", { fg = "#f3f3f3", bg = "#7a3e9d", bold = true })

-- indentline
vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#9E9E9E", bg = "none" })
vim.api.nvim_set_hl(0, "IndentBlanklineSpaceCharBlankline", { ctermfg = 142, fg = "#D9D9D9", nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineSpaceChar", { ctermfg = 142, fg = "#D9D9D9", nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineChar", { ctermfg = 142, fg = "#D9D9D9", nocombine = true })

-- nvimtree
vim.api.nvim_set_hl(0, "NvimTreeNormal", { fg = "#959595", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = "#959595", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#959595", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsInformation", { fg = "#959595", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsHint", { fg = "#959595", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsWarning", { fg = "#959595", bold = true })
vim.api.nvim_set_hl(0, "NvimTreeLspDiagnosticsError", { fg = "#959595", bold = true })

-- gitsigns
vim.api.nvim_set_hl(0, "GitSignsChange", { bg = "none", fg = "#959595", bold = true })
vim.api.nvim_set_hl(0, "GitSignsAdd", { bg = "none", fg = "#c2c2c2", bold = true })
vim.api.nvim_set_hl(0, "GitSignsDelete", { bg = "none", fg = "#9e9e9e", bold = true })

-- bufferline
vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator", { fg = "#c2c2c2", bg = "#c2c2c2", bold = true })
vim.api.nvim_set_hl(0, "BufferlineCustomeNvimtree", { fg = "#959595", bg = "#c2c2c2", bold = true })
vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { fg = "#959595", bold = true })
vim.api.nvim_set_hl(0, "BufferLineIndicator", { fg = "#959595", bold = true })
vim.api.nvim_set_hl(0, "BufferLineIndicatorVisible", { fg = "#959595", bg = "#DFDFDF", bold = true })

vim.api.nvim_set_hl(
	0,
	"BufferLineWarningDiagnosticSelected",
	{ fg = "#959595", bold = true, italic = true, sp = "#959595" }
)
vim.api.nvim_set_hl(0, "BufferLineWarningSelected", { fg = "#959595", bold = true, italic = true, sp = "#959595" })
vim.api.nvim_set_hl(
	0,
	"BufferLineInfoDiagnosticSelected",
	{ fg = "#959595", bold = true, italic = true, sp = "#959595" }
)

vim.api.nvim_set_hl(0, "BufferLineInfoSelected", { fg = "#959595", bold = true, italic = true, sp = "#959595" })
vim.api.nvim_set_hl(
	0,
	"BufferLineErrorDiagnosticSelected",
	{ fg = "#9E9E9E", bold = true, italic = true, sp = "#9E9E9E" }
)
vim.api.nvim_set_hl(0, "BufferLineErrorSelected", { fg = "#9E9E9E", bold = true, italic = true, sp = "#9E9E9E" })

vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = "#959595", bold = true, italic = true, sp = "#959595" })
vim.api.nvim_set_hl(0, "BufferLineCloseButtonSelected", { fg = "#959595", bold = true, sp = "#959595" })

-- syntax and treesitter

vim.api.nvim_set_hl(0, "@parameter", { fg = "#424242" })
vim.api.nvim_set_hl(0, "@parameter.reference", { link = "@parameter" })
vim.api.nvim_set_hl(0, "@variable.builtin", { italic = true, fg = "#7A3E9D" })
vim.api.nvim_set_hl(0, "@method.call", { bold = true, fg = "#6c6c6c" })
vim.api.nvim_set_hl(0, "Conditional", { italic = true, fg = "#6d705b" })
vim.api.nvim_set_hl(0, "@conditional", { italic = true, fg = "#6d705b" })
vim.api.nvim_set_hl(0, "Repeat", { italic = true, fg = "#6d705b" })
vim.api.nvim_set_hl(0, "@repeat", { italic = true, fg = "#6d705b" })
-- vim.api.nvim_set_hl(0, "Comment", { italic = true, fg = "#c2c2c2", bold = true })
-- vim.api.nvim_set_hl(0, "@comment", { italic = true, fg = "#c2c2c2", bold = true })

-- TODO:
-- 整体语法高亮调整
-- float窗口 高亮调整
