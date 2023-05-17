-- PERF: structure
--       Before: do something there
--       Load
--       After: do something there

if vim.g.neovide then
	-- Put anything you want to happen only in Neovide here

	-- map ctrl-/
	-- vim.keymap.set("n", [[<c-/>]], function()
	-- 	vim.pretty_print("fffff")
	-- end)

	-- set ctrl v to paste from "+" register
	-- vim.keymap.set("n", "<c-v>", '"+<space>p') -- Paste normal mode
	-- vim.keymap.set("n", "<c-v>", '"+P') -- Paste normal mode
	-- vim.keymap.set("v", "<c-v>", '"+P') -- Paste visual mode

	-- vim.keymap.set("i", "<C-V>", [[<ESC>l"+Pli]]) -- don't work
	vim.keymap.set("i", "<C-V>", function()
		local content = vim.fn.getreg("+")
		-- nvim_put
		vim.api.nvim_paste(content, true, -1)
	end) -- Paste insert mode
	-- vim.keymap.set("i", "<C-V>", [[<ESC>"+<space>p]]) -- Paste insert mode

	vim.keymap.set("c", "<c-v>", "<C-R>+") -- Paste command mode

	-- vim.cmd("set clipboard+=unnamedplus")

	-- vim.g.neovide_input_use_logo = 1

	vim.opt.guifont = { "Consolas_NF", "Hack_NFM", "3270Medium_NF", "SauceCodePro_NF", ":h12" }
	vim.g.neovide_hide_mouse_when_typing = false
	vim.g.neovide_underline_automatic_scaling = false
	-- refresh rate when fouces on neovide
	vim.g.neovide_refresh_rate = 60
	-- refresh rate when not fouces on neovide
	vim.g.neovide_refresh_rate_idle = 5
	-- before quit will ask for confirmation
	vim.g.neovide_confirm_quit = true
	-- vim.g.neovide_fullscreen = true
	vim.g.neovide_remember_window_size = true

	-- for test
	vim.g.neovide_profiler = false

	vim.g.neovide_touch_deadzone = 6.0
	vim.g.neovide_touch_drag_timeout = 0.17
	-- 控制光标动画的时间长度
	vim.g.neovide_cursor_animation_length = 0.13
	-- 控制光标的宽度
	vim.g.neovide_cursor_trail_size = 0 -- default is 0.8

	vim.g.neovide_cursor_antialiasing = true

	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_cursor_animate_command_line = true
	vim.g.neovide_cursor_unfocused_outline_width = 0.125
	-- vim.g.neovide_cursor_vfx_mode = "railgun"

	-- padding
	vim.g.neovide_padding_left = 8
	vim.g.neovide_padding_right = 8

	-- scale
	-- vim.g.neovide_scale_factor = 1.0
	-- local change_scale_factor = function(delta)
	-- 	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
	-- end
	-- vim.keymap.set("n", [[<C-=>]], function()
	-- 	change_scale_factor(1.25)
	-- end)
	-- vim.keymap.set("n", [[<C-->]], function()
	-- 	change_scale_factor(1 / 1.25)
	-- end)
end

-- TODO: use loop to disable bulks of plugins

-- NOTE: Before

-- local commConf = require("commConf")
-- disable some builtin plugins
-- nvim-tree builtin file explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- matchup need this, can make a very slight start-up time improvement
vim.g.loaded_matchit = 1

-- 基础配置
require("basic")

-- 定义颜色主题
if vim.env.NVIM_LIGHTTT == "1" then
	-- require("colorscheme-dev")
	require("colorschemeLight")
else
	-- if vim.g.neovide then
	-- 	require("colorschemeLight")
	-- else
	-- 	require("colorscheme")
	-- 	-- require("colorscheme-test")
	-- end
	require("colorscheme")
end

-- NOTE: load

-- FIX:
-- if commConf.simple_mode then
-- 	require("plugins-simple")
-- else
-- 	-- Packer插件管理
-- 	require("plugins")
-- end

-- Packer插件管理
require("plugins")

-- NOTE: After

-- 通过vim.cmd加载一些 vimscript commands
vim.cmd("source " .. vim.fn.stdpath("config") .. "/extVIM.vim")

-- 快捷键映射
local keybind = require("keybindings")
keybind.unsetKey(keybind.unsetmap)
keybind.editorKeyRegister(keybind.keymap_set)

-- 自动命令
require("autocmd")

-- 用户自建立命令
require("usercmd")

-- TODO: switch plugin's status, on or off
--- 插件配置
-- lualine
-- require("plugin-config.lualine")

-- bufferline
-- require("plugin-config.bufferline")

-- nvim-treesitter
-- require("plugin-config.nvim-treesitter")

-- nvim-tree
-- require("plugin-config.nvim-tree")

-- telescope.nvim
-- require("plugin-config.telescope")

-- toggleterm.nvim
-- require("plugin-config.toggleterm")

-- Comment.nvim
-- require("plugin-config.comment")

-- autopairs
-- require("plugin-config.nvim-autopairs")

-- indentline
-- require("plugin-config.indent-blankline")

-- project
-- require("plugin-config.project")

-- todotree
-- require("plugin-config.todo-comments")

-- trouble
-- require("plugin-config.trouble")

-- dashboard
-- require("plugin-config.dashboard")

-- neoscroll
-- require("plugin-config.neoscrolL")

--- cmp
require("cmp.cmp")

--- LSP
require("lsp.setup")
require("lsp.ui")
-- require("plugin-config.fidget")
-- require("lsp.null-ls")

-- DAP
require("dap.nvim-dap.setup")
