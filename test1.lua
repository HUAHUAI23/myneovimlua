-- on_attach = function(client, bufnr)
-- 	vim.keymap.set("n", "<leader>w", function()
-- 		local params = vim.lsp.util.make_formatting_params({})
-- 		local handler = function(err, result)
-- 			if not result then
-- 				return
-- 			end
--
-- 			vim.lsp.util.apply_text_edits(result, bufnr, client.offset_encoding)
-- 			vim.cmd("write")
-- 		end
--
-- 		client.request("textDocument/formatting", params, handler, bufnr)
-- 	end, { buffer = bufnr })
-- end

vim.print(vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })[2].name)
