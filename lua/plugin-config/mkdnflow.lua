local status, mkdnflow = pcall(require, "mkdnflow")
if not status then
	vim.notify("没有找到 mkdnflow 插件", "error")
	return
end
local mkd = require("keybindingAlias").mkdnflow
if type(mkd) == "table" and mkd.enable then
	mkdnflow.setup({
		perspective = {
			priority = "current",
			fallback = "first",
		},
		wrap = true,
		mappings = {
			-- buffer go forward or backward
			MkdnGoBack = false,
			MkdnGoForward = false,
			MkdnNextLink = { "n", mkd.mkdnNextLink },
			MkdnPrevLink = { "n", mkd.mkdnPrevLink },
			MkdnDestroyLink = { "n", mkd.mkdnDestroyLink },
			MkdnTagSpan = { "v", mkd.mkdnTagSpan },
			MkdnMoveSource = { "n", mkd.mkdnMoveSource },
			MkdnYankAnchorLink = { "n", mkd.mkdnYankAnchorLink },
			MkdnYankFileAnchorLink = { "n", mkd.mkdnYankFileAnchorLink },
			MkdnToggleToDo = { { "n", "v" }, mkd.mkdnToggleToDo },
			MkdnUpdateNumbering = { "n", mkd.mkdnUpdateNumbering },
			MkdnTableNextRow = { "i", mkd.mkdnTableNextRow },
			MkdnTablePrevRow = { "i", mkd.mkdnTablePrevRow },
			MkdnFoldSection = { "n", mkd.mkdnFoldSection },
			MkdnUnfoldSection = { "n", mkd.mkdnUnfoldSection },
			MkdnTableNextCell = { "i", mkd.mkdnTableNextCell },
			MkdnTablePrevCell = { "i", mkd.mkdnTablePrevCell },
			MkdnTableNewRowBelow = { "n", mkd.mkdnTableNewRowBelow },
			MkdnTableNewRowAbove = { "n", mkd.mkdnTableNewRowAbove },
			MkdnTableNewColAfter = { "n", mkd.mkdnTableNewColAfter },
			MkdnTableNewColBefore = { "n", mkd.mkdnTableNewColBefore },
			MkdnCreateLinkFromClipboard = { { "n", "v" }, mkd.mkdnCreateLinkFromClipboard },
		},
	})

	-- NOTE: it will work in markdown file

	-- 创建 mkdnflowGroup autocommand group
	-- local mkdnflowGroup = vim.api.nvim_create_augroup("mkdnflowGroup", {
	-- 	clear = true,
	-- })
	-- vim.api.nvim_create_autocmd("FileType", {
	-- 	group = mkdnflowGroup,
	-- 	pattern = { "markdown", "md", "mdx" },
	-- 	callback = function()
	-- 		local opts = { buffer = vim.api.nvim_get_current_buf() }
	-- 		keymap("n", mkd.mkdnDestroyLink, "<cmd>MkdnDestroyLink<CR>", opts)
	-- 		keymap("n", mkd.mkdnTagSpan, "<cmd>MkdnTagSpan<CR>", opts)
	-- 		keymap({ "n", "v" }, mkd.mkdnToggleToDo, "<cmd>MkdnToggleToDo<CR>", opts)
	-- 		keymap("n", mkd.mkdnFoldSection, "<cmd>MkdnFoldSection<CR>", opts)
	-- 		keymap("n", mkd.mkdnUnfoldSection, "<cmd>MkdnUnfoldSection<CR>", opts)
	-- 	end,
	-- })
end
