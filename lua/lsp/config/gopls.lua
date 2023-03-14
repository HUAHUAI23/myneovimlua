local root_files = {
	"project.md",
}
local util = require("lspconfig.util")
local lspComm = require("lsp.common-config")
local opts = {
	capabilities = require("lsp.common-config").capabilities,
	on_attach = function(client, bufnr)
		lspComm.keyAttach(bufnr)
		if lspComm.navic then
			lspComm.navic.attach(client, bufnr)
		end
		vim.opt_local.winbar = lspComm.winbarrs
		-- lspComm.shwLinDiaAtom(bufnr)
		-- lspComm.hlSymUdrCursor(client, bufnr)  -- vim-illuminate plugin do this
		-- lspComm.disableFormat(client)
	end,
	handlers = require("lsp.common-config").handlers,
	root_dir = function(fname)
		return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
	end,
}
return {
	on_setup = function(server)
		server.setup(opts)
	end,
}
