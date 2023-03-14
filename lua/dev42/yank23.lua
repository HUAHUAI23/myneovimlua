---Wrapper function for getpos() that returns only 'row' and 'col'.
---@param expr string
---@return integer[] {row, col}
local function getpos(expr)
	local p = vim.fn.getpos(expr)
	local result = { p[2], p[3] }
	return result
end

---Returns whether cursor positions are equal.
---@param expr1 string
---@param expr2 string
---@return boolean
local function same_pos(expr1, expr2)
	local p1 = getpos(expr1)
	local p2 = getpos(expr2)
	return p1[1] == p2[1] and p1[2] == p2[2]
end

---Compare position
---@param pos1 number[] #{row, col}
---@param pos2 number[] #{row, col}
---@return number[], number[] #front, end
local function which_front(pos1, pos2)
	-- Row Comparison
	if pos1[1] < pos2[1] then
		return pos1, pos2
	elseif pos1[1] > pos2[1] then
		return pos2, pos1
	else
		-- Col Comparison
		if pos1[2] < pos2[2] then
			return pos1, pos2
		else
			return pos2, pos1
		end
	end
end
function _G.get_visual_selected()
	local start, last
	-- v 可视模式选择的起始位置，等价于'<，'> 可视模式选择的结束位置, . 当前光标位置
	if same_pos(".", "v") then
		start = getpos("'<")
		last = getpos("'>")
	else
		start = getpos("v")
		last = getpos(".")
	end

	local pos_s, pos_e = which_front(start, last)

	local lines
	if pos_e[2] == 2147483647 then
		lines = vim.api.nvim_buf_get_lines(0, pos_s[1] - 1, pos_e[1], true)
	else
		lines = vim.api.nvim_buf_get_text(0, pos_s[1] - 1, pos_s[2] - 1, pos_e[1] - 1, pos_e[2], {})
	end

	local str = table.concat(lines, "\n")
	vim.fn.setreg("a", str)
	vim.fn.system("/mnt/c/windows/system32/clip.exe ", str)

	local ns = vim.api.nvim_create_namespace("yankkkk")
	if pos_e[2] == 2147483647 then
		---@diagnostic disable-next-line: param-type-mismatch
		vim.highlight.range(0, ns, "Search", { pos_s[1] - 1, 0 }, { pos_e[1], 0 }, {})
	else
		---@diagnostic disable-next-line: param-type-mismatch
		vim.highlight.range(0, ns, "Search", { pos_s[1] - 1, pos_s[2] - 1 }, { pos_e[1] - 1, pos_e[2] }, {})
	end
	---@diagnostic disable-next-line: param-type-mismatch
	vim.defer_fn(function()
		vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
		---@diagnostic disable-next-line: param-type-mismatch
	end, 500)
	return { lines = lines, str = str }
end

vim.api.nvim_set_keymap("v", ";;", [[:lua get_visual_selected()<cr>]], { noremap = true })

--  nvim_get_namespaces() nvim_buf_clear_namespace()  nvim_create_namespace()
--  nvim_buf_add_highlight() nvim_buf_get_extmark_by_id() nvim_buf_get_extmarks() nvim_buf_set_extmark()
--  vim.highlight.range() https://neovim.io/doc/user/lua.html
--
