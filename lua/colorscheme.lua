-- https://zhuanlan.zhihu.com/p/20718108
-- hi 样式名称 guifg=Gvim字体颜色 guibg=Gvim背景颜色 ctermfg=终端Vim字体颜色 ctermbg=终端Vim背景颜色 gui=Gvim字体样式 cterm=终端Vim字体样式
-- hi 的意思是 highlight，也就是它的缩写。 Normal 代表初始化时候的样式，
-- 常规样式， guifg 意思是，在 GVim 中（带有图形界面的Vim） ，字体的颜色是#990808 ，
-- 而 guibg 意思就是 背景色是black黑色，
-- ctermfg 代表了 vim 在 Linux 下的 terminal 终端里的字体配色，
-- terminal 只有 256色， 所以具体， 你需要查询 256 色值表，每个数字具体代表了什么颜色，
-- 而最后的 gui cterm 则是代表了字体的样式，你可以设置为bold(粗体) , 也可以设置为none(常规)

-- 在使用完colorscheme后再使用，若在之前使用，则会被colorscheme覆盖
-- 定义一些高亮组的颜色 see :h highlight
-- vim.cmd([[
--     highlight NonText ctermfg=gray guifg=grey50
--     hi SignColumn ctermbg=None guibg=None
--     hi VertSplit ctermfg=None ctermbg=None cterm=None guibg=None guifg=None
--     ]])

-- #2C323B #242a32 -- editor background
-- #FF0000 #fb4934 #B5E8B0 #ebdbb2 #fe8019 #a89984 #b8bb26 #d3869b
-- #8ec07c #98c379 #990808 #990606 #B30909 #fabd2f #aaaaaa #ffa6ff
-- #83a598 #c678dd #928374 #fff073 "LigthGrey"
vim.o.t_Co = 256
-- vim.o.termguicolors = true
vim.opt.termguicolors = true
vim.o.t_ut = ""
vim.o.t_ul = ""

vim.o.t_8f = "<Esc>[38;2;%lu;%lu;%lum"
vim.o.t_8b = "<Esc>[48;2;%lu;%lu;%lum"

-- 已经定义在basic.lua文件中
-- vim.opt.list = false
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

vim.o.background = "dark"
local colorscheme = "deus"
---@diagnostic disable-next-line: param-type-mismatch
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	---@diagnostic disable-next-line: param-type-mismatch
	vim.notify("colorscheme: " .. colorscheme .. " 没有找到！", "error")
	return
end
vim.g.deus_termcolors = 256

-- default mode
local mode = "camellia"
local function set_editor_hl()
	-- editor
	vim.api.nvim_set_hl(0, "NonText", { ctermfg = 142, fg = "grey50", bold = true })

	vim.api.nvim_set_hl(0, "SignColumn", { ctermbg = "none", bg = "none" })

	vim.api.nvim_set_hl(0, "VertSplit", { ctermfg = 245, fg = "#928374", bold = true })
	-- vim.api.nvim_set_hl(0, "VertSplit", { bg = "#2C323B", ctermbg = "none", ctermfg = 246, fg = "#ebdbb2" })
	-- api.nvim_set_hl(0, "VertSplit", { bg = "none", ctermbg = "none", ctermfg = 246, fg = "#a89984" })

	vim.api.nvim_set_hl(
		0,
		"CursorLineNr",
		{ ctermfg = 208, ctermbg = 239, bg = "#242a32", fg = "#fe8019", bold = true }
	)
	vim.api.nvim_set_hl(0, "SpecialKey", { ctermfg = 208, fg = "#fe8019", bold = true })
	-- vim.api.nvim_set_hl(0, "SpecialKey", { fg = "#B5E8B0", bold = true })
	-- Search impact yank highlight
	vim.api.nvim_set_hl(0, "Search", { ctermbg = 214, ctermfg = 235, bg = "#fe8019", fg = "White", bold = true })

	vim.api.nvim_set_hl(
		0,
		"SpellLocal",
		{ undercurl = true, ctermbg = 214, ctermfg = 235, bg = "#B5E8B0", fg = "Grey", bold = true, sp = "#B5E8B0" }
	)
	-- #ffa6ff
	vim.api.nvim_set_hl(
		0,
		"SpellRare",
		{ undercurl = true, ctermbg = 214, ctermfg = 235, bg = "#ff0000", fg = "#f5f5f5", bold = true, sp = "#ff0000" }
	)
