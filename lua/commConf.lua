-- TODO: 1. add cmp,indentline,autopairs disable filetype list
-- 2. add std config, data path
-- 3. add more basic config switch
-- 4. lsp,dap,cmp kinds signs icons  UI
-- 5. add autocmd on neovim exit event, it save current session if current session exist,
--      NOTE: when save session, the nvimTree,undotree,outline... buffer shuould be closed
--  TODO: 6. add option to control which plugin should be loaded
--  7. use package.loaded["xxxxx"] = nil and autocommand bufReadPre to disable and enable
--  the specific plugin,
--  add large file handles to determine whether to load and unload of plugins,
--  and some other things may affects neovim's performance
--  eg: spell check
--  8. use vim.tbl.contains to simpfy ftAndCmandLeft usercommand
--  9. add todocomment jumping usercommand https://github.com/folke/todo-comments.nvim
--  10. add filetype autocommand to disable and enable the specific plugin on specific filetype
--     eg: autocmd FileType:
--          dome some thing to disable and enable the specific plugin
--          require("xxxxx").disable()
--          vim.opt.xxx=xxx
--          vim.bo.xxx=xxx
-- TODO: https://github.com/andymass/vim-matchup#detailed-feature-documentation #A common usage of these options is to automatically disable matchparen for particular file types
-- 11. add mirror site for packer, tree-sitter, mason ...
-- 12. filter some notify message (nvim-notify)
-- 13. telescope preview don't preview binary file

-- 12. semantic syntax treesitter spellcheck onenote intergration
local commconf = {}
-- CONSTANT

commconf.stdpath = vim.fn.stdpath("config")

-- file size handler
commconf.illuminateLargefileEdge = 2000 -- 2000 lines
commconf.rainbowLargefileEdge = 2000 -- 2000 lines
commconf.largefileEdge = 102400 -- 100kb
commconf.lspLargefileEdge = 5000 -- 5000 lines
commconf.lintLargefileEdge = 2000 -- 2000 lines
commconf.autoformatEdge = 102400 -- 100kb

-- basic config switch
commconf.listchar = true
commconf.simple_mode = false

-- lint    null-ls
-- https://github.com/DavidAnson/markdownlint/blob/main/schema/.markdownlint.jsonc
commconf.markdownlintConfig = vim.fn.expand("~/.config/nvim/lint-globals/.markdownlint.jsonc")
commconf.markdownPreviewCss = vim.fn.expand("~/.config/nvim/mkp-css/")

-- keybindings magic search
function commconf.magiceSearchSwitches(opts)
	if opts.vmagicSearch == "on" then
		vim.api.nvim_set_keymap("v", "/", "/\\v", { noremap = true, silent = false })
	end
	if opts.nmagicSearch == "on" then
		vim.api.nvim_set_keymap("n", "/", "/\\v", { noremap = true, silent = false })
	end
end

return commconf
