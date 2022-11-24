local commconf = {}
commconf.illuminateLargefileEdge = 2000
commconf.rainbowLargefileEdge = 2000
commconf.largefileEdge = 102400 -- 100kb
commconf.lspLargefileEdge = 5000
commconf.lintLargefileEdge = 2000
commconf.autoformatEdge = 102400 -- 100kb

function commconf.switches(opts)
	if opts.vmagicSearch == "on" then
		vim.api.nvim_set_keymap("v", "/", "/\\v", { noremap = true, silent = false })
	end
	if opts.nmagicSearch == "on" then
		vim.api.nvim_set_keymap("n", "/", "/\\v", { noremap = true, silent = false })
	end
end

return commconf