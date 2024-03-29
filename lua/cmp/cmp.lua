local status, cmp = pcall(require, "cmp")
if not status then
	vim.notify("没有找到 cmp")
	return
end
-- code snippet
local luasnip
status, luasnip = pcall(require, "luasnip")
if not status then
	vim.notify("没有找到 luasnip")
	return
end
-- UI
-- add icons for choice node
local types = require("luasnip.util.types")
luasnip.config.set_config({
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "●", "DiagnosticError" } },
			},
		},
	},
})

local mapping = require("keybindings").pluginKeys.cmp(luasnip, cmp)
local keybindingAlias = require("keybindingAlias")

local commConf = require("commConf")
-- in large file not use treesitter
-- TODO: add filetype check, not enable in specific filetype
local ifEnable = function()
	local context = require("cmp.config.context")
	local max_filesize = commConf.largefileEdge -- 100 KB
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
	-- disable completion in comments
	-- keep command mode completion enabled when cursor is in a comment
	if vim.api.nvim_get_mode().mode == "c" then
		return true
	elseif ok and stats and stats.size > max_filesize then
		--  not use treesitter in large file
		return not context.in_syntax_group("Comment")
	else
		return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
		-- return not context.in_syntax_group("Comment")
	end
end

-- UI
-- local lspkind
-- status, lspkind = pcall(require, "lspkind")
-- if not status then
-- 	vim.notify("没有找到 lspkind")
-- 	return
-- end
-- lspkind.init({
-- 	symbol_map = {
-- 		Text = "",
-- 		Method = "󰫺",
-- 		Function = "󰡱",
-- 		Constructor = "󰡢",
-- 		Field = "",
-- 		Variable = "󰫧",
-- 		Class = "",
-- 		Interface = "",
-- 		Module = "",
-- 		Property = "󰫽",
-- 		Unit = "󰬂",
-- 		Value = "󱂌",
-- 		Enum = "󰕅",
-- 		Keyword = "󰫸",
-- 		Snippet = "",
-- 		Color = "",
-- 		File = "",
-- 		Reference = "",
-- 		Folder = "",
-- 		EnumMember = "",
-- 		Constant = "",
-- 		Struct = "󰷑",
-- 		Event = "󱔁",
-- 		Operator = "",
-- 		TypeParameter = "",
-- 	},
-- })

