local capabilities = require("lsp.common-config").capabilities
capabilities.offsetEncoding = { "utf-16" }
local opts = {
	capabilities = capabilities,
	---@diagnostic disable-next-line: unused-local
	on_attach = function(client, bufnr)
		local lspComm = require("lsp.common-config")
		-- lspComm.keyAttach(bufnr)
		-- lspComm.shwLinDiaAtom(bufnr)
		-- lspComm.hlSymUdrCursor(client, bufnr)
		-- lspComm.disableFormat(client)
		if lspComm.navic then
			lspComm.navic.attach(client, bufnr)
		end
		vim.opt_local.winbar = lspComm.winbarrs
	end,
	handlers = require("lsp.common-config").handlers,
}
return {
	on_setup = function(server)
		server.setup(opts)
	end,
}
