-- TODO: fix normal mode alias buffer window
-- magic search indepent switch
-- bulks unsetmap            {a,b,c,d} for in  type()
-- bulks keymap register     {a,b,c,d} for in
-- u ;u
--
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

--  vim.keymap.set  支持参数buffer
--  vim.api.nvim_set_keymap  不支持参数buffer
--  local opts = { buffer = vim.api.nvim_get_current_buf() }
--  vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting_sync()<CR>", opts)
--  详细见: https://github.com/glepnir/nvim-lua-guide-zh

local keybind = {}
-- local argmode = {
-- 	mode = "",
-- 	lhs = "",
-- 	rhs = "",
-- 	opts = {},
-- }
-- local argmodes = {
-- 	bufnr = "",
-- 	mode = "",
-- 	lhs = "",
-- 	rhs = "",
-- 	opts = {},
-- }

local keybindingAlias = require("keybindingAlias")
-- leader key
vim.g.mapleader = keybindingAlias.norl.leader_key
vim.g.maplocalleader = keybindingAlias.norl.leader_key

-- register keymap
function keybind.register_keymap(keymap)
	local opts
	if keymap.opts then
		opts = vim.tbl_extend("force", { noremap = true, silent = true }, keymap.opts)
	else
		opts = { noremap = true, silent = true }
	end
	opts.desc = keymap.description
	if keymap.bufnr then
		if type(keymap.mode) == "string" then
			vim.api.nvim_buf_set_keymap(keymap.bufnr, keymap.mode, keymap.lhs, keymap.rhs, opts)
		else
			for _, mode in ipairs(keymap.mode) do
				vim.api.nvim_buf_set_keymap(keymap.bufnr, mode, keymap.lhs, keymap.rhs, opts)
			end
		end
	else
		if type(keymap.mode) == "string" then
			vim.api.nvim_set_keymap(keymap.mode, keymap.lhs, keymap.rhs, opts)
		else
			for _, mode in ipairs(keymap.mode) do
				vim.api.nvim_set_keymap(mode, keymap.lhs, keymap.rhs, opts)
			end
		end
	end
end

function keybind.bulk_register_keymaps(group_keymap)
	for _, keymap in ipairs(group_keymap) do
		keybind.register_keymap(keymap)
	end
end

local unsetmap = {}
local inser = keybindingAlias.insert
unsetmap.insert = inser.goto_command_mode
-- https://neovim.io/doc/user/builtin.html   #mapcheck
-- if the keymap exists, unset it
if vim.fn.mapcheck(inser.goto_command_mode, "i") ~= "" then
	vim.api.nvim_del_keymap("i", inser.goto_command_mode)
end
keybind.editorInsert = {
	{ mode = "i", lhs = inser.goto_command_mode, rhs = [[<Esc>:]], opts = { silent = false } },
	{ mode = "i", lhs = inser.goto_normal_mode, rhs = [[<Esc>]], opts = { silent = false } },
}

local norl = keybindingAlias.norl
unsetmap.normal = {
	keybindingAlias.telescope.find_files,
	"s",
	norl.go_left35,
	norl.go_right35,
	norl.goto_command_mode,
	norl.quit_buffer,
}
for _, key in ipairs(unsetmap.normal) do
	if vim.fn.mapcheck(key, "n") ~= "" then
		vim.api.nvim_del_keymap("n", key)
	end
