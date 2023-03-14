local root_files = {
	"project.md",
}
local util = require("lspconfig.util")
local lspComm = require("lsp.common-config")
return {
	on_setup = function(server)
		server.setup({
			capabilities = require("lsp.common-config").capabilities,
			on_attach = function(client, bufnr)
				-- lspComm.keyAttach(bufnr)
				-- lspComm.shwLinDiaAtom(bufnr)
				-- lspComm.disableFormat(client)
				-- lspComm.hlSymUdrCursor(client, bufnr)
				if lspComm.navic then
					lspComm.navic.attach(client, bufnr)
				end
				vim.opt_local.winbar = lspComm.winbarrs
			end,
			handlers = require("lsp.common-config").handlers,
			root_dir = function(fname)
				return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
			end,
		})
	end,
}
