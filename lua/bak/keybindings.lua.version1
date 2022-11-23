-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local keybindingAlias = require("keybindingAlias")

local map = vim.api.nvim_set_keymap
local opt = { noremap = true, silent = true }

-- leader key ";"
vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

--- normal模式下键盘映射
-- magic search
-- silent = true 结果不会在command栏显示 为false会在command栏显示
-- map("n", "/", "/\\v", { noremap = true, silent = false })
-- 设置快捷键 sp 进入粘贴模式，shift p退出粘贴模式
-- 粘贴模式可以防止从网页复制内容到vim而出现奇怪的缩进问题
-- 因为vim的缩减处理和一般文本编辑器不一样
-- "<cr>是enter键
map("n", "sp", ":set paste<CR>", opt)
map("n", "P", ":set nopaste<CR>", opt)

-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map("n", "<C-u>", "10k", opt)
map("n", "<C-d>", "10j", opt)

-- 上下滚动浏览
map("n", "<C-j>", "5j", opt)
map("n", "<C-k>", "5k", opt)

-- 取消 s 默认功能 s在normal模式下为进入插入模式
map("n", "s", "", opt)

-- 定义快捷键关闭当前分割窗口
map("n", "<Leader>q", ":q<CR>", opt)
-- 定义快捷键保存当前窗口内容
map("n", "<Leader>w", ":w<CR>", opt)
-- 定义快捷键保存所有窗口内容并退出 vim
map("n", "<Leader>WQ", ":wa<CR>:q<CR>", opt)
-- 不做任何保存，直接退出 vim
map("n", "<Leader>Q", ":qa!<CR>", opt)

-- 垂直分割窗口，水平分割窗口
map("n", "sh", ":sp<CR>", opt)
map("n", "sv", ":vsp<CR>", opt)

-- s + 方向键 窗口之间跳转
map("n", "s<left>", "<C-w>h", opt)
map("n", "s<down>", "<C-w>j", opt)
map("n", "s<up>", "<C-w>k", opt)
map("n", "s<right>", "<C-w>l", opt)
-- 依次遍历子窗口
map("n", "nw", "<C-W><C-W>", opt)
-- 上下比例
map("n", "sk", ":res +2<CR>", opt)
map("n", "sj", ":res -2<CR>", opt)
-- 左右比例
map("n", "s,", ":vertical resize+2<CR>", opt)
map("n", "s.", ":vertical resize-2<CR>", opt)
-- 相等比例
map("n", "s=", "<C-w>=", opt)

--- visual模式下键盘映射
-- magic search
map("v", "/", "/\\v", { noremap = true, silent = false })
-- 上下滚动浏览
map("v", "<C-j>", "5j", opt)
map("v", "<C-k>", "5k", opt)

--- command模式下键盘映射
map("c", "<C-j>", "<C-n>", { noremap = false })
map("c", "<C-k>", "<C-p>", { noremap = false })

-- terminal模式
map("n", "st", ":sp | terminal<CR>", opt)
map("n", "stv", ":vsp | terminal<CR>", opt)
-- Esc 回 Normal 模式
map("t", "<Esc>", "<C-\\><C-n>", opt)
map("t", "s<left>", [[ <C-\><C-N><C-w>h ]], opt)
map("t", "s<down>", [[ <C-\><C-N><C-w>j ]], opt)
map("t", "s<up>", [[ <C-\><C-N><C-w>k ]], opt)
map("t", "s<right>", [[ <C-\><C-N><C-w>l ]], opt)

--------------------------------------------------------------------
local pluginKeys = {}

-- 插件快捷键
-- nvim-tree
map("n", "<space>f", ":NvimTreeToggle<CR>", opt)

--  bufferline.nvim
map("n", "<Leader>j", ":BufferLineCyclePrev<CR>", opt)
map("n", "<Leader>k", ":BufferLineCycleNext<CR>", opt)
map("n", "<Leader>h", ":BufferLineMovePrev<CR>", opt)
map("n", "<Leader>l", ":BufferLineMoveNext<CR>", opt)

-- comment
pluginKeys.comment = {
    -- Normal 模式快捷键
    toggler = {
        line = "gcc", -- 行注释
        block = "gbc", -- 块注释
    },
    -- Visual 模式
    opleader = {
        line = "gc",
        bock = "gb",
    },
}
-- ctrl + /
map("n", "<C-_>", "gcc", { noremap = false })
map("v", "<C-_>", "gcc", { noremap = false })

