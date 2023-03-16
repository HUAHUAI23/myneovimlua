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

-- change webdevicons color
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

-- vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#686C6D", bg = "#EDEDF5" })
vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#686C6D" })

vim.api.nvim_set_hl(0, "MatchParen", { fg = "#f3f3f3", bg = "#7a3e9d", bold = true })

-- indentline
vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#1a1a1a", bg = "none" })
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
-- separator
vim.api.nvim_set_hl(0, "BufferlineCustomeNvimtree", { fg = "#959595", bg = "#c2c2c2", bold = true })
vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator", { fg = "#c2c2c2", bg = "#c2c2c2", bold = true })
vim.api.nvim_set_hl(0, "BufferLineSeparator", { fg = "#c2c2c2", bg = "#d5d5d5", bold = true })
vim.api.nvim_set_hl(0, "BufferLineSeparatorSelected", { fg = "#c2c2c2", bold = true })
vim.api.nvim_set_hl(0, "BufferLineTabSeparator", { fg = "#c2c2c2", bg = "#d5d5d5", bold = true })
vim.api.nvim_set_hl(0, "BufferLineTabSeparatorSelected", { fg = "#c2c2c2", bold = true })
vim.api.nvim_set_hl(0, "BufferLineGroupSeparator", { fg = "#c2c2c2", bg = "#c2c2c2", bold = true })

-- indicator
vim.api.nvim_set_hl(0, "BufferLineIndicatorSelected", { fg = "#959595", bold = true })
vim.api.nvim_set_hl(0, "BufferLineIndicator", { fg = "#959595", bold = true })
vim.api.nvim_set_hl(0, "BufferLineIndicatorVisible", { fg = "#959595", bg = "#DFDFDF", bold = true })

-- button
vim.api.nvim_set_hl(0, "BufferLineCloseButtonSelected", { fg = "#959595", bold = true, sp = "#959595" })
vim.api.nvim_set_hl(0, "BufferLineCloseButton", { fg = "#c2c2c2", bg = "#d5d5d5", bold = true })
vim.api.nvim_set_hl(0, "BufferLineCloseButtonVisible", { fg = "#c2c2c2", bg = "#dfdfdf", bold = true })
vim.api.nvim_set_hl(0, "BufferLineTabClose", { fg = "#c2c2c2", bg = "#d5d5d5", bold = true })

-- fill background
vim.api.nvim_set_hl(0, "BufferLineFill", { fg = "#c2c2c2", bg = "#c2c2c2", bold = true })
vim.api.nvim_set_hl(0, "BufferLineBackground", { fg = "#c2c2c2", bg = "#d5d5d5", bold = true })
vim.api.nvim_set_hl(0, "BufferLineGroupLabel", { fg = "#c2c2c2", bg = "#c2c2c2", bold = true })

-- modifier
vim.api.nvim_set_hl(0, "BufferLineModified", { fg = "#959595", bg = "#d5d5d5", bold = true, sp = "#ca7602" })
vim.api.nvim_set_hl(0, "BufferLineModifiedSelected", { fg = "#959595", bold = true, sp = "#ca7602" })
vim.api.nvim_set_hl(0, "BufferLineModifiedVisible", { fg = "#c2c2c2", bg = "#dfdfdf", bold = true, sp = "#c2c2c2" })

-- visible  5+7
vim.api.nvim_set_hl(0, "BufferLineDiagnosticVisible", { fg = "#aaaaaa", bg = "#dfdfdf" })
vim.api.nvim_set_hl(0, "BufferLineHintDiagnosticVisible", { fg = "#aaaaaa", bg = "#dfdfdf" })
vim.api.nvim_set_hl(0, "BufferLineInfoDiagnosticVisible", { fg = "#aaaaaa", bg = "#dfdfdf" })
vim.api.nvim_set_hl(0, "BufferLineWarningDiagnosticVisible", { fg = "#aaaaaa", bg = "#dfdfdf" })
vim.api.nvim_set_hl(0, "BufferLineErrorDiagnosticVisible", { fg = "#aaaaaa", bg = "#dfdfdf" })

