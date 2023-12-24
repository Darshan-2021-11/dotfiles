local k = vim.keymap.set

--[[ Cursor centred while scrolling
not used `zz` because if caps lock is on, it will save and quit
]]
k("n", "<C-d>", "<C-d>z.")
k("n", "<C-u>", "<C-u>z.")

-- Tab bindings
k("n", "<leader>toa", ":tabnew ", { noremap = true, }) -- opens a file relative to current path(path where neovim was opened) or absolute path
k("n", "<leader>tor", ":tabnew %:p:h/", { noremap = true, }) -- opens a file relative to current file
--k("n", "<leader>tt", ":tab ", { noremap = true, }) -- opens a new tab for a comand specified here
k("n", "<leader>tc", ":tabclose<CR>", { noremap = true, }) -- , this closes the tab but does not close buffers when used without close hidden buffer autocmd commented

-- Automatically close brackets, parentheses, and quotes
k("i", "'", "''<left>", { noremap = true, })
k("i", "\"", "\"\"<left>", { noremap = true, })
k("i", "(", "()<left>", { noremap = true, })
k("i", "[", "[]<left>", { noremap = true, })
k("i", "{", "{}<left>", { noremap = true, })
k("i", "{<CR>", "{<CR>}<ESC>O", { noremap = true, })

-- SNIPPETS
vim.api.nvim_create_autocmd({ "BufEnter", }, {
	group = vim.api.nvim_create_augroup('UserSnippets', {}),
	pattern = { "*.cpp", },
	callback = function()
		local config_path = vim.fn.stdpath('config')
		local path = vim.fn.expand('%:p:h')
		local executable = vim.fn.expand('%:p:r')
		local file = vim.fn.expand('%:p')

		k("n", "<leader>cpp", string.format(':-1read %s/snippets/cpp<CR>15ja<Tab>', config_path), { noremap = true, silent = true, })
		-- compile and run
		k("n", "<leader>cr", string.format('<ESC>:w | !g++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -DONPC -O2 %s -o %s && %s < %s/inp<CR>', file, executable, executable, path), { noremap = true, silent = true, })
		-- run compiled
		k("n", "<leader>rc", string.format('<ESC>:!%s < %s/inp<CR>', executable, path), { noremap = true, silent = true, })
	end
})

--[[ OTHER FUNCIONALITIES
wrote this two custom functions to detect and delete hidden buffers
took so much time to figure it out from the docs ngl
]]
--[[
local function detect_hidden_buffers()
  local buffers = vim.api.nvim_list_bufs()
  local hidden_buffers = {}
  for _, buffer in ipairs(buffers) do
    if vim.fn.getbufinfo(buffer)[1].hidden == 1 then
    	table.insert(hidden_buffers, buffer)
    end
  end
  return hidden_buffers
end
local function delete_hidden_buffers()
  local hidden_buffers = detect_hidden_buffers()
  for _, buffer in ipairs(hidden_buffers) do
    vim.api.nvim_buf_delete(buffer, {})
  end
end
-- close hidden buffers on tab close
vim.api.nvim_create_autocmd({ "TabClosed", }, {
	group = vim.api.nvim_create_augroup('UserCloseHiddenBuffersOnTabExit', {}),
	pattern = { "*", },
	callback = function()
		delete_hidden_buffers()
	end
})

k("n", "<leader>tp", ":tabprevious<CR>", { noremap = true, })	-- can also use `gT`
k("n", "<leader>tn", ":tabnext<CR>", { noremap = true, })	-- can also use `gt`

-- Adjust split sizes easier
k("n", "<leader>i", ":vertical resize +3<CR>", { noremap = true, })
k("n", "<leader>d", ":vertical resize -3<CR>", { noremap = true, })

-- Easy split generation
k("n", "<leader>wv", ":vsplit", { noremap = true, })
k("n", "<leader>ws", ":split", { noremap = true, })

-- Easy split navigation
k("n", "<leader>h", "<C-w>h", { noremap = true, })
k("n", "<leader>l", "<C-w>l", { noremap = true, })
k("n", "<leader>j", "<C-w>j", { noremap = true, })
k("n", "<leader>k", "<C-w>k", { noremap = true, })

-- Buffer navigation
k("n", "<leader>bn", ":bnext<CR>", { noremap = true, })
k("n", "<leader>bp", ":bprevious<CR>", { noremap = true, })
k("n", "<leader>bc", ":bd!<CR>", { noremap = true, })
]]

--[[ TODO: Plugins keymaps
Open netrw in a 20% split in tree view
only for one tab
]]
k("n", "<leader>n", ":20Lex<CR>", { noremap = true, })

-- for multiple tabs
-- open netrw with startup of nvim or a new tab
--[[
This global variable `netrw_open`, defines whether netrw should be open or not,
autocmd checks if it is true, then netrw is opened in new tab, else not.

Variable is defined in `keymaps.lua` file
]]
--[[
netrw_open = false
-- netrw_open = true

local function toogle_netrw()
-- toogle netrw
	netrw_open = not netrw_open

-- open or close netrw in all the tabs
	local current_tabpage = vim.fn.tabpagenr()
	vim.cmd('tabdo 20Lex | wincmd l')
	vim.cmd(current_tabpage .. "tabnext")

-- to get the directory listing of the current tab, we need to reopen the
-- netrw in the current tab otherwise the netrw listing will show the folder
-- of the last tab in the list
	if netrw_open == true then
		vim.cmd('Lex')
		vim.cmd('20Lex')
	end
end
vim.api.nvim_create_autocmd({ "VimEnter", "TabNewEntered" }, {
	group = vim.api.nvim_create_augroup('UserOpenNetrwIfnetrw_open', {}),
	pattern = { "*", },
	callback = function()
		if netrw_open == true then
			vim.cmd('20Lex | wincmd l')
		end
	end
})

-- Open netrw in all tabs(very annoying without helper function)
k("n", "<leader>n", function() toogle_netrw() end, { noremap = true, })
]]
