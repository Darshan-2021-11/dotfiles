local o = vim.opt
local g = vim.g
g.mapleader = ' '

-- NETRW
-- remove annoying banner
--g.netrw_banner = 0
-- liststyle tree
g.netrw_liststyle = 3
-- open file in current window open
g.netrw_browse_split = 4
-- open file in a tab
--g.netrw_browse_split = 3
-- use same instance in all tabs
g.netrw_keepdir = 1

-- setting color
-- do not set this, we made color highlights according to 16-bit color
o.termguicolors = false
-- setting colorscheme options for notermguicolors
vim.api.nvim_create_autocmd('ColorScheme', {
	group = vim.api.nvim_create_augroup('UserColorScheme', { clear = false }),
	callback = function()
		-- line number color
		vim.api.nvim_set_hl(0, 'LineNr', vim.tbl_extend('force', vim.api.nvim_get_hl(0, { name = 'LineNr', link = false }), { cterm = { italic = true }, ctermfg = 8 }))
		-- highlight color column
		vim.api.nvim_set_hl(0, 'ColorColumn', vim.tbl_extend('force', vim.api.nvim_get_hl(0, { name = 'ColorColumn', link = false }), { cterm = {}, ctermbg = 8 }))
		-- whitespace color
		vim.api.nvim_set_hl(0, 'Whitespace', vim.tbl_extend('force', vim.api.nvim_get_hl(0, { name = 'Whitespace', link = false }), { cterm = { italic = true }, ctermfg = 8, ctermbg = 'NONE' }))
		-- italic comments
		vim.api.nvim_set_hl(0, 'Comment', vim.tbl_extend('force', vim.api.nvim_get_hl(0, { name = 'Comment', link = false }), { cterm = { italic = true } }))
	end,
})

-- show cursor line and column
o.cursorline = false
--o.cursorcolumn = true
-- disable custom cursor of nvim
o.guicursor = ''

-- ask for confirmation instead of throwing error
o.confirm = true

-- change directory to current file
--o.autochdir = true

-- show line numbers
o.number = true
o.relativenumber = true

-- configuring indentation
o.tabstop = 2
o.expandtab = false
o.shiftwidth = 2
o.softtabstop = 2

-- match indentation while copying/yanking
o.copyindent = true

-- use system clipboard as default register
o.clipboard:append('unnamedplus')

-- no swapfile for confidential files
--o.swapfile = false

-- undo file even after exit
o.undofile = true

-- text wrapping
o.wrap = false
-- o.textwidth = 78

-- highlight column
--o.colorcolumn:append({ '78', })

-- use special symbols for whitespaces
o.list = true
o.listchars:append({ trail = '-' })

-- add title
o.title = true

-- searching text
o.ignorecase = true
o.smartcase = true
o.hlsearch = true

--[[ window spliting
o.splitbelow = true
o.splitright = true
]]

--[[ tabline
0: never
1: only if there are at least two tab pages (default)
2: always
]]
--o.showtabline = 2

-- fast macros
o.lazyredraw = true

-- setting spellcheck
--o.spell = true

-- completion settings
o.completeopt:append({ 'noselect', 'menuone', })

-- autocompletion settings, for English
o.complete:append({ 'k,' })
-- show completion pop up even if only one option present
o.shortmess:append('c')
-- setting up omnifunc for language servers
o.omnifunc = 'syntaxcomplete#Complete'

-- setting the completion popup to show automatically
vim.api.nvim_create_autocmd('InsertCharPre', {
	group = vim.api.nvim_create_augroup('UserComplete', { clear = false }),
	callback = function()
		if vim.fn.pumvisible() == 1 then
			return
		end
		-- use <C-x>
		-- <C-o> for native code completion
		-- <C-k> for spelling, set for current language used by `set spell`
		local key = vim.api.nvim_replace_termcodes('<C-x><C-o>', true, true, true)
		vim.api.nvim_feedkeys(key, 'i', true)
	end
})
-- remove the preview buffer after getting out of autocomplete
vim.api.nvim_create_autocmd('CompleteDone', {
	group = vim.api.nvim_create_augroup('UserComplete', { clear = false }),
	callback = function()
		vim.cmd('pclose')
	end
})