vim.api.nvim_set_hl(0, "BufferLineHintVisible", { fg = "#c2c2c2", bg = "#dfdfdf", bold = true })
vim.api.nvim_set_hl(0, "BufferLineInfoVisible", { fg = "#c2c2c2", bg = "#dfdfdf", bold = true })
vim.api.nvim_set_hl(0, "BufferLineWarningVisible", { fg = "#c2c2c2", bg = "#dfdfdf", bold = true })
vim.api.nvim_set_hl(0, "BufferLineErrorVisible", { fg = "#c2c2c2", bg = "#dfdfdf", bold = true })
vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { fg = "#c2c2c2", bg = "#dfdfdf", bold = true })
vim.api.nvim_set_hl(0, "BufferLineNumbersVisible", { fg = "#c2c2c2", bg = "#dfdfdf", bold = true })
vim.api.nvim_set_hl(0, "BufferLineDuplicateVisible", { fg = "#b8b8b8", bg = "#dfdfdf", bold = true, italic = true })

-- selected 5+7
vim.api.nvim_set_hl(0, "BufferLineDiagnosticSelected", { fg = "#959595", bold = true, italic = true, sp = "#959595" })
vim.api.nvim_set_hl(
	0,
	"BufferLineHintDiagnosticSelected",
	{ fg = "#8d939b", bold = true, italic = true, sp = "#8d939b" }
)
vim.api.nvim_set_hl(
	0,
	"BufferLineInfoDiagnosticSelected",
	{ fg = "#959595", bold = true, italic = true, sp = "#959595" }
)
vim.api.nvim_set_hl(
	0,
	"BufferLineWarningDiagnosticSelected",
	{ fg = "#959595", bold = true, italic = true, sp = "#959595" }
)
vim.api.nvim_set_hl(
	0,
	"BufferLineErrorDiagnosticSelected",
	{ fg = "#9E9E9E", bold = true, italic = true, sp = "#9E9E9E" }
)

vim.api.nvim_set_hl(
	0,
	"BufferLineHintSelected",
	{ fg = "#a1a8b1", bg = "#f3f3f3", bold = true, italic = true, sp = "#a1a8b1" }
)
vim.api.nvim_set_hl(0, "BufferLineInfoSelected", { fg = "#959595", bold = true, italic = true, sp = "#959595" })
vim.api.nvim_set_hl(0, "BufferLineWarningSelected", { fg = "#959595", bold = true, italic = true, sp = "#959595" })
vim.api.nvim_set_hl(0, "BufferLineErrorSelected", { fg = "#9E9E9E", bold = true, italic = true, sp = "#9E9E9E" })
vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { fg = "#959595", bold = true, italic = true, sp = "#959595" })
vim.api.nvim_set_hl(0, "BufferLineNumbersSelected", { fg = "#959595", bold = true, italic = true, sp = "#959595" })
vim.api.nvim_set_hl(0, "BufferLineTabSelected", { fg = "#959595", bg = "#f3f3f3", bold = true })

-- others 5+7
vim.api.nvim_set_hl(0, "BufferLineDiagnostic", { fg = "#aaaaaa", bg = "#d5d5d5", bold = true })
vim.api.nvim_set_hl(0, "BufferLineHintDiagnostic", { fg = "#aaaaaa", bg = "#d5d5d5", bold = true, sp = "#8d939b" })
vim.api.nvim_set_hl(0, "BufferLineInfoDiagnostic", { fg = "#aaaaaa", bg = "#d5d5d5", bold = true, sp = "#3b7b22" })
vim.api.nvim_set_hl(0, "BufferLineWarningDiagnostic", { fg = "#aaaaaa", bg = "#d5d5d5", bold = true, sp = "#b16701" })
vim.api.nvim_set_hl(0, "BufferLineErrorDiagnostic", { fg = "#aaaaaa", bg = "#d5d5d5", bold = true, sp = "#b30000" })

