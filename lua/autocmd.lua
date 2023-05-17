local commConf = require("commConf")
local loop, api = vim.loop, vim.api
-- clear=true 如果创建的autocommand组已经存在，则将已经存在的autocommand组删除
-- see more: https://github.com/glepnir/nvim-lua-guide-zh
local myAutoGroupt = api.nvim_create_augroup("myAutoGroupt", {
	clear = true,
})
-- local mylspAutoGroup = api.nvim_create_augroup("mylspAutoGroup", {
-- 	clear = true,
-- })

-- 创建autocommand
local autocmd = api.nvim_create_autocmd

-- nvim-tree  quit nvim when there is only one window and the filetype of window's buffer is nvim-tree
-- autocmd("BufEnter", {
-- 	nested = true,
-- 	group = myAutoGroup,
-- 	callback = function()
-- 		if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
-- 			vim.cmd("quit")
-- 		end
-- 	end,
-- })

-- 进入Terminal 自动进入插入模式
autocmd({ "TermOpen" }, {
	group = myAutoGroupt,
	command = "startinsert | set nonumber",
	-- command = "startinsert",
})

-- 自动保存
-- autocmd({ "InsertLeave", "TextChanged" }, {
-- 	group = myAutoGroup,
-- 	pattern = { "*" },
-- 	command = "silent! wall",
-- })

-- 保存时自动格式化 null-ls config this
-- autocmd("BufWritePre", {
-- 	group = myAutoGroup,
-- 	pattern = { "*.lua", "*.py", "*.sh" },
-- 	callback = vim.lsp.buf.format,
-- })

-- Highlight on yank   yanky config this
-- autocmd("TextYankPost", {
-- 	callback = function()
-- 		vim.highlight.on_yank()
-- 	end,
-- 	group = myAutoGroup,
-- 	pattern = "*",
-- })

-- 用o换行不要延续注释
autocmd("BufEnter", {
	group = myAutoGroupt,
	pattern = "*",
	callback = function()
		vim.opt.formatoptions = vim.opt.formatoptions
			- "o" -- O and o, don't continue comments
			+ "r" -- But do continue when pressing enter.
	end,
})
-- 当在wsl环境下，剪切内容到系统寄存器时会将内容同步复制到win的剪切板中
-- v:event.regname ==# '+' 参考: https://yianwillis.github.io/vimcdoc/doc/change.html#registers
-- ==# vim 运算符  参考: https://stackoverflow.com/questions/45842690/what-does-the-hash-sign-mean-after-two-equal-signs-in-vim
-- v:<name>是vim中预定义的变量，参考 :h v:var
-- :h v:event
-- @ @@ 均表示最近一次yank操作的寄存器中的内容 :echo @  |  :echo @@
-- @[name] 表示指定名字的寄存器

-- TODO: lua YANK

if vim.fn.has("wsl") then
	vim.cmd([[
    augroup wslYank
    autocmd!
    autocmd TextYankPost * if v:event.regname ==# '+' | call system('/mnt/c/windows/system32/clip.exe ',@") | endif
    augroup END
    ]])
end
--  debug eg: "1yy "+yy will output 1 and +, 1 and + is  the name of register
-- if vim.fn.has("wsl") then
-- 	vim.cmd([[
--     augroup wslYank
--     autocmd!
--     autocmd TextYankPost * :echo v:event.regname
--     augroup END
--     ]])
-- end

