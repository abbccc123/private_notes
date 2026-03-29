#!/usr/bin/env lua

vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.wildmenu = true
vim.opt.cindent = true
vim.opt.expandtab = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.showcmd = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.cursorline = true
vim.opt.showmatch = true
vim.opt.list = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.confirm = true

vim.opt.wrap = false
vim.opt.cursorcolumn = false
vim.opt.hidden = false

vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.scrolloff = 99
vim.opt.conceallevel = 0
vim.opt.laststatus = 2

vim.opt.guifont = 'Source Code Pro Medium 13'
vim.opt.background = 'dark'
vim.opt.mouse = ''

vim.opt.completeopt:append({ 'menuone' })
vim.opt.path:append({ '/usr/include/**' })

vim.opt.shortmess:remove({ 'S' })

vim.cmd.colorscheme("retrobox")

vim.keymap.set('', 'j', 'gj')
vim.keymap.set('', 'k', 'gk')
vim.keymap.set('', '<F3>', '<C-C>:w<CR>')

vim.keymap.set('n', '<F7>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-G>', '2<C-G>')
vim.keymap.set('n', '<tab>', '<C-W>')
vim.keymap.set('n', '<space>l', '<cmd>vertical terminal<CR><C-W>L<cmd>startinsert<CR>')
vim.keymap.set('n', '<space>h', '<cmd>vertical terminal<CR><C-W>H<cmd>startinsert<CR>')
vim.keymap.set('n', '<space>k', '<cmd>vertical terminal<CR><C-W>K<cmd>startinsert<CR>')
vim.keymap.set('n', '<space>j', '<cmd>vertical terminal<CR><C-W>J<cmd>startinsert<CR>')
vim.keymap.set('n', '<space><space>', '<cmd>horizontal terminal<CR><cmd>startinsert<CR>')
vim.keymap.set('n', '<Esc>u', '<C-u>')
vim.keymap.set('n', '<Esc>d', '<C-d>')
vim.keymap.set('n', 'K', 'k')
vim.keymap.set('n', '<F2>', '<C-i>')
vim.keymap.set('n', '<C-p>', '<C-i>')

vim.keymap.set('i', '<C-c>', '<C-c>:w<CR>')
vim.keymap.set('i', '<Esc>', '<C-c>:w<CR>')

vim.keymap.set('t', '<tab><tab>', '<C-\\><C-n>')
vim.keymap.set('t', '<tab>h', '<tab><tab><C-w>h', { remap = true })
vim.keymap.set('t', '<tab>j', '<tab><tab><C-w>j', { remap = true })
vim.keymap.set('t', '<tab>k', '<tab><tab><C-w>k', { remap = true })
vim.keymap.set('t', '<tab>l', '<tab><tab><C-w>l', { remap = true })
vim.keymap.set('t', '<tab>q', '<C-d>')
vim.keymap.set('t', '<tab>t', '<cmd>horizontal terminal<CR>')

vim.api.nvim_create_autocmd("WinEnter", {
    group = vim.api.nvim_create_augroup("term_win_eve", { clear = true }),
    pattern = 'bash',
    callback = function(arg)
        if string.match(arg.file, '^term://') then
            vim.cmd("startinsert")
        end
    end,
})
