local on_windows = vim.loop.os_uname().version:match("Windows")
local function join_paths(...)
	local path_sep = on_windows and "\\" or "/"
	local result = table.concat({ ... }, path_sep)
	return result
end

vim.cmd([[set runtimepath=$VIMRUNTIME]])

local temp_dir = vim.loop.os_getenv("TEMP") or "/tmp"
temp_dir = temp_dir .. "/neovimtest"
vim.cmd("set packpath=" .. join_paths(temp_dir, "nvim", "site"))
local package_root = join_paths(temp_dir, "nvim", "site", "pack")
local install_path = join_paths(package_root, "packer", "start", "packer.nvim")
local compile_path = join_paths(install_path, "plugin", "packer_compiled.lua")

local function load_plugins()
	require("packer").startup({
		function(use)
			use("ajmwagar/vim-deus")
			use("wbthomason/packer.nvim")
			use({ "github/copilot.vim" })
		end,
		config = {
			package_root = package_root,
			compile_path = compile_path,
		},
	})
end

local function load_config()
	vim.o.t_Co = 256
	vim.o.termguicolors = true
	vim.cmd([[colorscheme deus]])
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
