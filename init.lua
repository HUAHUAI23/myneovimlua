-- PERF: structure
--       Before: do something there
--       Load
--       After: do something there

if vim.g.neovide then
	-- Put anything you want to happen only in Neovide here
	--  BUG: fix shell environment when neocvide --wsl
	vim.opt.clipboard = "unnamedplus"
	-- vim.cmd("set clipboard+=unnamedplus")
	vim.opt.guifont = { "Hack_NFM", "3270Medium_NF", "SauceCodePro_NF", ":h14" }
	vim.opt.linespace = 0
	vim.g.neovide_scale_factor = 1.0
	vim.g.neovide_scroll_animation_length = 0.3
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
	vim.g.neovide_cursor_animation_length = 0.13
	vim.g.neovide_cursor_trail_size = 0.8
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_cursor_animate_command_line = true
	vim.g.neovide_cursor_unfocused_outline_width = 0.125
	vim.g.neovide_cursor_vfx_mode = "torpedo"
	vim.g.neovide_cursor_vfx_opacity = 200.0
	vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
	vim.g.neovide_cursor_vfx_particle_density = 7.0
	vim.g.neovide_cursor_vfx_particle_speed = 10.0
	vim.g.neovide_cursor_vfx_particle_phase = 1.5
	vim.g.neovide_cursor_vfx_particle_curl = 1.0
end

-- TODO: use loop to disable bulks of plugins

-- NOTE: Before

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
	require("colorscheme")
	-- require("colorscheme-test")
end

-- NOTE: load

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
