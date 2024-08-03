local o = vim.opt
local g = vim.g
g.mapleader = " "

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
o.termguicolors = true

-- show cursor line and column
o.cursorline = true
--o.cursorcolumn = true

-- ask for confirmation instead of throwing error
o.confirm = true

-- change directory to current file
--o.autochdir = true
-- show line numbers
o.number = true
o.relativenumber = true

-- configuring indentation
o.tabstop = 2
o.expandtab = true
o.shiftwidth = 2
o.softtabstop = 2

-- match indentation while copying/yanking
o.copyindent = true

-- use system clipboard as default register
o.clipboard:append("unnamedplus")

-- no swapfile for confidential files
--o.swapfile = false

-- undo file even after exit
o.undofile = true

-- text wrapping
o.wrap = false
-- o.textwidth = 78

--[[ highlight column and setting its color(helpful for text wrapping)
makes redrawing slower
o.colorcolumn:append({ "119", })
vim.cmd('highlight ColorColumn ctermbg=232 guibg=#1a2120')
]]

-- use special symbols for whitespaces
o.list = true
o.listchars:append({ eol = "¬", }) --space = "_"

-- add title
o.title = true

-- searching text
o.ignorecase = true
o.smartcase = true
o.hlsearch = false

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
o.spell = false

-- completion settings
o.completeopt:append({ "noselect", "menuone", })

-- autocompletion settings, for English
o.complete:append({ "k," })

-- setting up omnifunc for language servers
o.omnifunc = "syntaxcomplete#Complete"
-- show completion pop up even if only one option present
o.shortmess:append("c")

-- setting the completion popup to show automatically
vim.api.nvim_create_autocmd("InsertCharPre", {
	group = vim.api.nvim_create_augroup("UserComplete", { clear = false }),
	callback = function()
		if vim.fn.pumvisible() == 1 then
			return
		end

--[[
 use <C-x>
	<C-o> for native code completion
	<C-n>, <C-p> for auto completion from current file
	<C-k> for spelling, set for current language used by `set spell`
--]]
		local key = vim.api.nvim_replace_termcodes("<C-x><C-o>", true, true, true)
		local key = vim.api.nvim_replace_termcodes("<C-x><C-o>", true, true, true)
		vim.api.nvim_feedkeys(key, "i", true)
	end
})
-- remove the preview buffer after getting out of autocomplete
vim.api.nvim_create_autocmd("CompleteDone", {
	group = vim.api.nvim_create_augroup("UserComplete", { clear = false }),
	callback = function()
		vim.cmd("pclose")
	end
})

-- custom statusline
--[[
vim.cmd "highlight StatusType guibg=#b16286 guifg=#1d2021"
vim.cmd "highlight StatusFile guibg=#fabd2f guifg=#1d2021"
vim.cmd "highlight StatusModified guibg=#1d2021 guifg=#d3869b"
vim.cmd "highlight StatusBuffer guibg=#98971a guifg=#1d2021"
vim.cmd "highlight StatusLocation guibg=#458588 guifg=#1d2021"
vim.cmd "highlight StatusPercent guibg=#1d2021 guifg=#ebdbb2"
vim.cmd "highlight StatusNorm guibg=none guifg=white"
vim.o.statusline = " "
.. ""
.. " "
.. "%l"
.. " "
.. " %#StatusType#"
.. "<< "
.. "%Y" 
.. "  "
.. " >>"
.. "%#StatusFile#"
.. "<< "
.. "%F"
.. " >>"
.. "%#StatusModified#"
.. " "
.. "%m"
.. " "
.. "%#StatusNorm#"
.. "%="
.. "%#StatusBuffer#"
.. "<< "
.. "﬘ "
.. "%n"
.. " >>"
.. "%#StatusLocation#"
.. "<< "
.. "燐 "
.. "%l,%c"
.. " >>"
.. "%#StatusPercent#"
.. "<< "
.. "%p%%  "
.. " >> "
]]
--vim.opt.statusline = "%<%t %m%r%h%w%q [%n]%=%-14.(%l,%c%V%) %P"
