local o = vim.opt
local g = vim.g
g.mapleader = " "

-- NETRW
-- remove annoying banner
g.netrw_banner = 0
-- list as tree
g.netrw_liststyle = 3
-- reuse a opened window to open file
--g.netrw_browse_split = 4
-- open new window in vertical split
--g.netrw_altv = 1
-- instead use a tab to open file
g.netrw_browse_split = 3
-- use same instance of netrw in all tabs
g.netrw_keepdir = 1
-- preview is vertical
g.netrw_preview = 1

-- open netrw with startup of nvim or a new tab
--[[
This global variable `netrw_open`, defines whether netrw should be open or not,
autocmd checks if it is true, then netrw is opened in new tab, else not.

Variable is defined in `keymaps.lua` file
--]]
netrw_open = false
-- netrw_open = true

-- setting color
o.termguicolors = true

-- show cursor line and column
o.cursorline = true
--o.cursorcolumn = true
o.cursorlineopt = { "both" }

-- ask for confirmation instead of throwing error
o.confirm = true

-- change directory to current file
o.autochdir = true
-- show line numbers
o.number = true
o.relativenumber = true

-- configuring indentation
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2

-- match indentation while copying/yanking
o.copyindent = true

-- use system clipboard as default register
o.clipboard:append("unnamedplus")

-- no swapfile
o.swapfile = false

-- undo file even after exit
o.undofile = true

-- text wrapping
o.wrap = false
o.textwidth = 79

--[[ highlight column and setting its color(helpful for text wrapping)
makes redrawing slower

o.colorcolumn:append({ "80", })
vim.cmd('highlight ColorColumn ctermbg=232 guibg=#1a2120')
--]]

-- use special symbols for whitespaces
o.list = true
o.listchars:append({ eol = "¬", space = "_" })

-- add title
o.title = true

-- searching text
o.ignorecase = true
o.smartcase = true
o.hlsearch = false

-- window spliting
o.splitbelow = false
o.splitright = true

-- tabline
o.showtabline = 2

-- fast macros
o.lazyredraw = true

-- setting spellcheck
o.spell = true

-- completion settings
o.completeopt:append({ "noselect", "menuone", })

-- autocompletion settings, for english
-- if you want autocompletion for code, see comments below
o.omnifunc = "syntaxcomplete#Complete"
o.complete:append({ "k," })

-- setting the completion popup to show automatically
o.shortmess:append("c")

-- auto trigger autocompletion
local triggers = { "." }
vim.api.nvim_create_autocmd("InsertCharPre", {
  callback = function()
    if vim.fn.pumvisible() == 1 then
      return
    end

-- use <C-x>
--	<C-o> for native code completion
--	<C-n>, <C-p> for auto completion from current file
--	<C-k> for spelling, set for current language used by `set spell`
		local key = vim.api.nvim_replace_termcodes("<C-x><C-k>", true, true, true)
		vim.api.nvim_feedkeys(key, "n", true)
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
--]]