end
keybind.editorNormal = {
	-- goto command mode
	{ mode = "n", lhs = norl.goto_command_mode, rhs = [[:]], opts = { silent = false } },
	-- go and out paste mode
	{
		mode = "n",
		lhs = norl.goto_paste_mode,
		rhs = [[:set paste<cr>]],
		opts = { silent = false },
		description = "goto paste mode",
	},
	{
		mode = "n",
		lhs = norl.exit_paste_mode,
		rhs = [[:set nopaste<CR>]],
		opts = { silent = false },
		description = "exit paste mode",
	},
	-- jumps
	{ mode = "n", lhs = norl.go_left35, rhs = [[35h]] },
	{ mode = "n", lhs = norl.go_right35, rhs = [[35l]] },
	{
		mode = "n",
		lhs = norl.go_up_10line,
		rhs = [[10k]],
	},
	{
		mode = "n",
		lhs = norl.go_down_10line,
		rhs = [[10j]],
	},
	{
		mode = "n",
		lhs = norl.go_down_5line,
		rhs = [[5j]],
	},
	{
		mode = "n",
		lhs = norl.go_up_5line,
		rhs = [[5k]],
	},
	{
		mode = "n",
		lhs = norl.quit_buffer,
		rhs = [[:bd<CR>]],
		opts = { silent = false },
		description = "close buffer",
	},
	{
		mode = "n",
		lhs = norl.save_window,
		rhs = [[<cmd>w<CR>]],
		opts = { silent = false },
		description = "save buffer",
	},
	{
		mode = "n",
		lhs = norl.saveALL_and_exitALL,
		rhs = [[:wa<CR>:q<CR>]],
		opts = { silent = false },
		description = "save all and exit all",
	},
	{
		mode = "n",
		lhs = norl.quit_without_save,
		rhs = [[:qa!<CR>]],
		opts = { silent = false },
		description = "exit all without save",
	},
	-- window behavior
	{
		mode = "n",
		lhs = norl.quit_window,
		rhs = [[:q<CR>]],
		opts = { silent = false },
		description = "close window",
	},
	{
		mode = "n",
		lhs = norl.horizontal_split,
		rhs = [[:sp<CR>]],
		opts = { silent = false },
		description = "horizontal_split window",
	},
	{
		mode = "n",
		lhs = norl.vertical_split,
		rhs = [[:vsp<CR>]],
		opts = { silent = false },
		description = "vertical_split window",
	},
	-- window jumps
	{
		mode = "n",
		lhs = norl.window_left,
		rhs = [[<C-w>h]],
	},
	{
		mode = "n",
		lhs = norl.window_down,
		rhs = [[<C-w>j]],
	},
	{
		mode = "n",
		lhs = norl.window_up,
		rhs = [[<C-w>k]],
	},
	{
		mode = "n",
		lhs = norl.window_right,
		rhs = [[<C-w>l]],
	},
	{
		mode = "n",
		lhs = norl.goto_window_sequence,
		rhs = [[<C-w><C-w>]],
	},
	-- adjust window size
	{
		mode = "n",
		lhs = norl.move_2up,
		rhs = [[:res +2<CR>]],
		opts = { silent = false },
		description = "move the window up +2",
	},
	{
		mode = "n",
		lhs = norl.move_2down,
		rhs = [[:res -2<CR>]],
		opts = { silent = false },
		description = "move the window down +2",
	},
	{
		mode = "n",
		lhs = norl.move_2left,
		rhs = [[:vertical resize-2<CR>]],
		opts = { silent = false },
		description = "move the window left +2",
	},
	{
		mode = "n",
		lhs = norl.move_2right,
		rhs = [[:vertical resize+2<CR>]],
		opts = { silent = false },
		description = "move the window right +2",
	},
	{
		mode = "n",
		lhs = norl.move_resize,
		rhs = [[<C-w>=]],
		opts = { silent = false },
		description = "restore the window size",
	},
}

local visul = keybindingAlias.visul
unsetmap.visual = visul.goto_command_mode
if vim.fn.mapcheck(unsetmap.visual, "v") ~= "" then
	vim.api.nvim_del_keymap("v", unsetmap.visual)