--cmp config
-- https://github.com/hrsh7th/nvim-cmp
-- UI about cmp win
local winhighlight = {
	winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual",
}
cmp.setup({
	-- UI
	-- this don't hava tabnine
	-- formatting = {
	-- 	format = function(entry, vim_item)
	-- 		local kind_icons = {
	-- 			Text = "",
	-- 			Method = "󰫺",
	-- 			Function = "󰡱",
	-- 			Constructor = "󰡢",
	-- 			Field = "",
	-- 			Variable = "󰫧",
	-- 			Class = "",
	-- 			Interface = "",
	-- 			Module = "",
	-- 			Property = "󰫽",
	-- 			Unit = "󰬂",
	-- 			Value = "󱂌",
	-- 			Enum = "󰕅",
	-- 			Keyword = "󰫸",
	-- 			Snippet = "",
	-- 			Color = "",
	-- 			File = "",
	-- 			Reference = "",
	-- 			Folder = "",
	-- 			EnumMember = "",
	-- 			Constant = "",
	-- 			Struct = "󰷑",
	-- 			Event = "󱔁",
	-- 			Operator = "",
	-- 			TypeParameter = "",
	-- 		}
	-- 		-- Kind icons
	-- 		vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
	-- 		-- Source
	-- 		vim_item.menu = ({
	-- 			buffer = "[Buffer]",
	-- 			nvim_lsp = "[LSP]",
	-- 			luasnip = "[LuaSnip]",
	-- 			dap = "[DAP]",
	-- 			path = "[Path]",
	-- 		})[entry.source.name]
	-- 		return vim_item
	-- 	end,
	-- },

	formatting = {
		format = function(entry, vim_item)
			local kind_icons = {
				Text = "",
				Method = "󰫺",
				Function = "󰡱",
				Constructor = "󰡢",
				Field = "",
				Variable = "󰫧",
				Class = "",
				Interface = "",
				Module = "",
				Property = "󰫽",
				Unit = "󰬂",
				Value = "󱂌",
				Enum = "󰕅",
				Keyword = "󰫸",
				Snippet = "",
				Color = "",
				File = "",
				Reference = "",
				Folder = "",
				EnumMember = "",
				Constant = "",
				Struct = "󰷑",
				Event = "󱔁",
				Operator = "",
				TypeParameter = "",
			}
			if entry.source.name == "cmp_tabnine" then
				local detail = (entry.completion_item.labelDetails or {}).detail
				-- vim_item.kind = ""
				vim_item.kind = ""
				if detail and detail:find(".*%%.*") then
					vim_item.kind = vim_item.kind .. " " .. detail
				end

				if (entry.completion_item.data or {}).multiline then
					vim_item.kind = vim_item.kind .. " " .. "[ML]"
				end
			else
				-- Kind icons
				vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			end
			-- Source
			vim_item.menu = ({
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				luasnip = "[LuaSnip]",
				dap = "[DAP]",
				path = "[Path]",
				cmp_tabnine = "[TN]",
			})[entry.source.name]

			-- the maximum length of the menu item, if it's logger than this value, it will be truncated
			local maxwidth = 80
			local ellipsis_char = "…"
			if maxwidth ~= nil then
				if ellipsis_char == nil then
					vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
				else
					local label = vim_item.abbr
					local truncated_label = vim.fn.strcharpart(label, 0, maxwidth)
					if truncated_label ~= label then
						vim_item.abbr = truncated_label .. ellipsis_char
					end
				end
			end
			return vim_item
		end,
	},

	-- not enable auto-completion in comments and in large file will not use treesitter
	enabled = ifEnable,
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		-- floating window for completion menu
		completion = cmp.config.window.bordered(winhighlight),
		-- completion = cmp.config.window.bordered(),
		-- floating window for documentation popup
		documentation = cmp.config.window.bordered(winhighlight),
	},
	-- keybindings
	mapping = mapping,
	-- sources
	sources = cmp.config.sources({
		{ name = "luasnip", group_index = 1 }, -- For luasnip users. If this is not set, LuaSnip's snippet will not be included in the completion list
		-- tabnine
		{ name = "cmp_tabnine", group_index = 1 },
		-- lsp
		{ name = "nvim_lsp", group_index = 1 },
		{ name = "nvim_lsp_signature_help", group_index = 1 },
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					local buf = vim.api.nvim_get_current_buf()
					local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
					if byte_size > 1024 * 1024 then -- 1 Megabyte max
						return {}
					end
					return { buf }
				end,
			},
			group_index = 2,
		},
		{ name = "path", group_index = 2 },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "nvim_lsp_document_symbol", group_index = 1 },
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					local buf = vim.api.nvim_get_current_buf()
					local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
					if byte_size > 1024 * 1024 then -- 1 Megabyte max
						return {}
					end
					return { buf }
				end,
			},
			group_index = 2,
		},
	},
})
--[[
{
    { name = 'path' }
}, {
    { name = 'cmdline' } 和group_index意思相同，上面的优先级越高，即path的优先级高于
}                         cmdline，path源ok的话将优先匹配path
--]]
-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		-- https://github.com/hrsh7th/cmp-cmdline/issues/24
		-- https://github.com/hrsh7th/nvim-cmp/issues/821
		-- Solve the problem that typing :! in command mode takes too long time for wait  ENV:WSL2
		-- { name = 'cmdline', keyword_pattern = [[\!\@<!\w*]] }
		{ name = "cmdline" },
	}),
})

cmp.setup.filetype({ "dap-repl", "dapui_watches" }, {
	sources = {
		{ name = "dap" },
	},
})

-- NOTE: disable cmp for specify filetype
cmp.setup.filetype({ "TelescopePrompt", "text", "" }, {
	enabled = false,
})

-- NOTE: set cmp for specify filetype
cmp.setup.filetype({ "markdown" }, {
	sources = {
		{ name = "luasnip", group_index = 2 },
		{
			name = "buffer",
			option = {
				get_bufnrs = function()
					local buf = vim.api.nvim_get_current_buf()
					local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
					if byte_size > 1024 * 1024 then -- 1 Megabyte max
						return {}
					end
					return { buf }
				end,
			},
			group_index = 2,
		},
		{ name = "path", group_index = 1 },
	},
})

