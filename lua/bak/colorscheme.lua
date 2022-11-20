vim.o.t_Co = 256
vim.o.termguicolors = true
vim.opt.termguicolors = true
vim.o.t_ut = ""
vim.o.t_ul = ""

vim.o.t_8f = "<Esc>[38;2;%lu;%lu;%lum"
vim.o.t_8b = "<Esc>[48;2;%lu;%lu;%lum"
vim.o.background = "dark"
-- vim.g.everforest_background = "soft"
-- vim.g.everforest_better_performance = 1
-- vim.g.everforest_enable_italic = 1
local colorscheme = "deus"
-- deus
-- tundra
-- everforest

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
	vim.notify("colorscheme: " .. colorscheme .. " 没有找到！")
	return
end
vim.g.deus_termcolors = 256
vim.cmd([[
    highlight NonText ctermfg=gray guifg=grey50
    hi SignColumn ctermbg=None guibg=None
    hi VertSplit ctermfg=None ctermbg=None cterm=None guibg=None guifg=None
    ]])

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")