end
local function set_gitsigns_hl()
	-- gitsigns
	-- #b8bb26 #d3869b
	vim.api.nvim_set_hl(0, "GitSignsAdd", { ctermfg = 142, ctermbg = 239, bg = "none", fg = "#98c379" })
	-- vim.api.nvim_set_hl(0, "GitSignsChange", { ctermfg = 108, ctermbg = 239, bg = "none", fg = "#8ec07c" })
	vim.api.nvim_set_hl(0, "GitSignsChange", { ctermfg = 108, ctermbg = 239, bg = "none", fg = "#B5E8B0" })
	-- vim.api.nvim_set_hl(0, "GitSignsAdd", { ctermfg = 142, ctermbg = 239, bg = "none", fg = "#b8bb26" })
	-- vim.api.nvim_set_hl(0, "GitSignsChange", { ctermfg = 108, ctermbg = 239, bg = "none", fg = "#d3869b" })
	vim.api.nvim_set_hl(0, "GitSignsDelete", { ctermfg = 167, ctermbg = 239, bg = "none", fg = "#fb4934" })
end
local function set_nvimtree_hl()
	-- nvimtree
	vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { link = "deusGreenBold" })
end
local function set_navic_hl()
	-- navic
	vim.api.nvim_set_hl(0, "NavicIconsFile", { default = true, fg = "#FBC19D", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsModule", { default = true, fg = "#FECDD3", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsNamespace", { default = true, fg = "#A5B4FC", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsPackage", { default = true, fg = "#BF7471", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsClass", { default = true, fg = "#DDD6FE", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsMethod", { default = true, fg = "#BF7471", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsProperty", { default = true, fg = "#ebdbb2", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsField", { default = true, fg = "#D1D5DB", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsConstructor", { default = true, fg = "#B5E8B0", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsEnum", { default = true, fg = "#fe8019", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsInterface", { default = true, fg = "#fe8019", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsFunction", { default = true, fg = "#DDD6FE", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsVariable", { default = true, fg = "#E8D4B0", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsConstant", { default = true, fg = "#99BBBD", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsString", { default = true, fg = "#BAE6FD", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsNumber", { default = true, fg = "#D1D5DB", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsBoolean", { default = true, fg = "#9CA3AF", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsArray", { default = true, fg = "#fdb095", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsObject", { default = true, fg = "#FFFFFF", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsKey", { default = true, fg = "#E5E7EB", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsNull", { default = true, fg = "#DDD6FE", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsEnumMember", { default = true, fg = "#BF7471", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsStruct", { default = true, fg = "#FCA5A5", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsEvent", { default = true, fg = "#FECDD3", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsOperator", { default = true, fg = "#FBC19D", bold = true })
	vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { default = true, fg = "#ffa6ff", bold = true })

	-- vim.api.nvim_set_hl(0, "NavicText", { default = true, fg = "#ff4090", bold = true })
	vim.api.nvim_set_hl(0, "NavicText", { default = true, fg = "LightGrey", bold = true })

	vim.api.nvim_set_hl(0, "NavicSeparator", { default = true, fg = "#f5b3b3", bold = true })
end
local function set_notify_hl()
	-- notify
	vim.api.nvim_set_hl(0, "NotifyERRORTitle", { ctermfg = 167, fg = "#ff0000", bold = true })
	vim.api.nvim_set_hl(0, "NotifyERRORIcon", { ctermfg = 167, fg = "#ff0000", bold = true })
	vim.api.nvim_set_hl(0, "NotifyERRORBorder", { ctermfg = 167, fg = "#ff0000", bold = true })
	vim.api.nvim_set_hl(0, "NotifyWARNTitle", { ctermfg = 208, fg = "#fe8019", bold = true })
	vim.api.nvim_set_hl(0, "NotifyWARNIcon", { ctermfg = 208, fg = "#fe8019", bold = true })
	vim.api.nvim_set_hl(0, "NotifyWARNBorder", { ctermfg = 208, fg = "#fe8019", bold = true })
	vim.api.nvim_set_hl(0, "NotifyINFOTitle", { ctermfg = 142, fg = "#B5E8B0", bold = true })
	vim.api.nvim_set_hl(0, "NotifyINFOIcon", { ctermfg = 142, fg = "#B5E8B0", bold = true })
	vim.api.nvim_set_hl(0, "NotifyINFOBorder", { ctermfg = 142, fg = "#B5E8B0", bold = true })
end
local function set_indenline_hl()
	-- indentline
	vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "LightGrey", bg = "none" })
	vim.api.nvim_set_hl(0, "IndentBlanklineSpaceCharBlankline", { ctermfg = 142, fg = "#928374", nocombine = true })
	vim.api.nvim_set_hl(0, "IndentBlanklineSpaceChar", { ctermfg = 142, fg = "#928374", nocombine = true })
	vim.api.nvim_set_hl(0, "IndentBlanklineChar", { ctermfg = 142, fg = "#928374", nocombine = true })