end
keybind.editorVisual = {
	-- goto command mode
	{
		mode = "v",
		lhs = visul.goto_command_mode,
		rhs = [[:]],
		opts = { silent = false },
	},
	-- jumps
	{
		mode = "v",
		lhs = visul.go_down_5line,
		rhs = [[5j]],
	},
	{
		mode = "v",
		lhs = visul.go_up_5line,
		rhs = [[5k]],
	},
	-- copy to sys clipboard
	{
		mode = "v",
		lhs = visul.cp_to_sysClipboard,
		rhs = [["+y]],
		opts = { silent = false },
		description = "copy to sys clipboard",
	},
}

local cmand = keybindingAlias.cmand
keybind.editorCommand = {
	{
		mode = "c",
		lhs = cmand.select_next,
		rhs = [[<C-n>]],
	},
	{
		mode = "c",
		lhs = cmand.select_pre,
		rhs = [[<C-p>]],
	},
}

local term = keybindingAlias.term
unsetmap.terminal = term.goto_command_mode
if vim.fn.mapcheck(unsetmap.terminal, "v") ~= "" then
	vim.api.nvim_del_keymap("v", unsetmap.terminal)
end
keybind.editorTerminal = {
	-- open terminal
	{
		mode = "t",
		lhs = term.horizontal_split,
		rhs = [[:sp | terminal<CR>]],
		opts = { silent = false },
		description = "open terminal horizontal split",
	},
	{
		mode = "t",
		lhs = term.vertical_split,
		rhs = [[:vsp | terminal<CR>]],
		opts = { silent = false },
		description = "open terminal vertical split",
	},
	-- term to normal
	{
		mode = "t",
		lhs = term.term_to_normal,
		rhs = [[<C-\><C-n>]],
	},
	-- term to command
	{
		mode = "t",
		lhs = term.goto_command_mode,
		rhs = [[<C-\><C-N>:]],
		opts = { silent = false },
		description = "goto command mode",
	},
	-- window jumps
	{
		mode = "t",
		lhs = term.window_left,
		rhs = [[<C-\><C-N><C-w>h]],
	},
	{
		mode = "t",
		lhs = term.window_down,
		rhs = [[<C-\><C-N><C-w>j]],
	},
	{
		mode = "t",
		lhs = term.window_up,
		rhs = [[<C-\><C-N><C-w>k]],
	},
	{
		mode = "t",
		lhs = term.window_right,
		rhs = [[<C-\><C-N><C-w>l]],
	},
}

-- plugin keybindings
local nvimTree = keybindingAlias.nvimTree
keybind.nvimTree = {
	{
		mode = "n",
		lhs = nvimTree.NvimTreeToggle,
		rhs = [[:NvimTreeToggle<CR>]],
		description = "nvim-tree toggle",
	},
}

local bufferline = keybindingAlias.bufferline
keybind.bufferline = {
	{
		mode = "n",
		lhs = bufferline.BufferLineCyclePrev,
		rhs = [[:BufferLineCyclePrev<CR>]],
		description = "bufferline-goto left buffer",
	},
	{
		mode = "n",
		lhs = bufferline.BufferLineCycleNext,
		rhs = [[:BufferLineCycleNext<CR>]],
		description = "bufferline-goto right buffer",
	},
	{
		mode = "n",
		lhs = bufferline.BufferLineMovePrev,
		rhs = [[:BufferLineMovePrev<CR>]],
		description = "bufferline-move buffer left",
	},
	{
		mode = "n",
		lhs = bufferline.BufferLineMoveNext,
		rhs = [[:BufferLineMoveNext<CR>]],
		description = "bufferline-move buffer right",
	},
}
keybind.comment = {
	{
		mode = "n",
		lhs = [[<C-_>]],
		rhs = [[gccA<Space>]],
		opts = { noremap = false },
	},
	{
		mode = "v",
		lhs = [[<C-_>]],
		rhs = [[gc]],
		opts = { noremap = false },
	},
	{
		mode = "i",
		lhs = [[<C-_>]],
		rhs = [[<Esc>gccA<Space>]],
		opts = { noremap = false },
	},
}

local telesp = keybindingAlias.telescope
keybind.telescope = {
	{
		mode = "n",
		lhs = telesp.find_files,
		rhs = [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({initial_mode = 'insert'})<CR>]],
		description = "telescope-current buffer fuzzy find",
	},
	{
		mode = "i",
		lhs = telesp.find_files_insertmode,
		rhs = [[<Esc>:lua require('telescope.builtin').current_buffer_fuzzy_find({initial_mode = 'insert'})<CR>]],
		description = "telescope-current buffer fuzzy find",
	},
}

local yankyy = require("keybindingAlias").yanky
keybind.yanky = {
	{
		mode = { "n", "x" },
		lhs = yankyy.yanky_after,
		rhs = [[<Plug>(YankyPutAfter)]],
		opts = { noremap = false },
		description = "yanky-paste after",
	},
	{
		mode = { "n", "x" },
		lhs = yankyy.yanky_before,
		rhs = [[<Plug>(YankyPutBefore)]],
		opts = { noremap = false },
		description = "yanky-paste before",
	},
	{
		mode = "i",
		lhs = ";yy",
		rhs = [[<Esc>:Telescope yank_history<cr>]],
		description = "open yank history",
	},
	{
		mode = "n",
		lhs = ";yy",
		rhs = [[:Telescope yank_history<cr>]],
		description = "open yank history",
	},
}
-- -- hop
--
-- map("i", ";gg", [[<Esc>:HopWord<cr>]], opt)
-- map("n", ";gg", [[<Esc>:HopWord<cr>]], opt)
-- map("i", ";gv", [[<Esc>:HopLine<cr>]], opt)
-- map("n", ";gv", [[<Esc>:HopLine<cr>]], opt)
-- map("i", ";gb", [[<Esc>:HopPattern<cr>]], opt)
-- ---whick-key
-- vim.keymap.set("n", "<space>s", "<cmd>Telescope xray23 list<cr>")

-- plugs-others
--
keybind.pluginKeys = {}
keybind.pluginKeys.comment = {
	-- Normal mode
	toggler = {
		line = "gcc", -- 行注释
		block = "gbc", -- 块注释
	},
	-- Visual mode
	opleader = {
		line = "gc",
		bock = "gb",
	},
}

-- LSP

local lsp = keybindingAlias.lsp
local function lsp_formatting()
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			-- NOTE: the client.name is the name of the client attached to this buffer
			return client.name == "null-ls"
		end,
		bufnr = vim.api.nvim_get_current_buf(),
		-- timeout_ms = 2000,
		async = true,
	})