vim.api.nvim_set_hl(0, "BufferLineHint", { fg = "#c2c2c2", bg = "#d5d5d5", bold = true, sp = "#a1a8b1" })
vim.api.nvim_set_hl(0, "BufferLineInfo", { fg = "#c2c2c2", bg = "#d5d5d5", bold = true, sp = "#448c27" })
vim.api.nvim_set_hl(0, "BufferLineWarning", { fg = "#c2c2c2", bg = "#d5d5d5", bold = true, sp = "#ca7602" })
vim.api.nvim_set_hl(0, "BufferLineError", { fg = "#c2c2c2", bg = "#d5d5d5", bold = true, sp = "#cc0000" })
vim.api.nvim_set_hl(0, "BufferLineNumbers", { fg = "#c2c2c2", bg = "#d5d5d5", bold = true })
vim.api.nvim_set_hl(0, "BufferLineTab", { fg = "#c2c2c2", bg = "#d5d5d5", bold = true })
vim.api.nvim_set_hl(0, "BufferLineBuffer", { fg = "#c2c2c2", bg = "#d5d5d5", bold = true })

-- syntax and treesitter

vim.api.nvim_set_hl(0, "@parameter", { fg = "#6d705b" })
vim.api.nvim_set_hl(0, "@parameter.reference", { link = "@parameter" })
vim.api.nvim_set_hl(0, "@variable.builtin", { italic = true, fg = "#7A3E9D" })
vim.api.nvim_set_hl(0, "@method.call", { bold = true, fg = "#6c6c6c" })
vim.api.nvim_set_hl(0, "Conditional", { italic = true, fg = "#6d705b" })
vim.api.nvim_set_hl(0, "@conditional", { italic = true, fg = "#6d705b" })
vim.api.nvim_set_hl(0, "Repeat", { italic = true, fg = "#6d705b" })
vim.api.nvim_set_hl(0, "@repeat", { italic = true, fg = "#6d705b" })
-- vim.api.nvim_set_hl(0, "Comment", { italic = true, fg = "#c2c2c2", bold = true })
-- vim.api.nvim_set_hl(0, "@comment", { italic = true, fg = "#c2c2c2", bold = true })
vim.api.nvim_set_hl(0, "@type.builtin", { bold = true, fg = "#aa3731" })
vim.api.nvim_set_hl(0, "Keyword", { italic = true, fg = "#4B69C6" })
vim.api.nvim_set_hl(0, "Exception", { bold = true, fg = "#aa3731" })
vim.api.nvim_set_hl(0, "@keyword.operator", { bold = true, fg = "#448C27" })
vim.api.nvim_set_hl(0, "NonText", { bold = true, fg = "#EDEDF5" })

-- treesitter-markdown
vim.api.nvim_set_hl(0, "Normal", { fg = "#686C6D", bg = "#f5f5f5" })
vim.api.nvim_set_hl(0, "@text.title", { bold = true, fg = "#535759" })
vim.api.nvim_set_hl(0, "@text.strong", { bold = true, fg = "#686C6D" })
-- vim.api.nvim_set_hl(0, "@text.literal", { fg = "#656A6C", bg = "#EFF1F3" })
vim.api.nvim_set_hl(0, "@text.literal", { fg = "#656A6C", bg = "#EDEDF5" })
vim.api.nvim_set_hl(0, "@text.reference", { fg = "#6886AA", bold = true })
vim.api.nvim_set_hl(0, "@text.uri", { fg = "#6886AA" })
vim.api.nvim_set_hl(0, "@punctuation.special", { fg = "#919394", bold = true })
vim.api.nvim_set_hl(0, "@text.quote", { fg = "#A7A9AA", bg = "#EDEDF5" })
vim.api.nvim_set_hl(0, "SpellBad", { undercurl = true })
vim.api.nvim_set_hl(0, "SpellLocal", { underline = true })