-- ---LuaSnip configuration--------
-- ·与代码snippet有关
-- custom snippets
-- https://github.com/rafamadriz/friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

local config_path = vim.fn.stdpath("config")
-- load snippets from path/of/your/nvim/config/my-cool-snippets
-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { config_path .. "/lua/cmp/snippets/vscode" } })
require("luasnip.loaders.from_lua").load({ paths = { config_path .. "/lua/cmp/snippets/lua" } })

-- For changing choices in choiceNodes (not strictly necessary for a basic setup).
-- { "i", "s" } Indicates insertion mode and selection mode, respectively
vim.keymap.set({ "i", "s" }, keybindingAlias.cmp.luasnip_node_next, function()
	if luasnip.choice_active() then
		luasnip.change_choice(1)
	end
end)

vim.keymap.set({ "i", "s" }, keybindingAlias.cmp.luasnip_node_prev, function()
	if luasnip.choice_active() then
		luasnip.change_choice(-1)
	end
end)

-- ---AI assistant----------------
-- tabnine

local tabnine
status, tabnine = pcall(require, "cmp_tabnine.config")
if not status then
	vim.notify("没有找到 cmp-tabnine")
	return
end
tabnine:setup({
	-- max_lines = 1000,
	-- max_num_results = 20,
	-- sort = true,
	-- run_on_every_keystroke = true,
	-- snippet_placeholder = "..",
	ignored_file_types = {
		-- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
		markdown = true,
		html = true,
		-- javascript = true,
		-- lua = true,
	},
	-- show_prediction_strength = false
})
-- reset cmp sorting with tabnine
local compare = require("cmp.config.compare")
cmp.setup({
	sorting = {
		priority_weight = 2,
		comparators = {
			require("cmp_tabnine.compare"),
			compare.offset,
			compare.exact,
			compare.score,
			compare.recently_used,
			compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
		},
	},
})

-- TabNine supports prefetching files, preprocessing them before users ask for completions.
-- Prefetching is supported through a command
local prefetch = vim.api.nvim_create_augroup("prefetch", { clear = true })

vim.api.nvim_create_autocmd("BufRead", {
	group = prefetch,
	pattern = { "*.py", "*.lua", "*.js", "*.sh", "*.c", "*.ts" },
	callback = function()
		require("cmp_tabnine"):prefetch(vim.fn.expand("%:p"))
	end,
})

-- local tabnine
-- status, tabnine = pcall(require, "tabnine")
-- if not status then
-- 	vim.notify("没有找到 cmp-tabnine")
-- 	return
-- end
-- tabnine.setup({
-- 	disable_auto_comment = true,
-- 	accept_keymap = keybindingAlias.tabline.accept_keymap,
-- 	dismiss_keymap = keybindingAlias.tabline.dismiss_keymap,
-- 	debounce_ms = 800,
-- 	suggestion_color = { gui = "#808080", cterm = 244 },
-- 	exclude_filetypes = { "TelescopePrompt", "markdown", "html" },
-- 	log_file_path = nil, -- absolute path to Tabnine log file
-- })

-- github Copilot
-- ctrl x | xx
-- leader cc|ee
-- leader cv
-- -- FIX: https://github.com/mfussenegger/nvim-dap/issues/562
vim.api.nvim_set_var("copilot_filetypes", {
	["*"] = false,
	-- ["dap-repl"] = false,
	["python"] = true,
	["lua"] = true,
	["javascript"] = true,
	["typescript"] = true,
	["sh"] = true,
	["c"] = true,
})

vim.api.nvim_set_keymap(
	"i",
	keybindingAlias.copilot.copilotAccept,
	"copilot#Accept('')",
	{ noremap = true, silent = true, expr = true, desc = "accept copilot suggestion" }
)
vim.g.copilot_no_tab_map = true

-- OPTIMIZE:
-- vim.api.nvim_set_keymap(
-- 	"i",
-- 	keybindingAlias.copilot.copilotPanel,
-- 	"<cmd>:Copilot panel<cr>",
-- 	{ noremap = true, silent = true, desc = "open copilot panel" }
-- )