end

keybind.pluginKeys.mapLSP = function(bufnr)
	vim.api.nvim_buf_set_keymap(bufnr, "n", lsp.definition, function()
		require("telescope.builtin").lsp_definitions(
			require("telescope.themes").get_cursor({ initial_mode = "normal" })
		)
	end, { noremap = true, silent = true, desc = "goto lsp definition" })
	vim.api.nvim_buf_set_keymap(bufnr, "n", lsp.references, function()
		require("telescope.builtin").lsp_references(require("telescope.themes").get_cursor({ initial_mode = "normal" }))
	end, { noremap = true, silent = true, desc = "goto lsp references" })
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		lsp.hover,
		"<cmd>lua vim.lsp.buf.hover()<CR>",
		{ noremap = true, silent = true, desc = "open lsp hover" }
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		lsp.open_flow,
		"<cmd>lua vim.diagnostic.open_float()<CR>",
		{ noremap = true, silent = true, desc = "open lsp diagnostic" }
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		lsp.goto_next,
		"<cmd>lua vim.diagnostic.goto_next()<CR>",
		{ noremap = true, silent = true, desc = "goto next diagnostic" }
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		lsp.goto_prev,
		"<cmd>lua vim.diagnostic.goto_prev()<CR>",
		{ noremap = true, silent = true, desc = "goto prev diagnostic" }
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		lsp.rename,
		"<cmd>lua vim.lsp.buf.rename()<CR>",
		{ noremap = true, silent = true, desc = "variable lsp rename" }
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		lsp.code_action,
		"<cmd>lua vim.lsp.buf.code_action()<CR>",
		{ noremap = true, silent = true, desc = "lsp code action" }
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		lsp.format,
		lsp_formatting,
		{ noremap = true, silent = true, desc = "lsp code format" }
	)
	vim.api.nvim_buf_set_keymap(
		bufnr,
		"n",
		lsp.signature_help,
		"<cmd>lua vim.lsp.buf.signature_help()<CR>",
		{ noremap = true, silent = true, desc = "open function signature help" }
	)
	vim.api.nvim_buf_set_keymap(bufnr, "n", lsp.implementations, function()
		require("telescope.builtin").lsp_implementations(
			require("telescope.themes").get_cursor({ initial_mode = "normal" })
		)
	end, { noremap = true, silent = true, desc = "goto interface implementation" })
	vim.api.nvim_buf_set_keymap(bufnr, "n", lsp.type_definitions, function()
		require("telescope.builtin").lsp_type_definitions(
			require("telescope.themes").get_cursor({ initial_mode = "normal" })
		)
	end, { noremap = true, silent = true, desc = "goto type definition" })
