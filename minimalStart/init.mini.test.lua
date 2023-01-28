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
			-- highlight
			use({
				"nvim-treesitter/nvim-treesitter",
				run = function()
					local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
					ts_update()
				end,
			})
			-- lsp
			use({
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",
				"neovim/nvim-lspconfig",
			})
			-- lspsaga
			use({
				"glepnir/lspsaga.nvim",
				branch = "main",
			})
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
	vim.cmd([[colorscheme deus]])
end

local function setLsp()
	---@diagnostic disable-next-line: missing-parameter
	local runtime_path = vim.split(package.path, ";")
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")

	local util = require("lspconfig.util")
	local root_files = {
		"project.md",
	}
	require("lspconfig")["sumneko_lua"].setup({

		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = runtime_path,
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
		---@diagnostic disable-next-line: unused-local
		on_attach = function(client, bufnr)
			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
			vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
			vim.keymap.set("n", "<space>f", function()
				vim.lsp.buf.format({ async = true })
			end, bufopts)
		end,
		root_dir = function(fname)
			return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
		end,
	})
end

local function load_config()
	setBasics()
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

	require("mason").setup({
		install_root_dir = temp_dir .. "/neovimtest/mason",
	})
	require("mason-lspconfig").setup({
		ensure_installed = {
			"sumneko_lua",
		},
		automatic_installation = true,
	})

	setLsp()
	-- lspsage config
	require("lspsaga").setup({
		lightbulb = {
			sign = false,
		},
		symbol_in_winbar = {
			enable = false,
		},
		ui = {
			border = "rounded",
			code_action = "💡",
		},
	})
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
