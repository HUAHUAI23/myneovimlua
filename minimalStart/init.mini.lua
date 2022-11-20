local api = vim.api

local on_windows = vim.loop.os_uname().version:match("Windows")
local function join_paths(...)
	local path_sep = on_windows and "\\" or "/"
	local result = table.concat({ ... }, path_sep)
	return result
end

vim.cmd([[set runtimepath=$VIMRUNTIME]])
-- you have to set runtimepath first then test dev plugin
vim.opt.runtimepath:append("/home/i42/pro/vimPlug/telescope/*")

local temp_dir = vim.loop.os_getenv("TEMP") or "/tmp"
vim.cmd("set packpath=" .. join_paths(temp_dir, "nvim", "site"))
local package_root = join_paths(temp_dir, "nvim", "site", "pack")
local install_path = join_paths(package_root, "packer", "start", "packer.nvim")
local compile_path = join_paths(install_path, "plugin", "packer_compiled.lua")

local function load_plugins()
	require("packer").startup({
		function(use)
			use("wbthomason/packer.nvim")
			-- 主题
			use("ajmwagar/vim-deus")
			use({ "aonemd/quietlight.vim" })
			use({ "alexanderjeurissen/lumiere.vim" })
			use({ "vim-scripts/zenesque.vim" })
			-- telescope
			use({
				"nvim-telescope/telescope.nvim",
				branch = "0.1.x",
				requires = { { "nvim-lua/plenary.nvim" } },
			})
		end,
		config = {
			package_root = package_root,
			compile_path = compile_path,
		},
	})
end

local load_config = function()
	vim.o.t_Co = 256
	vim.o.termguicolors = true
	vim.opt.termguicolors = true
	-- theme
	-- vim.o.t_Co = 256
	-- vim.o.termguicolors = true
	-- vim.opt.termguicolors = true
	-- vim.o.t_ut = ""
	-- vim.o.t_ul = ""
	-- vim.o.t_8f = "<Esc>[38;2;%lu;%lu;%lum"
	-- vim.o.t_8b = "<Esc>[48;2;%lu;%lu;%lum"
	-- vim.o.background = "dark"
	-- local colorscheme = "deus"
	-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
	-- if not status_ok then
	-- 	vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
	-- 	return
	-- end
	-- vim.g.deus_termcolors = 256
	-- vim.cmd([[
	--    highlight NonText ctermfg=gray guifg=grey50
	--    hi SignColumn ctermbg=None guibg=None
	--    hi VertSplit ctermfg=None ctermbg=None cterm=None guibg=None guifg=None
	--    ]])
	-- keybinds
	local map = vim.api.nvim_set_keymap
	local opt = { noremap = true, silent = true }
	-- leader key ";"
	vim.g.mapleader = ";"
	vim.g.maplocalleader = ";"
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
	map("n", "<F1>", ":", { noremap = true, silent = false })
	map("n", "H", "35h", opt)
	map("n", "L", "35l", opt)
	-- 定义快捷键关闭当前buffer
	map("n", "qq", ":bd<CR>", opt)
	-- Enable completion triggered by <c-x><c-o>  it need lsp
	api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")
	-- telescope test
	local _, telescope = pcall(require, "telescope")
	telescope.setup({
		defaults = {
			prompt_prefix = "🔍",
			-- 打开弹窗后进入的初始模式，默认为 normal，也可以是 insert
			initial_mode = "normal",
			-- default mappings see https://github.com/nvim-telescope/telescope.nvim
			mappings = {
				n = {
					["q"] = "close",
				},
			},
		},
		extensions = {
			xray23 = {
				sessionDir = "/home/i42/tele/test",
			},
			i42 = {
				colors = {
					{ "🥮", "deus", "deus.lua" },
					{ "", "xxx", "xxx.lua" },
				},
				colorDir = "/home/i42/tele/colortest",
			},
		},
	})
	pcall(telescope.load_extension, "xray23")
	pcall(telescope.load_extension, "i42")
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
