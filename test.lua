-- 
-- vim.pretty_print(vim.api.nvim_get_runtime_file("", true))
-- vim.pretty_print(vim.fn.stdpath("config"))

-- vim.opt.guifont = { "Hac NFM", "370Medium NF", "SauceCodePro NF", ":h30" }
-- vim.pretty_print(vim.o.guifont)
vim.pretty_print(vim.env.PATH)

local bufnr = vim.api.nvim_get_current_buf()

---@diagnostic disable-next-line: missing-parameter
local ref_params = vim.lsp.util.make_position_params()
local start = vim.loop.hrtime()
ref_params.context = { includeDeclaration = true }
vim.lsp.buf_request(bufnr, "textDocument/definition", ref_params, function(err, result, ctx, config)
	print(string.format("spent: %s ms", (vim.loop.hrtime() - start) / 1000000))
end)