end
local function set_lsp_hl()
	-- lsp
	vim.api.nvim_set_hl(0, "LspReferenceText", { fg = "#B5E8B0" })
	vim.api.nvim_set_hl(0, "LspReferenceRead", { fg = "#B5E8B0" })
	vim.api.nvim_set_hl(0, "LspReferenceWrite", { fg = "#B5E8B0" })
	vim.api.nvim_set_hl(0, "LspCodeLens", { fg = "#928374" })
	vim.api.nvim_set_hl(0, "LspCodeLensSeparator", { fg = "LightGrey" })
	vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", { fg = "#ffa6ff" })

	vim.api.nvim_set_hl(0, "DiagnosticError", { ctermfg = 1, fg = "Red", bold = true })
	vim.api.nvim_set_hl(0, "DiagnosticWarn", { ctermfg = 3, fg = "Orange", bold = true })
	vim.api.nvim_set_hl(0, "DiagnosticInfo", { ctermfg = 4, fg = "LightBlue", bold = true })
	vim.api.nvim_set_hl(0, "DiagnosticHint", { ctermfg = 7, fg = "LightGrey", bold = true })

	vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { standout = true, strikethrough = true, sp = "Red" })
	vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { standout = true, sp = "Orange" })
end

set_editor_hl()
set_lsp_hl()
set_gitsigns_hl()
set_notify_hl()
set_indenline_hl()
set_nvimtree_hl()
set_navic_hl()

local function setsyntax()
	-- #990808 #aaaaaa #990606 #B30909
	-- sytax
	vim.api.nvim_set_hl(0, "Comment", { ctermfg = 245, fg = "#928374" })
	vim.api.nvim_set_hl(0, "Constant", { ctermfg = 175, fg = "#c678dd", bold = true })
	vim.api.nvim_set_hl(0, "String", { ctermfg = 142, fg = "#98c379", italic = true })
	vim.api.nvim_set_hl(0, "Identifier", { ctermfg = 109, fg = "#83a598" })

	vim.api.nvim_set_hl(0, "Function", { ctermfg = 142, fg = "#98c379", bold = true })
	-- vim.api.nvim_set_hl(0, "Function", { ctermfg = 142, fg = "#B5E8B0", bold = true })

	vim.api.nvim_set_hl(0, "Statement", { ctermfg = 167, fg = "#fb4934" })
	vim.api.nvim_set_hl(0, "Operator", { ctermfg = 223, fg = "#ebdbb2", bold = true })
	vim.api.nvim_set_hl(0, "keyword", { ctermfg = 167, fg = "#fb4934", bold = true })

	vim.api.nvim_set_hl(0, "PreProc", { ctermfg = 108, fg = "#8ec07c", bold = true, italic = true })
	-- vim.api.nvim_set_hl(0, "PreProc", { ctermfg = 108, fg = "#B5E8B0", bold = true, italic = true })

	vim.api.nvim_set_hl(0, "Type", { ctermfg = 214, fg = "#fabd2f", bold = true })
	vim.api.nvim_set_hl(0, "StorageClass", { ctermfg = 208, fg = "#fe8019" })
	vim.api.nvim_set_hl(0, "Structure", { ctermfg = 108, fg = "#8ec07c" })
	vim.api.nvim_set_hl(0, "Typedef", { ctermfg = 214, fg = "#fabd2f" })
	vim.api.nvim_set_hl(0, "Special", { ctermfg = 208, fg = "#fe8019" })
	vim.api.nvim_set_hl(0, "Repeat", { ctermfg = 167, fg = "#fb4934" })
	vim.api.nvim_set_hl(0, "Boolean", { ctermfg = 175, fg = "#c678dd", bold = true, italic = true })
	vim.api.nvim_set_hl(0, "Conditional", { ctermfg = 167, fg = "#fb4934" })
	vim.api.nvim_set_hl(0, "Number", { ctermfg = 175, fg = "#c678dd", bold = true })
	vim.api.nvim_set_hl(0, "Float", { ctermfg = 175, fg = "#c678dd", bold = true })

	-- vim.api.nvim_set_hl(0, "Exception", { ctermfg = 167, fg = "#fb4934", bold = true })
	vim.api.nvim_set_hl(0, "Exception", { fg = "#B30909", bold = true })
	-- vim.api.nvim_set_hl(0, "Exception", { fg = "#FF0000", bold = true })

	vim.api.nvim_set_hl(0, "Macro", { ctermfg = 108, fg = "#8ec07c", bold = true })
	vim.api.nvim_set_hl(0, "Delimiter", { ctermfg = 208, fg = "#fe8019" })
	vim.api.nvim_set_hl(0, "Character", { link = "Delimiter" })
	vim.api.nvim_set_hl(0, "Label", { link = "Statement" })
	vim.api.nvim_set_hl(0, "Include", { link = "PreProc" })
	vim.api.nvim_set_hl(0, "Define", { link = "PreProc" })
	vim.api.nvim_set_hl(0, "PreCondit", { link = "PreProc" })
	vim.api.nvim_set_hl(0, "SpecialChar", { link = "Special" })
	vim.api.nvim_set_hl(0, "Tag", { link = "Special" })
	vim.api.nvim_set_hl(0, "SpecialComment", { link = "Special" })
	vim.api.nvim_set_hl(0, "Debug", { link = "Special" })
