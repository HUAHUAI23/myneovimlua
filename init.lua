local loop, api = vim.loop, vim.api

-- 基础配置
require("basic")

-- 定义颜色主题
require("colorscheme")

-- 通过vim.cmd加载一些 vimscript commands
vim.cmd("source ${HOME1}/.config/nvim/extVIM.vim")

-- 快捷键映射
require("keybindings")

-- 自动命令
require("autocmd")

-- 用户自建立命令
require("usercmd")

-- Packer插件管理
require("plugins")

--- 插件配置
-- lualine
-- require("plugin-config.lualine")

-- bufferline
require("plugin-config.bufferline")

-- nvim-treesitter
require("plugin-config.nvim-treesitter")

-- nvim-tree
require("plugin-config.nvim-tree")

-- telescope.nvim
require("plugin-config.telescope")

-- toggleterm.nvim
require("plugin-config.toggleterm")

-- Comment.nvim
require("plugin-config.comment")

-- autopairs
require("plugin-config.nvim-autopairs")

-- indentline
-- require("plugin-config.indent-blankline")

-- project
require("plugin-config.project")

-- todotree
-- require("plugin-config.todo-comments")

-- trouble
require("plugin-config.trouble")

-- dashboard
require("plugin-config.dashboard")

-- neoscroll
require("plugin-config.neoscrolL")

--- cmp
require("cmp.cmp")

--- LSP
require("lsp.setup")
require("lsp.ui")
require("plugin-config.fidget")
require("lsp.null-ls")

-- DAP
require("dap.nvim-dap.setup")

require("plugin-config.todo-comments")
require("plugin-config.indent-blankline")

-- local function largefile_init(bufnr)
-- 	local max_filesize = 100 * 1024 -- 100 KB
-- 	local ok, stats = pcall(loop.fs_stat, api.nvim_buf_get_name(bufnr))
-- 	if ok and stats and stats.size < max_filesize then
-- 		require("plugin-config.todo-comments")
-- 		require("plugin-config.indent-blankline")
-- 	end
-- end
-- largefile_init(api.nvim_get_current_buf())
