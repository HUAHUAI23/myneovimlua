local M = {}
M.adapter = {
	id = "cppdbg",
	type = "executable",
	command = "OpenDebugAD7",
}
M.configuration = {
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
			local current_file = vim.fn.input("Use current file? (y/n): ", "y")
			if current_file == "y" then
				local filepath =
					vim.fn.expand(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())):gsub(" ", "\\ ")
				vim.cmd("!gcc -g -Wall " .. filepath .. " -o " .. filepath .. ".exe")
				return vim.fn.expand("%:p") .. ".exe"
			else
				-- file 触发 neovim 自带的文件补全 参考 :h input() 第三个参数
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = true,
	},
	{
		name = "Attach to gdbserver :1234",
		type = "cppdbg",
		request = "launch",
		MIMode = "gdb",
		miDebuggerServerAddress = "localhost:1234",
		miDebuggerPath = "/usr/bin/gdb",
		cwd = "${workspaceFolder}",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
	},
}
return M