end

local caseList = {
	camellia = function()
		setsyntax()
		-- treesitter
		-- #990808  #aaaaaa #b8bb26 #d3869b #B5E8B0 #FF0000 #ff4090

		-- Punctuation.
		vim.api.nvim_set_hl(0, "@punct.delimiter", { link = "Delimiter" })
		vim.api.nvim_set_hl(0, "@punct.bracket", { link = "Delimiter" })
		vim.api.nvim_set_hl(0, "@punct.special", { link = "Delimiter" })
		-- Literals.
		vim.api.nvim_set_hl(0, "@string", { link = "String" })
		vim.api.nvim_set_hl(0, "@string.regex", { fg = "#ff4090", italic = true })
		vim.api.nvim_set_hl(0, "@string.escape", { fg = "#B5E8B0", italic = true })
		vim.api.nvim_set_hl(0, "@string.special", { fg = "#B5E8B0", italic = true, bold = true })
		vim.api.nvim_set_hl(0, "@character", { link = "SpecialKey" })
		vim.api.nvim_set_hl(0, "@character.special", { link = "SpecialKey" })
		vim.api.nvim_set_hl(0, "@number", { link = "Number" })
		vim.api.nvim_set_hl(0, "@float", { link = "Float" })
		vim.api.nvim_set_hl(0, "@boolean", { link = "Boolean" })
		-- Functions
		vim.api.nvim_set_hl(0, "@function", { link = "Function" })
		vim.api.nvim_set_hl(0, "@method", { link = "Function" })
		vim.api.nvim_set_hl(0, "@method.call", { link = "Function" })
		vim.api.nvim_set_hl(0, "@constructor", { link = "Function" })
		vim.api.nvim_set_hl(0, "@parameter", { fg = "#aaaaaa" })
		vim.api.nvim_set_hl(0, "@parameter.reference", { link = "@parameter" })

		-- Keywords.
		vim.api.nvim_set_hl(0, "@keyword", { link = "Keyword" })
		vim.api.nvim_set_hl(0, "@keyword.function", { link = "Keyword" })
		vim.api.nvim_set_hl(0, "@keyword.operator", { link = "Exception" })
		vim.api.nvim_set_hl(0, "@keyword.return", { link = "Exception" })
		vim.api.nvim_set_hl(0, "@conditional", { link = "Conditional" })
		vim.api.nvim_set_hl(0, "@repeat", { link = "Repeat" })
		vim.api.nvim_set_hl(0, "@debug", { link = "Debug" })
		vim.api.nvim_set_hl(0, "@label", { link = "Label" })
		vim.api.nvim_set_hl(0, "@include", { link = "Include" })
		vim.api.nvim_set_hl(0, "@exception", { link = "Exception" })
		-- Type
		vim.api.nvim_set_hl(0, "@type", { link = "Type" })
		vim.api.nvim_set_hl(0, "@type.builtin", { fg = "#ebdbb2" })
		vim.api.nvim_set_hl(0, "@type.qualifier", { link = "Type" })
		vim.api.nvim_set_hl(0, "@type.definition", { link = "Type" })
		vim.api.nvim_set_hl(0, "@storageclass", { link = "StorageClass" })
		vim.api.nvim_set_hl(0, "@attribute", { link = "Constant" })
		vim.api.nvim_set_hl(0, "@field", { link = "@parameter" })
		vim.api.nvim_set_hl(0, "@property", { link = "@field" })
		-- Identifiers.
		vim.api.nvim_set_hl(0, "@constant", { link = "Constant" })
		vim.api.nvim_set_hl(0, "@constant.builtin", { link = "Constant" })
		vim.api.nvim_set_hl(0, "@variable.builtin", { fg = "#fabd2f" })
		vim.api.nvim_set_hl(0, "@const.builtin", { fg = "#ff4090", italic = true, bold = true })
		vim.api.nvim_set_hl(0, "@const.macro", { link = "Macro" })
		vim.api.nvim_set_hl(0, "@symbol", { link = "Special" })
		-- Text. -- Markdown
		vim.api.nvim_set_hl(0, "@text", { link = "Normal" })
		vim.api.nvim_set_hl(0, "@text.strong", { fg = "#fb4934", bold = true })
		vim.api.nvim_set_hl(0, "@text.emphasis", { fg = "#fabd2f", bold = true })
		vim.api.nvim_set_hl(0, "@text.underline", { underline = true })
		vim.api.nvim_set_hl(0, "@text.strike", { strikethrough = true })
		vim.api.nvim_set_hl(0, "@text.title", { link = "Keyword" })
		vim.api.nvim_set_hl(0, "@text.literal", { link = "String" })
		vim.api.nvim_set_hl(0, "@text.uri", { fg = "#aaaaaa", bold = true })
		vim.api.nvim_set_hl(0, "@text.math", { link = "Special" })
		vim.api.nvim_set_hl(0, "@text.environment", { link = "Macro" })
		vim.api.nvim_set_hl(0, "@text.environment.name", { link = "Type" })
		vim.api.nvim_set_hl(0, "@text.reference", { link = "Constant" })
		vim.api.nvim_set_hl(0, "@text.danger", { link = "Exception" })
		vim.api.nvim_set_hl(0, "@text.note", { link = "DiagnosticInfo" })
		vim.api.nvim_set_hl(0, "@text.todo", { link = "DiagnosticHint" })
		vim.api.nvim_set_hl(0, "@text.warning", { link = "DiagnosticWarn" })
		-- Tags.
		vim.api.nvim_set_hl(0, "@tag.delimiter", { link = "Comment" })
		vim.api.nvim_set_hl(0, "@tag.attribute", { link = "@parameter" })
		-- Miscellaneous.
		vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
		vim.api.nvim_set_hl(0, "@define", { link = "PreProc" })
		-- @error 在insert模式下，对输入的字符进行高亮 比如让输入的字符加粗
		vim.api.nvim_set_hl(0, "@error", { link = "DiagnosticError" })
		vim.api.nvim_set_hl(0, "@operator", { link = "Operator" })
		vim.api.nvim_set_hl(0, "@preproc", { link = "PreProc" })

		vim.cmd("highlight clear ColorColumn")
	end,
	fragrans = function()
		-- sytax
		vim.api.nvim_set_hl(0, "Comment", { ctermfg = 245, fg = "#928374" })
		vim.api.nvim_set_hl(0, "Constant", { ctermfg = 175, fg = "#ffa6ff", bold = true })
		-- vim.api.nvim_set_hl(0, "Constant", { ctermfg = 175, fg = "#c678dd", bold = true })
		vim.api.nvim_set_hl(0, "String", { ctermfg = 142, fg = "#98c379", italic = true })
		vim.api.nvim_set_hl(0, "Identifier", { ctermfg = 109, fg = "#83a598" })
		vim.api.nvim_set_hl(0, "Function", { ctermfg = 142, fg = "#B5E8B0", bold = true })
		vim.api.nvim_set_hl(0, "Statement", { ctermfg = 167, fg = "#FF0000" })
		vim.api.nvim_set_hl(0, "Operator", { ctermfg = 223, fg = "#ebdbb2", bold = true })
		vim.api.nvim_set_hl(0, "keyword", { ctermfg = 167, fg = "#FF0000", bold = true })
		vim.api.nvim_set_hl(0, "PreProc", { ctermfg = 108, fg = "#B5E8B0", bold = true, italic = true })
		vim.api.nvim_set_hl(0, "Type", { ctermfg = 214, fg = "#fabd2f", bold = true })
		vim.api.nvim_set_hl(0, "StorageClass", { ctermfg = 208, fg = "#fe8019" })
		vim.api.nvim_set_hl(0, "Structure", { ctermfg = 108, fg = "#8ec07c" })
		-- vim.api.nvim_set_hl(0, "Typedef", { ctermfg = 214, fg = "#fabd2f" })
		vim.api.nvim_set_hl(0, "Typedef", { ctermfg = 214, fg = "#fff073" })
		vim.api.nvim_set_hl(0, "Special", { ctermfg = 208, fg = "#fe8019" })
		vim.api.nvim_set_hl(0, "Repeat", { ctermfg = 167, fg = "#B5E8B0" })
		vim.api.nvim_set_hl(0, "Boolean", { ctermfg = 175, fg = "#c678dd", bold = true, italic = true })
		vim.api.nvim_set_hl(0, "Conditional", { ctermfg = 167, fg = "#B5E8B0" })
		vim.api.nvim_set_hl(0, "Number", { ctermfg = 175, fg = "#ffa6ff", bold = true })
		vim.api.nvim_set_hl(0, "Float", { ctermfg = 175, fg = "#ffa6ff", bold = true })
		vim.api.nvim_set_hl(0, "Exception", { fg = "#FF0000", bold = true })
		vim.api.nvim_set_hl(0, "Macro", { ctermfg = 108, fg = "#B5E8B0", bold = true })
		vim.api.nvim_set_hl(0, "Delimiter", { ctermfg = 208, fg = "#fe8019" })
		vim.api.nvim_set_hl(0, "Character", { link = "Delimiter" })
		vim.api.nvim_set_hl(0, "Label", { link = "Statement" })
		vim.api.nvim_set_hl(0, "Include", { link = "PreProc" })
		vim.api.nvim_set_hl(0, "Define", { link = "PreProc" })
		vim.api.nvim_set_hl(0, "PreCondit", { link = "PreProc" })
		vim.api.nvim_set_hl(0, "SpecialChar", { link = "Special" })
		vim.api.nvim_set_hl(0, "Tag", { link = "Special" })
		vim.api.nvim_set_hl(0, "SpecialComment", { link = "Special" })
		vim.api.nvim_set_hl(0, "Debug", { link = "Special" })

		--  === treesitter

		-- Punctuation.
		vim.api.nvim_set_hl(0, "@punct.delimiter", { link = "Delimiter" })
		vim.api.nvim_set_hl(0, "@punct.bracket", { link = "Delimiter" })
		vim.api.nvim_set_hl(0, "@punct.special", { link = "Delimiter" })
		-- Literals.
		vim.api.nvim_set_hl(0, "@string", { link = "String" })
		vim.api.nvim_set_hl(0, "@string.regex", { fg = "#ff4090", italic = true })
		vim.api.nvim_set_hl(0, "@string.escape", { fg = "#B5E8B0", italic = true })
		vim.api.nvim_set_hl(0, "@string.special", { fg = "#B5E8B0", italic = true, bold = true })
		vim.api.nvim_set_hl(0, "@character", { link = "SpecialKey" })
		vim.api.nvim_set_hl(0, "@character.special", { link = "SpecialKey" })
		vim.api.nvim_set_hl(0, "@number", { link = "Number" })
		vim.api.nvim_set_hl(0, "@float", { link = "Float" })
		vim.api.nvim_set_hl(0, "@boolean", { link = "Boolean" })
		-- Functions
		vim.api.nvim_set_hl(0, "@function", { link = "Function" })
		vim.api.nvim_set_hl(0, "@method", { link = "Function" })
		vim.api.nvim_set_hl(0, "@method.call", { link = "Function" })
		vim.api.nvim_set_hl(0, "@constructor", { link = "Function" })
		vim.api.nvim_set_hl(0, "@parameter", { fg = "#aaaaaa" })
		vim.api.nvim_set_hl(0, "@parameter.reference", { link = "@parameter" })
		-- Keywords.
		vim.api.nvim_set_hl(0, "@keyword", { link = "Keyword" })
		vim.api.nvim_set_hl(0, "@keyword.function", { link = "Keyword" })
		vim.api.nvim_set_hl(0, "@keyword.operator", { link = "Exception" })
		vim.api.nvim_set_hl(0, "@keyword.return", { link = "Exception" })
		vim.api.nvim_set_hl(0, "@conditional", { link = "Conditional" })
		vim.api.nvim_set_hl(0, "@repeat", { link = "Repeat" })
		vim.api.nvim_set_hl(0, "@debug", { link = "Debug" })
		vim.api.nvim_set_hl(0, "@label", { link = "Label" })
		vim.api.nvim_set_hl(0, "@include", { link = "Include" })
		vim.api.nvim_set_hl(0, "@exception", { link = "Exception" })
		-- Type
		vim.api.nvim_set_hl(0, "@type", { link = "Type" })
		vim.api.nvim_set_hl(0, "@type.builtin", { fg = "#ebdbb2" })
		vim.api.nvim_set_hl(0, "@type.qualifier", { link = "Type" })
		vim.api.nvim_set_hl(0, "@type.definition", { link = "Type" })
		vim.api.nvim_set_hl(0, "@storageclass", { link = "StorageClass" })
		vim.api.nvim_set_hl(0, "@attribute", { link = "Constant" })
		vim.api.nvim_set_hl(0, "@field", { link = "@parameter" })
		vim.api.nvim_set_hl(0, "@property", { link = "@field" })
		-- Identifiers.
		vim.api.nvim_set_hl(0, "@constant", { link = "Constant" })
		vim.api.nvim_set_hl(0, "@constant.builtin", { link = "Constant" })
		vim.api.nvim_set_hl(0, "@variable.builtin", { fg = "#fff073" })
		vim.api.nvim_set_hl(0, "@const.builtin", { fg = "#ff4090", italic = true, bold = true })
		vim.api.nvim_set_hl(0, "@const.macro", { link = "Macro" })
		vim.api.nvim_set_hl(0, "@symbol", { link = "Special" })
		-- Text. -- Markdown
		vim.api.nvim_set_hl(0, "@text", { link = "Normal" })
		vim.api.nvim_set_hl(0, "@text.strong", { fg = "#FF0000", bold = true })
		vim.api.nvim_set_hl(0, "@text.emphasis", { fg = "#fabd2f", bold = true })
		vim.api.nvim_set_hl(0, "@text.underline", { underline = true })
		vim.api.nvim_set_hl(0, "@text.strike", { strikethrough = true })
		vim.api.nvim_set_hl(0, "@text.title", { fg = "#B5E8B0", bold = true })
		vim.api.nvim_set_hl(0, "@text.literal", { link = "String" })
		vim.api.nvim_set_hl(0, "@text.uri", { fg = "#aaaaaa", bold = true })
		vim.api.nvim_set_hl(0, "@text.math", { link = "Special" })
		vim.api.nvim_set_hl(0, "@text.environment", { link = "Macro" })
		vim.api.nvim_set_hl(0, "@text.environment.name", { link = "Type" })
		vim.api.nvim_set_hl(0, "@text.reference", { link = "Constant" })
		vim.api.nvim_set_hl(0, "@text.danger", { link = "Exception" })
		vim.api.nvim_set_hl(0, "@text.note", { link = "DiagnosticInfo" })
		vim.api.nvim_set_hl(0, "@text.todo", { link = "DiagnosticHint" })
		vim.api.nvim_set_hl(0, "@text.warning", { link = "DiagnosticWarn" })
		-- Tags.
		vim.api.nvim_set_hl(0, "@tag.delimiter", { link = "Comment" })
		vim.api.nvim_set_hl(0, "@tag.attribute", { link = "@parameter" })
		-- Miscellaneous.
		vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
		vim.api.nvim_set_hl(0, "@define", { link = "PreProc" })
		vim.api.nvim_set_hl(0, "@error", { link = "DiagnosticError" })
		vim.api.nvim_set_hl(0, "@operator", { link = "Operator" })
		vim.api.nvim_set_hl(0, "@preproc", { link = "PreProc" })

		-- =====gitsign
		vim.api.nvim_set_hl(0, "GitSignsAdd", { ctermfg = 142, ctermbg = 239, bg = "none", fg = "#98c379" })
		vim.api.nvim_set_hl(0, "GitSignsChange", { ctermfg = 108, ctermbg = 239, bg = "none", fg = "#B5E8B0" })

		vim.cmd("highlight clear ColorColumn")
	end,
	sakura = function()
		setsyntax()

		-- =====treesitter
		-- self,this ...
		vim.api.nvim_set_hl(0, "@variable.builtin", { ctermfg = 203, fg = "#ff4090" })
		-- self.xxx
		vim.api.nvim_set_hl(0, "@parameter", { ctermfg = 223, fg = "#c678dd" })
		vim.api.nvim_set_hl(0, "@field", { ctermfg = 223, fg = "#c678dd" })

		-- api.nvim_set_hl(0, "@boolean", { ctermfg = 175, fg = "#c678dd", bold = true, italic = true })
		vim.api.nvim_set_hl(0, "@boolean", { ctermfg = 214, fg = "#fabd2f", bold = true, italic = true })
		vim.api.nvim_set_hl(0, "@operator", { ctermfg = 203, fg = "#ff4090" })
		vim.api.nvim_set_hl(0, "@keyword.operator", { ctermfg = 203, fg = "#ff4090" }) -- and, or, not
		vim.api.nvim_set_hl(0, "@type", { ctermfg = 214, fg = "#fabd2f", bold = true, italic = true }) -- class

		-- api.nvim_set_hl(0, "@variable", { ctermfg = 223, fg = "#EBDBB2" })

		-- api.nvim_set_hl(0, "@string", { ctermfg = 142, fg = "#98c379", italic = true })
		vim.api.nvim_set_hl(0, "@string", { ctermfg = 142, fg = "#ebdbb2", italic = true })

		-- api.nvim_set_hl(0, "@keyword", { ctermfg = 203, fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "@keyword", { ctermfg = 203, fg = "#ff4090" })
		vim.api.nvim_set_hl(0, "@keyword.function", { ctermfg = 167, fg = "#fb4934" })
		vim.api.nvim_set_hl(0, "@keyword.return", { ctermfg = 167, fg = "#fb4934" })

		vim.cmd("highlight clear ColorColumn")
	end,
	repo = function()
		-- vim.cmd("highlight clear")
		if vim.fn.exists("syntax_on") then
			vim.cmd("syntax reset")
		end
		-- vim.cmd("colorscheme deus")
		-- vim.g.deus_termcolors = 256
		set_editor_hl()
		set_lsp_hl()
		set_gitsigns_hl()
		set_notify_hl()
		set_indenline_hl()
		set_nvimtree_hl()
		set_navic_hl()
		vim.cmd("highlight clear ColorColumn")
		return nil
	end,
}

caseList[mode]()

vim.api.nvim_create_user_command("DeusSyntaxColor", function(args)
	if caseList[args.fargs[1]] == nil then
		caseList["camellia"]()
		return
	else
		caseList[args.fargs[1]]()
		return
	end
end, {
	desc = "deus change syntax colorscheme",
	nargs = "?",
	---@diagnostic disable-next-line: unused-local
	complete = function(A, L, P)
		return {
			"camellia",
			"fragrans",
			"sakura",
			"repo",
		}
	end,
})

local terminal_colors = {
	terminal_color_0 = "#2C323B",
	terminal_color_1 = "#a80000",
	terminal_color_2 = "#50de60",
	terminal_color_3 = "#fe8019",
	terminal_color_4 = "#83a598",
	terminal_color_5 = "#bb0099",
	terminal_color_6 = "#00d0c0",
	terminal_color_7 = "#928374",
	terminal_color_8 = "#3c3836",
	terminal_color_9 = "#fb4934",
	terminal_color_10 = "#98C379",
	terminal_color_11 = "#fabd2f",
	terminal_color_12 = "#2bff99",
	terminal_color_13 = "#C678DD",
	terminal_color_14 = "#8ec07c",
	terminal_color_15 = "#c0c0c0",
}
for k, v in pairs(terminal_colors) do
	vim.g[k] = v
end
