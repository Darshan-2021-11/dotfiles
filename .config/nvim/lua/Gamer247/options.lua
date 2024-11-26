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
	group = vim.api.nvim_create_augroup('UserColorScheme', { clear = false, }),
	callback = function()
		local function replace_hl_property(hl_group, props)
			vim.api.nvim_set_hl(
				0,
				hl_group,
				vim.tbl_extend('force',
					vim.api.nvim_get_hl(
						0,
						{ name = hl_group, link = false, }),
						props
				)
			)
		end
		-- italic and color line number
		replace_hl_property('LineNr', { cterm = { italic = true, }, ctermfg = 8, })
		-- whitespace color
		replace_hl_property('Whitespace', { cterm = { italic = true, }, ctermfg = 8, ctermbg = 'NONE', })
		-- italic comments
		replace_hl_property('Comment', { cterm = { italic = true, }, })
		-- bold keywords for programming lanuguage
		for _, hl_group in ipairs({
			"Statement",
			"Type",
			--"Identifier",
			--"Constant",
			--"PreProc",
		}) do
		replace_hl_property(hl_group, { cterm = { bold = true, }, })
		end
	end,
})

-- show cursor line and column
o.cursorline = false
--[[ custom cursor of nvim
o.cursorcolumn = true
--]]
o.guicursor = ''

-- ask for confirmation instead of throwing error
o.confirm = true

--[[ change directory to current file
o.autochdir = true
--]]

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

--[[ no swapfile for confidential files
o.swapfile = false
--]]

-- undo file even after exit
o.undofile = true

-- text wrapping
o.wrap = false
-- o.textwidth = 78

-- use special symbols for whitespaces
o.list = true
o.listchars:append({ trail = '-', })

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
o.showtabline = 2
]]

-- fast macros
o.lazyredraw = true

--[[ setting spellcheck and autocomplete for English
o.spell = true
o.complete:append({ 'k', })
--]]

-- completion settings
o.completeopt:append({ 'noselect', 'menuone', })

-- show completion pop up even if only one option present
o.shortmess:append('c')
-- setting up omnifunc for language servers
--o.omnifunc = 'syntaxcomplete#Complete'

-- setting the completion popup to show automatically
-- see `:h compl-autocomplete`
vim.api.nvim_create_autocmd('InsertCharPre', {
	group = vim.api.nvim_create_augroup('UserComplete', { clear = false, }),
	buffer = vim.api.nvim_get_current_buf(),
	callback = function()
		if vim.fn.pumvisible() == 1 or vim.fn.state('m') == 'm' then
			return
		end
		local key = vim.keycode('<C-x><C-n>')
		vim.api.nvim_feedkeys(key, 'm', false)
	end,
})
