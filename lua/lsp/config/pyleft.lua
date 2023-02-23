local util = require("lspconfig.util")
local bin_name = "pyleft-langserver"
local cmd = { bin_name, "--stdio" }
local root_files = {
	"pyproject.toml",
	"setup.py",
	"setup.cfg",
	"requirements.txt",
	"Pipfile",
	"pyrightconfig.json",
	"project.md",
}
local function organize_imports()
	local params = {
		command = "pyright.organizeimports",
		arguments = { vim.uri_from_bufnr(0) },
	}
	vim.lsp.buf.execute_command(params)
end

local default_config = {
	name = "pyleft",
	autostart = true,
	single_file_support = true,
	cmd = cmd,
	filetypes = { "python" },
	root_dir = function(fname)
		return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
	end,
	settings = {
		python = {
			analysis = vim.empty_dict(),
		},
		telemetry = {
			telemetryLevel = "off",
		},
	},
}
default_config = vim.tbl_extend("force", util.default_config, default_config)
return {
	default_config = default_config,
	commands = {
		PyrightOrganizeImports = {
			organize_imports,
			description = "Organize Imports",
		},
	},
	docs = {
		description = [[
https://github.com/microsoft/pyright

`pyright`, a static type checker and language server for python
]],
	},
}