end

-- nvim-dap
local dapp = keybindingAlias.dap
keybind.pluginKeys.mapDAP = function()
	-- 结束dap
	-- vim.api.nvim_set_keymap(
	-- 	"n",
	-- 	dapp.debugg_end,
	-- 	"<cmd>lua require'dap'.close()<CR>"
	-- 		.. "<cmd>lua require'dap'.terminate()<CR>"
	-- 		.. "<cmd>lua require'dap.repl'.close()<CR>"
	-- 		.. "<cmd>lua require'dapui'.close()<CR>"
	-- 		.. "<cmd>lua require('dap').clear_breakpoints()<CR>"
	-- 		.. '<cmd>exe "normal <c-w>o"<CR>'
	-- 		.. "<cmd>stopinsert",
	-- 	{ noremap = true, silent = true, desc = "terminate debuggings" }
	-- )
	vim.api.nvim_set_keymap(
		"n",
		dapp.debugg_end,
		"<cmd>DapCloseWin<CR>",
		{ noremap = true, silent = true, desc = "terminate debuggings" }
	)
	-- 继续
	vim.api.nvim_set_keymap(
		"n",
		dapp.debugg,
		":lua require'dap'.continue()<CR>",
		{ noremap = true, silent = true, desc = "start debuggings" }
	)
	-- 设置断点
	vim.api.nvim_set_keymap(
		"n",
		dapp.toggle_breakpoint,
		":lua require('dap').toggle_breakpoint()<CR>",
		{ noremap = true, silent = true, desc = "toggle breakpoint" }
	)
	vim.api.nvim_set_keymap(
		"n",
		dapp.clear_breakpoints,
		":lua require('dap').clear_breakpoints()<CR>",
		{ noremap = true, silent = true, desc = "clear breakpoint" }
	)
	--  stepOver, stepOut, stepInto
	vim.api.nvim_set_keymap(
		"n",
		dapp.debugg_step_over,
		":lua require'dap'.step_over()<CR>",
		{ noremap = true, silent = true, desc = "step over debug" }
	)
	-- vim.api.nvim_set_keymap(
	-- 	"n",
	-- 	"<F10>",
	-- 	":lua require'dap'.step_over()<CR>",
	-- 	{ noremap = true, silent = true, desc = "" }
	-- )
	-- vim.api.nvim_set_keymap(
	-- 	"n",
	-- 	"<F11>",
	-- 	":lua require'dap'.step_into()<CR>",
	-- 	{ noremap = true, silent = true, desc = "" }
	-- )
	-- vim.api.nvim_set_keymap(
	-- 	"n",
	-- 	"<F12> ",
	-- 	":lua require'dap'.step_out()<CR>",
	-- 	{ noremap = true, silent = true, desc = "" }
	-- )

	-- 弹窗
	-- require("dapui").eval(<expression>)
	vim.api.nvim_set_keymap(
		"n",
		dapp.eval_expression,
		":lua require'dapui'.eval()<CR>",
		{ noremap = true, silent = true, desc = "evaluate expression" }
	)
	vim.api.nvim_set_keymap(
		"v",
		dapp.eval_expression_visual,
		":lua require('dapui').eval()<CR>",
		{ noremap = true, silent = true, desc = "evaluate expression" }
	)
end

