local dap = require("dap")
local dapui = require("dapui")
require("nvim-dap-virtual-text").setup({})
dapui.setup({
	-- Expand lines larger than the window
	-- Requires >= 0.7
	-- expand_lines = vim.fn.has("nvim-0.7") == 1,
	expand_lines = false,
	layouts = {
		{
			elements = {
				{
					id = "scopes",
					size = 0.25,
				},
				{
					id = "stacks",
					size = 0.25,
				},
				{
					id = "watches",
					size = 0.25,
				},
				{
					id = "breakpoints",
					size = 0.25,
				},
			},
			position = "right",
			size = 50,
		},
		{
			elements = {
				{
					id = "repl",
					size = 0.5,
				},
				{
					id = "console",
					size = 0.5,
				},
			},
			position = "bottom",
			size = 0.3,
		},
	},
	floating = {
		border = "rounded", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	icons = {
		collapsed = "",
		current_frame = "",
		expanded = "",
	},
	mappings = {
		edit = "e",
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		repl = "r",
		toggle = "t",
	},
	controls = {
		element = "repl",
		enabled = true,
		icons = {
			disconnect = "",
			pause = "",
			play = "",
			run_last = "",
			step_back = "",
			step_into = "",
			step_out = "",
			step_over = "",
			terminate = "",
		},
	},
	render = {
		indent = 2,
	},
})

--dap-ui config
--  use nvim-dap events to open and close the windows automatically
-- https://github.com/rcarriga/nvim-dap-ui
-- https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt *dap-extensions*  *dap.repl.open()*   *dap-api*
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open({ reset = true })
	vim.cmd("stopinsert")
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	-- save the repl buffer contents to a temp buffer
	local get_buffer_contents = require("dev42.common-utils").get_buffer_contents
	local ft = {
		"javascript",
		"python",
		"c",
	}
	local repl_or_terminal = {
		javascript = "dap-repl",
		python = "dap-terminal",
		c = "dap-terminal",
	}

	for _, winHandle in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_is_valid(winHandle) then
			local win_buf_ft = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(winHandle), "filetype")
			-- vim.pretty_print(win_buf_ft)
			if vim.tbl_contains(ft, win_buf_ft) then
				local bufnr = vim.fn.bufnr(repl_or_terminal[win_buf_ft])
				get_buffer_contents(bufnr)
				break
			end
		end
	end

	dapui.close({})
	local repl = dap.repl
	repl.close()
	-- close the remaining windows
	-- vim.api.nvim_command([[exe "normal \<c-w>o"]])
	vim.cmd("stopinsert")
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close({})
	local repl = dap.repl
	repl.close()
	-- vim.api.nvim_command([[exe "normal \<c-w>o"]])
	vim.cmd("stopinsert")
end

vim.fn.sign_define("DapBreakpoint", {
	text = "🚧",
	texthl = "LspDiagnosticsSignError",
	linehl = "",
	numhl = "",
})

vim.fn.sign_define("DapStopped", {
	-- text = "🤔",
	text = "🧪",
	texthl = "LspDiagnosticsSignInformation",
	linehl = "DiagnosticUnderlineInfo",
	numhl = "LspDiagnosticsSignInformation",
})

vim.fn.sign_define("DapBreakpointRejected", {
	-- text = "😢",
	text = "👀",
	texthl = "LspDiagnosticsSignHint",
	linehl = "",
	numhl = "",
})

-- vnoremap <M-k> <Cmd>lua require("dapui").eval()<CR>
-- require("dapui").eval(<expression>)
-- require("dapui").float_element(<element ID>, <optional settings>)

-- specific configuration
-- -- 加载调试器配置
local dap_config = {
	-- nodejs = require("dap.nvim-dap.config.nodejs"),
	cpp = require("dap.nvim-dap.config.cpptools"),
	-- go = require("dap.go")
}

dap.adapters.cppdbg = dap_config.cpp.adapter
for _, language in ipairs({ "c", "cpp" }) do
	dap.configurations[language] = dap_config.cpp.configuration
end

-- js
-- dap.adapters.node2 = dap_config.nodejs.adapter
-- dap.configurations.javascript = dap_config.nodejs.configuration

-- python
require("dap-python").setup(os.getenv("HOME") .. "/.local/share/nvim/mason/packages/debugpy/venv/bin/python")

-- js
require("dap-vscode-js").setup({
	-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
	-- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript" }) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Launch file",
			program = "${file}",
			cwd = "${workspaceFolder}",
		},
		{
			type = "pwa-node",
			request = "attach",
			name = "Attach",
			processId = require("dap.utils").pick_process,
			cwd = "${workspaceFolder}",
		},
	}
end

-- dap keybindings
require("keybindings").pluginKeys.mapDAP()
