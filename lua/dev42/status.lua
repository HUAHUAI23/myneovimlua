-- local function diagnostics_and_pyenv()
-- 	local diagnostics_dict = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }
-- 	for severity, _ in pairs(diagnostics_dict) do
-- 		local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[severity] })
-- 		if count > 0 then
-- 			diagnostics_dict[severity] = count
-- 		end
-- 	end
-- 	local E = diagnostics_dict.ERROR ~= 0 and "E," .. diagnostics_dict.ERROR .. " " or ""
-- 	local W = diagnostics_dict.WARN ~= 0 and "W," .. diagnostics_dict.WARN .. " " or ""
-- 	local I = diagnostics_dict.INFO ~= 0 and "I," .. diagnostics_dict.INFO .. " " or ""
-- 	local H = diagnostics_dict.HINT ~= 0 and "H," .. diagnostics_dict.HINT .. " " or ""
-- 	return E .. W .. I .. H
-- end
--
-- local align = "%="
-- -- local mode = "%-2{%v:lua.string.upper(v:lua.vim.api.nvim_get_mode().mode)%}"
-- local file_name = "%f"
-- local modified = " %m   "
-- local position = "%-11(%l,%c%V%)"
-- local lines = "L,%-6L"
-- local percentage = "%P"
--
-- local init_status = function()
-- 	vim.opt.statusline = string.format("%s%s%s%s%s%s", file_name, modified, align, position, lines, percentage)
-- end
--
-- init_status()
--
-- local status_autogru = vim.api.nvim_create_augroup("myStatusGroupt", {
-- 	clear = true,
-- })
-- vim.api.nvim_create_autocmd({ "ModeChanged" }, {
-- 	group = status_autogru,
-- 	callback = function()
-- 		if vim.env.VIRTUAL_ENV_PROMPT then
-- 			vim.opt.statusline = string.format(
-- 				"%s%s%s%s%s%s%s%s",
-- 				file_name,
-- 				modified,
-- 				diagnostics_and_pyenv(),
-- 				align,
-- 				"🫙 " .. string.match(vim.env.VIRTUAL_ENV_PROMPT, "%w+") .. "  ",
-- 				position,
-- 				lines,
-- 				percentage
-- 			)
-- 		else
-- 			vim.opt.statusline = string.format(
-- 				"%s%s%s%s%s%s%s",
-- 				file_name,
-- 				modified,
-- 				diagnostics_and_pyenv(),
-- 				align,
-- 				position,
-- 				lines,
-- 				percentage
-- 			)
-- 		end
-- 	end,
-- })

-- =================================================

-- function _G.diagnostics_and_pyenv(arg)
-- 	-- local str = ""
-- 	if arg == "a" then
-- 		local diagnostics_dict = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }
-- 		for severity, _ in pairs(diagnostics_dict) do
-- 			local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[severity] })
-- 			if count > 0 then
-- 				diagnostics_dict[severity] = count
-- 			end
-- 		end
-- 		local E = diagnostics_dict.ERROR ~= 0 and "E," .. diagnostics_dict.ERROR .. " " or ""
-- 		local W = diagnostics_dict.WARN ~= 0 and "W," .. diagnostics_dict.WARN .. " " or ""
-- 		local I = diagnostics_dict.INFO ~= 0 and "I," .. diagnostics_dict.INFO .. " " or ""
-- 		local H = diagnostics_dict.HINT ~= 0 and "H," .. diagnostics_dict.HINT .. " " or ""
-- 		return E .. W .. I .. H
-- 	end
--
-- 	if arg == "b" then
-- 		if vim.env.VIRTUAL_ENV_PROMPT then
-- 			return "🫙 " .. string.match(vim.env.VIRTUAL_ENV_PROMPT, "%w+")
-- 		else
-- 			return ""
-- 		end
-- 	end
-- 	if arg == "c" then
-- 		return "T " .. vim.opt_local.shiftwidth:get()
-- 	end
-- 	if arg == "d" then
-- 		return vim.opt.fileencoding:get()
-- 	end
-- end
--
-- local function test_status()
-- 	local align = "%="
-- 	local mode = "%-2{%v:lua.string.upper(v:lua.vim.api.nvim_get_mode().mode)%}"
-- 	local file_name = "%f"
-- 	local modified = " %m   "
-- 	local diagnostics = "%{%v:lua.diagnostics_and_pyenv('a')%}"
-- 	local pyenv = "%{%v:lua.diagnostics_and_pyenv('b')%}  "
-- 	local tabstop = "%{%v:lua.diagnostics_and_pyenv('c')%}  "
-- 	local encoding = "%{%v:lua.diagnostics_and_pyenv('d')%}  "
-- 	local position = "%-11(%l,%c%V%)"
-- 	local lines = "L,%-6L"
-- 	local percentage = "%P"
-- 	local str = mode
-- 		.. file_name
-- 		.. modified
-- 		.. diagnostics
-- 		.. align
-- 		.. pyenv
-- 		.. tabstop
-- 		.. encoding
-- 		.. position
-- 		.. lines
-- 		.. percentage
-- 	return str
-- end
-- vim.opt.statusline = test_status()

-- =================================================

function _G.diagnostics_and_pyenv()
	local align = "%="
	local mode = "%-2{%v:lua.string.upper(v:lua.vim.api.nvim_get_mode().mode)%}"
	local file_name = "%f"
	local modified = " %m   "
	local diagnostics = ""
	local pyenv = ""
	local tabstop = ""
	local encoding = ""
	local position = "%-11(%l,%c%V%)"
	local lines = "L,%-6L"
	local percentage = "%P"
	if #vim.diagnostic.get(0) ~= 0 then
		local diagnostics_dict = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }
		for severity, _ in pairs(diagnostics_dict) do
			local count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[severity] })
			if count > 0 then
				diagnostics_dict[severity] = count
			end
		end
		local E = diagnostics_dict.ERROR ~= 0 and "E," .. diagnostics_dict.ERROR .. " " or ""
		local W = diagnostics_dict.WARN ~= 0 and "W," .. diagnostics_dict.WARN .. " " or ""
		local I = diagnostics_dict.INFO ~= 0 and "I," .. diagnostics_dict.INFO .. " " or ""
		local H = diagnostics_dict.HINT ~= 0 and "H," .. diagnostics_dict.HINT .. " " or ""
		diagnostics = E .. W .. I .. H
	end

	if vim.env.VIRTUAL_ENV_PROMPT then
		pyenv = "🫙 " .. string.match(vim.env.VIRTUAL_ENV_PROMPT, "%w+") .. "  "
	end
	tabstop = "T " .. vim.opt_local.shiftwidth:get() .. "  "
	encoding = vim.opt.fileencoding:get() .. "  "

	return string.format(
		"%s%s%s%s%s%s%s%s%s%s%s",
		mode,
		file_name,
		modified,
		diagnostics,
		align,
		pyenv,
		tabstop,
		encoding,
		position,
		lines,
		percentage
	)
end

vim.opt.statusline = "%!v:lua.diagnostics_and_pyenv()"
