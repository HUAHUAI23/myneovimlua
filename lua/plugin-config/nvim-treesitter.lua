local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	vim.notify("没有找到 nvim-treesitter")
	return
end

local commConf = require("commConf")
local lsp = require("keybindingAlias").lsp
---@diagnostic disable-next-line: unused-local
local filesize_hundle = function(lang, buf)
	local max_filesize = commConf.largefileEdge -- 100 KB
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	if ok and stats and stats.size > max_filesize then
		return true
	end
end

treesitter.setup({
	-- A list of parser names, or "all"
	ensure_installed = {
		"html",
		"css",
		"vim",
		"lua",
		"javascript",
		"python",
		"json",
		"bash",
		"markdown",
		"markdown_inline",
		"go",
		"sql",
	},
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,
	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,
	-- 启用代码高亮模块
	highlight = {
		enable = true,
		disable = filesize_hundle,
		additional_vim_regex_highlighting = false,
		-- list of language that will be disabled
		-- disable = { "c", "rust" },
	},
	-- 启用增量选择模块
	incremental_selection = {
		enable = false,
		disable = filesize_hundle,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			node_decremental = "<BS>",
			scope_incremental = "<TAB>",
		},
	},
	-- 启用代码缩进模块 (=)
	indent = {
		enable = true,
		disable = filesize_hundle,
	},
	-- https://github.com/nvim-treesitter/nvim-treesitter-refactor
	refactor = {
		-- the illuminate plugin is better than this
		highlight_definitions = {
			enable = false,
			disable = filesize_hundle,
			-- Set to false if you have an `updatetime` of ~100.
			clear_on_cursor_move = true,
		},
		highlight_current_scope = {
			enable = false,
			disable = filesize_hundle,
		},
		smart_rename = {
			enable = true,
			disable = filesize_hundle,
			keymaps = {
				smart_rename = lsp.tsRename,
			},
		},
	},
	-- more powerful %
	matchup = {
		enable = true, -- mandatory, false will disable the whole extension
		-- disable = { "c", "ruby" }, -- optional, list of language that will be disabled
		disable = filesize_hundle,
		-- [options]
	},
	-- https://github.com/windwp/nvim-ts-autotag
	-- 方便前端语言标签的自动闭合
	autotag = {
		enable = true,
		disable = filesize_hundle,
	},
})

-- use tressitter to fold code
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