--- telescope
map("n", "<C-f>", "", opt)
map(
    "n",
    "<C-f>",
    "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find({initial_mode = 'normal'})<CR>",
    opt
)

-- LSP
local lsp = keybindingAlias.lsp
pluginKeys.mapLSP = function(mapbuf)
    mapbuf("n", lsp.rename, "<cmd>lua vim.lsp.buf.rename()<CR>")
    mapbuf("n", lsp.code_action, "<cmd>lua vim.lsp.buf.code_action()<CR>")
    mapbuf("n", lsp.definition, function()
        require("telescope.builtin").lsp_definitions({
            initial_mode = "normal",
        })
    end)
    -- mapbuf("n",
    --     lsp.definition,
    --     "<cmd> lua require('telescope.builtin').lsp_definitions({initial_mode = 'normal'})<CR>"
    -- )
    mapbuf("n", lsp.hover, "<cmd>lua vim.lsp.buf.hover()<CR>")
    mapbuf(
        "n",
        lsp.references,
        "<cmd>lua require('telescope.builtin').lsp_references({initial_mode = 'normal',theme='get_ivy'})<CR>"
    )
    mapbuf("n", lsp.open_flow, "<cmd>lua vim.diagnostic.open_float()<CR>")
    mapbuf("n", lsp.goto_next, "<cmd>lua vim.diagnostic.goto_next()<CR>")
    mapbuf("n", lsp.goto_prev, "<cmd>lua vim.diagnostic.goto_prev()<CR>")
    mapbuf("n", lsp.format, "<cmd>lua vim.lsp.buf.format()<CR>")
end

-- nvim-dap
pluginKeys.mapDAP = function()
    -- 结束
    map(
        "n",
        "<space>w",
        ":lua require'dap'.close()<CR>"
        .. ":lua require'dap'.terminate()<CR>"
        .. ":lua require'dap.repl'.close()<CR>"
        .. ":lua require'dapui'.close()<CR>"
        .. ":lua require('dap').clear_breakpoints()<CR>"
        .. "<C-w>o<CR>",
        opt
    )
    -- 继续
    map("n", "<F5>", ":lua require'dap'.continue()<CR>", opt)
    -- 设置断点
    map("n", "<space>t", ":lua require('dap').toggle_breakpoint()<CR>", opt)
    map("n", "<space>T", ":lua require('dap').clear_breakpoints()<CR>", opt)
    --  stepOver, stepOut, stepInto
    map("n", "<F6>", ":lua require'dap'.step_over()<CR>", opt)
    -- map("n", "<F10>", ":lua require'dap'.step_over()<CR>", opt)
    -- map("n", "<F11>", ":lua require'dap'.step_into()<CR>", opt)
    -- map("n", "<F12> ", ":lua require'dap'.step_out()<CR>", opt)

    -- 弹窗
    -- require("dapui").eval(<expression>)
    map("n", "<space>h", ":lua require'dapui'.eval()<CR>", opt)
    map("v", "<Leader><Leader>", ":lua require('dapui').eval()<CR>", opt)

end

pluginKeys.cmp = function(luasnip, cmp)
    -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end
    local mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior }), { 'i', 'c' }),
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior }), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<Space>e'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close(), }),
        ['<CR>'] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() then
                    cmp.confirm({
                        select = true,
                        behavior = cmp.ConfirmBehavior.Replace,
                    })
                else
                    fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
                end
            end,
            c = function(fallback)
                if cmp.visible() then
                    cmp.confirm({
                        select = false,
                        behavior = cmp.ConfirmBehavior.Replace,
                    })
                else
                    fallback() -- If you use vim-endwise, this fallback will behave the same as vim-endwise.
                end
            end,
        })
    }
    return mapping
end


-- toggleterm
-- <leader>ta 浮动
-- <leader>tb 右侧
-- <leader>tc 下方
pluginKeys.mapToggleTerm = function(toggleterm)
    vim.keymap.set({ "n", "t" }, "<leader>ta", toggleterm.toggleA)
    vim.keymap.set({ "n", "t" }, "<leader>tb", toggleterm.toggleB)
    vim.keymap.set({ "n", "t" }, "<leader>tc", toggleterm.toggleC)
end

return pluginKeys
