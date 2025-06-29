vim.g.mapleader = ' '

-- NETRW remove annoying banner
vim.g.netrw_banner = 0
-- liststyle tree
vim.g.netrw_liststyle = 2
-- open file in current window open
vim.g.netrw_browse_split = 4
-- use same instance in all tabs
vim.g.netrw_keepdir = 1

-- ask for confirmation instead of throwing error
vim.opt.confirm = true

-- show line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- configuring indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- match indentation while copying
vim.opt.copyindent = true

-- undo file even after exit
vim.opt.undofile = true

-- text wrapping
vim.opt.wrap = false

-- use special symbols for whitespaces
vim.opt.list = true
vim.opt.listchars:append({ trail = '-', })

-- add title
vim.opt.title = true

-- searching text
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- change directory to current file
vim.opt.autochdir = true

-- fast macros
vim.opt.lazyredraw = true

-- completion settings
vim.opt.completeopt:append({ 'noselect', 'menuone', })
-- show completion pop up even if only one option present
vim.opt.shortmess:append('c')

-- setting the completion popup to show automatically, see `:h compl-autocomplete`
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

-- setting color
vim.opt.termguicolors = false
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

--[[ show cursor line and column
vim.opt.cursorline = false
vim.opt.cursorcolumn = true
]]
--[[ use system clipboard as default register
vim.opt.clipboard:append('unnamedplus')
]]
--[[ no swapfile for confidential files
vim.opt.swapfile = false
]]
--[[ window spliting
vim.opt.splitbelow = true
vim.opt.splitright = true
]]
--[[ setting spellcheck and autocomplete for English
vim.opt.spell = true
vim.opt.complete:append({ 'k', })
]]
