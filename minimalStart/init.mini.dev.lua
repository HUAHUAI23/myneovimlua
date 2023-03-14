local on_windows = vim.loop.os_uname().version:match("Windows")
local function join_paths(...)
	local path_sep = on_windows and "\\" or "/"
	local result = table.concat({ ... }, path_sep)
	return result
end

-- add runtimepath dir to neovim runtimepath
vim.cmd([[set runtimepath=$VIMRUNTIME]])

local temp_dir = vim.loop.os_getenv("TEMP") or "/tmp"
local packer_dir = join_paths(temp_dir, "neovimdev")
vim.cmd("set packpath=" .. join_paths(packer_dir, "nvim", "site"))
local package_root = join_paths(packer_dir, "nvim", "site", "pack")
local install_path = join_paths(package_root, "packer", "start", "packer.nvim")
local compile_path = join_paths(install_path, "plugin", "packer_compiled.lua")

-- NOTE: more info:
--                  https://github.com/VonHeikemen/lsp-zero.nvim/wiki/Minimal-test-config
--                  https://github.com/neovim/nvim-lspconfig/blob/master/test/minimal_init.lua

-- exclude default paths/config     config path and package path (packer)
-- more info: https://github.com/VonHeikemen/lsp-zero.nvim/wiki/Minimal-test-config
--            https://github.com/neovim/nvim-lspconfig/blob/master/test/minimal_init.lua
vim.opt.runtimepath:remove(vim.fn.expand("~/.config/nvim"))
vim.opt.packpath:remove(vim.fn.expand("~/.local/share/nvim/site"))

local function load_plugins()
	require("packer").startup({
		function(use)
			use("wbthomason/packer.nvim")
			-- 主题
			use("ajmwagar/vim-deus")
			-- use("theniceboy/nvim-deus")
			use("HUAHUAI23/nvim-quietlight")
			-- tree-sitter
			use({
				"nvim-treesitter/nvim-treesitter",
				run = function()
					local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
					ts_update()
				end,
			})
		end,
		config = {
			package_root = package_root,
			compile_path = compile_path,
		},
	})
end

local function setkeybindings()
	-- keybinds
	local map = vim.keymap.set
	local opt = { noremap = true, silent = true }
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "
	-- ctrl u / ctrl + d  只移动9行，默认移动半屏
	map("n", "<C-u>", "10k", opt)
	map("n", "<C-d>", "10j", opt)
	-- 上下滚动浏览
	map("n", "<C-j>", "5j", opt)
	map("n", "<C-k>", "5k", opt)
	-- 定义快捷键关闭当前分割窗口
	map("n", "<Leader>q", ":q<CR>", opt)
	-- 定义快捷键保存当前窗口内容
	map("n", "<Leader>w", ":w<CR>", opt)
	-- 定义快捷键保存所有窗口内容并退出 vim
	map("n", "<Leader>WQ", ":wa<CR>:q<CR>", opt)
	-- 不做任何保存，直接退出 vim
	map("n", "<Leader>Q", ":qa!<CR>", opt)
	-- 取消 s 默认功能 s在normal模式下为进入插入模式
	map("n", "s", "", opt)
	-- 垂直分割窗口，水平分割窗口
	map("n", "sh", ":sp<CR>", opt)
	map("n", "sv", ":vsp<CR>", opt)
	-- s + 方向键 窗口之间跳转
	map("n", "s<left>", "<C-w>h", opt)
	map("n", "s<down>", "<C-w>j", opt)
	map("n", "s<up>", "<C-w>k", opt)
	map("n", "s<right>", "<C-w>l", opt)
	-- 依次遍历子窗口
	map("n", "nw", "<C-W><C-W>", opt)
	-- 上下比例
	map("n", "sk", ":res +2<CR>", opt)
	map("n", "sj", ":res -2<CR>", opt)
	-- 左右比例
	map("n", "s,", ":vertical resize+2<CR>", opt)
	map("n", "s.", ":vertical resize-2<CR>", opt)
	-- 相等比例
	map("n", "s=", "<C-w>=", opt)
	-- 取消normal模式下 H L键默认功能
	map("n", "H", "", opt)
	map("n", "L", "", opt)
	-- 取消normal模式下 f1键的默认功能
	map("n", "<F1>", "", opt)
	-- 取消normal模式下 qq键的默认功能(连续点击两下q键)
	map("n", "qq", "", opt)
	-- 取消visual模式下 f1键的默认功能
	map("v", "<F1>", "", opt)
	-- visual模式和normal模式下f1键都可以进入命令行模式
	map("v", "<F1>", ":", { noremap = true, silent = false })
	map("n", "<F1>", ":", { noremap = true, silent = false })
	map("n", "H", "35h", opt)
	map("n", "L", "35l", opt)
	-- 定义快捷键关闭当前buffer
	map("n", "qq", ":bd<CR>", opt)
end

local function setTheme()
	if vim.env.NVIM_LIGHTTT == "1" then
		vim.o.background = "light"
		vim.cmd("colorscheme quietlight")
		vim.cmd("highlight clear ColorColumn")
	else
		vim.o.t_8f = "<Esc>[38;2;%lu;%lu;%lum"
		vim.o.t_8b = "<Esc>[48;2;%lu;%lu;%lum"
		vim.o.background = "dark"
		vim.cmd("colorscheme deus")
		vim.g.deus_termcolors = 256
		vim.cmd("highlight clear ColorColumn")
	end
end

local function setBasics()
	-- basic config
	vim.opt_local.expandtab = true
	vim.opt_local.shiftwidth = 4
	vim.opt_local.tabstop = 4
	vim.opt_local.softtabstop = 4
	-- color support
	vim.o.t_Co = 256
	vim.opt.termguicolors = true
end

local function setPlugins()
	-- tree-sitter
	require("nvim-treesitter.configs").setup({
		auto_install = true,
		highlight = {
			enable = true,
			---@diagnostic disable-next-line: unused-local
			disable = function(lang, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
			additional_vim_regex_highlighting = false,
		},
	})
end

local load_config = function()
	setBasics()
	setTheme()
	setkeybindings()
	setPlugins()
end

if vim.fn.isdirectory(install_path) == 0 then
	vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	load_plugins()
	require("packer").sync()
	local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
	vim.api.nvim_create_autocmd(
		"User",
		{ pattern = "PackerComplete", callback = load_config, group = packer_group, once = true }
	)
else
	load_plugins()
	-- require("packer").sync()
	load_config()
end
