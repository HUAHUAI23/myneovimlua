-- local str = "Undefined global `icon`."
-- vim.pretty_print(str:match("^Undefined globa"))
-- some thing filer diagnostics
local on_publish_diagnostics = vim.lsp.handlers["textDocument/publishDiagnostics"]
vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
	-- dosomething like filte diagnostics
	local ignore_diagnostic = {
		-- 不能是一个空的table 例如 {}
		-- { "dup", "^Duplicate field" },
	}
	local function keep_element(diagnostic, filter_rule)
		for _, v in ipairs(filter_rule) do
			if diagnostic.message:match(v[2]) then
				return false
			end
		end
		return true
	end
	local function remove_element(arr, fn)
		local new_index = 1
		local old_index = #arr
		for i = 1, old_index do
			if fn(arr[i], ignore_diagnostic) then
				arr[new_index] = arr[i]
				new_index = new_index + 1
			end
		end
		for i = new_index, old_index do
			arr[i] = nil
		end
	end
	remove_element(result.diagnostics, keep_element)
	on_publish_diagnostics(err, result, ctx, config)
end
