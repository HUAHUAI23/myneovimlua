-- NOTE: more info:
--                  https://github.com/VonHeikemen/lsp-zero.nvim/wiki/Minimal-test-config
--                  https://github.com/neovim/nvim-lspconfig/blob/master/test/minimal_init.lua

-- exclude default paths/config     config path and package path (packer)
-- more info: https://github.com/VonHeikemen/lsp-zero.nvim/wiki/Minimal-test-config
--            https://github.com/neovim/nvim-lspconfig/blob/master/test/minimal_init.lua
vim.opt.runtimepath:remove(vim.fn.expand("~/.config/nvim"))
vim.opt.packpath:remove(vim.fn.expand("~/.local/share/nvim/site"))

local on_windows = vim.loop.os_uname().version:match("Windows")
local function join_paths(...)
	local path_sep = on_windows and "\\" or "/"
	local result = table.concat({ ... }, path_sep)
	return result
end

vim.cmd([[set runtimepath=$VIMRUNTIME]])

local temp_dir = vim.loop.os_getenv("TEMP") or "/tmp"
local packer_dir = temp_dir .. "/neovimtest"
vim.cmd("set packpath=" .. join_paths(packer_dir, "nvim", "site"))
local package_root = join_paths(packer_dir, "nvim", "site", "pack")
local install_path = join_paths(package_root, "packer", "start", "packer.nvim")
local compile_path = join_paths(install_path, "plugin", "packer_compiled.lua")

local function load_plugins()
	require("packer").startup({
		function(use)
			use("wbthomason/packer.nvim")
			-- theme
			use("ajmwagar/vim-deus")
			use("HUAHUAI23/nvim-quietlight")
		end,
		config = {
			package_root = package_root,
			compile_path = compile_path,
		},
	})
end

local function setBasics()
	-- basic config
	vim.opt_local.expandtab = true
	vim.opt_local.shiftwidth = 4
	vim.opt_local.tabstop = 4
	vim.opt_local.softtabstop = 4
	-- UTF-8
	vim.g.encoding = "UTF-8"
	vim.o.fileencoding = "utf-8"
	-- color support
	vim.o.t_Co = 256
	vim.o.termguicolors = true
	-- theme
	vim.o.background = "light"
	vim.cmd([[colorscheme quietlight]])
end

local function load_config()
	setBasics()
end

if vim.fn.isdirectory(install_path) == 0 then
	vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	load_plugins()
	require("packer").sync()
	local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
	-- ensure plugins is synced and then load config
	vim.api.nvim_create_autocmd(
		"User",
		{ pattern = "PackerComplete", callback = load_config, group = packer_group, once = true }
	)
else
	load_plugins()
	-- require("packer").sync()
	load_config()
end