-- NOTE: the vim lsp do this, it more quick and smooth
-- markdown文件，当行字数达到78时，自动换行
-- autocmd("CursorMovedI", {
-- 	group = myAutoGroup,
-- 	pattern = { "*.md" },
-- 	callback = function()
-- 		-- :h nr2char() :h string :h getchar()
-- 		-- https://neovim.io/doc/user/eval.html#String
-- 		-- https://neovim.io/doc/user/builtin.html  *getchar()*
-- 		-- if vim.fn.getchar() ~= "\x80kb" and vim.fn.virtcol(".") == 77 then
-- 		if
-- 			vim.fn.virtcol(".") == 77
-- 			or vim.fn.virtcol(".") == 78
-- 			or vim.fn.virtcol(".") == 79
-- 			or vim.fn.virtcol(".") == 80
-- 			or vim.fn.virtcol(".") == 81
-- 		then
-- 			-- see more:https://www.reddit.com/r/neovim/comments/psux8f/how_to_use_a_lua_function_to_insert_text/
-- 			local pos = vim.api.nvim_win_get_cursor(0)
-- 			local line = vim.api.nvim_get_current_line()
-- 			-- sub substring
-- 			local nline = line:sub(0, pos[2] + 1) .. "  "
-- 			vim.api.nvim_set_current_line(nline)
-- 			vim.api.nvim_buf_set_lines(0, pos[1], pos[1], false, { "" })
-- 			vim.api.nvim_win_set_cursor(0, { pos[1] + 1, 1 })
-- 		end
-- 	end,
-- })
-- NOTE: after file is loaded,determine whether to load indentline and autopair
autocmd("BufReadPost", {
	group = myAutoGroupt,
	pattern = "*",
	callback = function()
		local max_filesize = commConf.largefileEdge -- 100 KB
		local ok, stats = pcall(loop.fs_stat, api.nvim_buf_get_name(api.nvim_get_current_buf()))
		if ok and stats and stats.size < max_filesize then
			-- require("plugin-config.todo-comments")
			require("indent_blankline.commands").enable()
			require("nvim-autopairs").enable()
			require("illuminate.engine").toggle()
			-- vim.cmd("setlocal spell spelllang=en_us")
		else
			vim.print("hhhhhh")
			local luacache = (_G.__luacache or {}).cache
			for pack, _ in pairs(package.loaded) do
				if string.find(pack, "^" .. vim.pesc("indent_blankline")) then
					package.loaded[pack] = nil

					if luacache then
						luacache[pack] = nil
					end
				end
				if string.find(pack, "^" .. vim.pesc("nvim-autopairs")) then
					package.loaded[pack] = nil

					if luacache then
						luacache[pack] = nil
					end
				end
			end
			require("indent_blankline").setup({
				space_char_blankline = " ",
				show_current_context = false,
				show_current_context_start = false,
				filetype_exclude = {
					"null-ls-info",
					"dashboard",
					"packer",
					"terminal",
					"help",
					"log",
					"markdown",
					"TelescopePrompt",
					"lspinfo",
					"mason.nvim",
					"toggleterm",
					"lspsagaoutline",
					"text",
				},
				char = "▏",
			})
			require("indent_blankline.commands").enable()
			require("nvim-autopairs").setup({
				disable_filetype = { "TelescopePrompt", "vim" },
				enable_check_bracket_line = false,
				ignored_next_char = [=[[%w%%%'%[%"%.]]=],
				check_ts = false,
			})
			require("nvim-autopairs").enable()
		end
	end,
})
-- NOTE: disable indentline,autopair,illuminate before loading file, this time the buffer is loaded but file is still not loaded
autocmd("BufReadPre", {
	group = myAutoGroupt,
	pattern = "*",
	callback = function()
		-- vim.api.nvim_cmd(vim.api.nvim_parse_cmd("IndentBlanklineDisable", {}), {})
		require("indent_blankline.commands").disable()
		require("nvim-autopairs").disable()
		require("illuminate.engine").toggle()
		-- vim.cmd("setlocal nospell")
	end,
})

-- NOTE: 大文件 treesitter 问题 主要有 treesiiter indentline autopair illuminate telescope cmp comment lsp null-ls
-- treesitter：的所有扩展在大文件中都会产生性能卡顿，尤其要注意 rainbow，rainbow 自带的大文件勾子
-- 是通过文件行数决定是否启用 rainbow，对于压缩的大文件可能只有一行，所以会被逃避掉。**已解决** {通过 autocmd解决}
-- indentline：会调用 treesitter 因此也会有大文件问题 **已解决** {通过 autocmd解决}
-- autopair：会调用 treesitter 检查语法节点，决定在哪些节点中会使用或者不使用 autopair **已解决** {通过 autocmd解决}
-- illuminate：illuminate的钩子是通过文件行决定的，也会被逃避掉 **已解决** {通过 autocmd解决}
-- telescope：在预览时会调用 treesiiter，因此 telescope 预览在大文件中要关闭 treesitter 语法高亮 **已解决**
-- cmp：tabnine (在大文件中可能会卡顿 **未解决**) buffer 补全源在大文件中会卡顿 **已解决**
-- comment：会调用 treesitter 检测文件类型 以决定使用什么样的注释符号，因此也会有大文件问题 **已解决**
-- lsp：在大文件中 lsp 可能会卡断 **未解决**
-- null-ls：null-ls 在大文件中主要是 各种源会有卡断问题，比如 lint format，对于 format 在大文件中禁止了保存
-- 自动格式化，通过对于 format 源要注意超时问题，对于 lint 源通过设置在大文件中不启用 **已解决**

-- auto close LSP for large file
-- autocmd("BufReadPost", {
-- 	group = mylspAutoGroup,
-- 	pattern = "*",
-- 	callback = function()
-- 		if api.nvim_buf_line_count(0) > commConf.lspLargefileEdge then
-- 			-- https://neovim.io/doc/user/lua.html#vim.defer_fn()
-- 			vim.defer_fn(function()
-- 				vim.lsp.stop_client(lsp.get_active_clients())
-- 			end, 1000)
-- 		end
-- 	end,
-- })
