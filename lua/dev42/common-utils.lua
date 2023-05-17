local M = {}
M.trim = function(s)
	return s:gsub("^%s*(.-)%s*$", "%1")
end
M.get_buffer_contents = function(bufnr)
	local buf = vim.api.nvim_create_buf(true, true)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_set_current_buf(buf)
end
-- TODO:
-- add open win function (horizontal, vertical and float)
-- dap 将调试内容以浮动窗口的形式展示
-- toggleterm add python venv

return M
