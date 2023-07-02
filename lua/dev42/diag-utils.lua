-- don't show some diagnostics, filter pharse: diagnostic module
local ignore_diags = {
	python = {},
	lua = {},
}
local function keep_element(diagnostic, filter_rules)
	for _, v in ipairs(filter_rules) do
		if diagnostic.message:match(v[2]) then
			return false
		end
	end
	return true
end
local function remove_element(arr, fn, rules)
	local new_index = 1
	local old_index = #arr
	for i = 1, old_index do
		if fn(arr[i], rules) then
			arr[new_index] = arr[i]
			new_index = new_index + 1
		end
	end
	for i = new_index, old_index do
		arr[i] = nil
	end
end

local orig_text_handler = vim.diagnostic.handlers.virtual_text
-- vim.pretty_print(orig_text_handler)
vim.diagnostic.handlers.virtual_text = {
	show = function(namespace, bufnr, diagnostics, opts)
		-- can also filter by namespace or other things,eg: severity bufnr ..., a diagnostic producer generate diagnostics will
		-- define a namespace, and generally this namespace represents this diagnostic producer
		remove_element(diagnostics, keep_element, ignore_diags[vim.api.nvim_buf_get_option(bufnr, "filetype")])
		orig_text_handler.show(namespace, bufnr, diagnostics, opts)
	end,
	hide = orig_text_handler.hide,
}