keybind.pluginKeys.cmp = function(luasnip, cmp)
	local cmpp = keybindingAlias.cmp

	-- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	local mapping = {
		[cmpp.cmp_next] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		[cmpp.cmp_pre] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		[cmpp.cmp_scroll_doc_down] = cmp.mapping.scroll_docs(-4),
		[cmpp.cmp_scroll_doc_up] = cmp.mapping.scroll_docs(4),
		[cmpp.cmp_select_next_item] = cmp.mapping(
			cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior }),
			{ "i", "c" }
		),
		[cmpp.cmp_select_prev_item] = cmp.mapping(
			cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior }),
			{ "i", "c" }
		),
		[cmpp.cmp_trigge] = cmp.mapping.complete(),
		[cmpp.cmp_abort] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
		[cmpp.cmp_confirm] = cmp.mapping({
			i = function(fallback)
				-- 如果有补全就调用cmp，没有补全项，<CR>就保持neovim原来的功能
				if cmp.visible() then
					cmp.confirm({
						select = true,
						behavior = cmp.ConfirmBehavior.Replace,
					})
				else
					fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
				end
			end,
			c = function(fallback)
				if cmp.visible() then
					cmp.confirm({
						select = false,
						behavior = cmp.ConfirmBehavior.Replace,
					})
				else
					fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
				end
			end,
		}),
	}
	return mapping
end

-- toggleterm
-- <leader>ta 浮动
-- <leader>tb 右侧
-- <leader>tc 下方
local toggletermm = keybindingAlias.toggerterm
keybind.pluginKeys.mapToggleTerm = function(toggleterm)
	vim.keymap.set({ "n", "t" }, toggletermm.toggleA, toggleterm.toggleA, { desc = "opent float terminal" })
	vim.keymap.set({ "n", "t" }, toggletermm.toggleB, toggleterm.toggleB, { desc = "opent bottom terminal" })
	vim.keymap.set({ "n", "t" }, toggletermm.toggleC, toggleterm.toggleC, { desc = "opent right side terminal" })
	vim.keymap.set({ "n", "t" }, toggletermm.toggleG, toggleterm.toggleG, { desc = "opent lazygit terminal" })
end

-- gitsigns
keybind.pluginKeys.gitsigns_on_attach = function(bufnr)
	local gitsignss = require("keybindingAlias").gitsigns
	local gs = package.loaded.gitsigns

	local function mappp(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	-- Navigation
	mappp("n", gitsignss.gs_next_hunk, function()
		if vim.wo.diff then
			return "<leader>gj"
		end
		vim.schedule(function()
			gs.next_hunk()
		end)
		return "<Ignore>"
	end, { expr = true, desc = "goto next hunk" })

	mappp("n", gitsignss.gs_pre_hunk, function()
		if vim.wo.diff then
			return "<leader>gk"
		end
		vim.schedule(function()
			gs.prev_hunk()
		end)
		return "<Ignore>"
	end, { expr = true, desc = "goto pre hunk" })

	-- Actions
	mappp({ "n", "v" }, gitsignss.stage_hunk, ":Gitsigns stage_hunk<CR>", { desc = "stage hunk" })
	mappp({ "n", "v" }, gitsignss.reset_hunk, ":Gitsigns reset_hunk<CR>", { desc = "reset hunk" })
	mappp("n", gitsignss.stage_buffer, gs.stage_buffer, { desc = "stage current buffer" })
	mappp("n", gitsignss.undo_stage_hunk, gs.undo_stage_hunk, { desc = "undo stage hunk" })
	mappp("n", gitsignss.reset_buffer, gs.reset_buffer, { desc = "reset current buffer" })
	mappp("n", gitsignss.preview_hunk, gs.preview_hunk, { desc = "preview hunk" })
	mappp("n", gitsignss.blame_line, function()
		gs.blame_line({ full = true })
	end, { desc = "blame current line" })
	mappp("n", gitsignss.diffthis, gs.diffthis, { desc = "show diff" })
	mappp("n", gitsignss.diffthiss, function()
		gs.diffthis("~")
	end, { desc = "show diff ~" })
	-- toggle
	mappp("n", gitsignss.toggle_current_line_blame, gs.toggle_current_line_blame)
	mappp("n", gitsignss.toggle_deleted, gs.toggle_deleted)

	-- Text object
	mappp({ "o", "x" }, gitsignss.select_hunk, ":<C-U>Gitsigns select_hunk<CR>")
end

return keybind
