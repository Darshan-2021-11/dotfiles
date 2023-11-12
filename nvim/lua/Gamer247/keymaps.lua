local k = vim.keymap.set

-- Cursor centred while scrolling
-- not used `zz` because if caps lock is on, it will save and quit
k("n", "<C-d>", "<C-d>z.")
k("n", "<C-u>", "<C-u>z.")

-- Tab bindings
k("n", "<leader>to", ":tabnew ", { noremap = true, desc = "Create a new tab" })
k("n", "<leader>tt", ":tab ", { noremap = true, desc = "Create a new tab while executing a shell or vim command" })
k("n", "<leader>tc", ":tabclose<CR>", { noremap = true, desc = "Close the current tab" }) -- this closes the tab but does not close buffers

-- wrote this two custom functions to detect and delete hidden buffers
-- took so much time to figure it out from the docs ngl
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
k("n", "<leader>tc", ":tabclose<CR>", { noremap = true, desc = "Close the current tab" }) -- this closes the tab but does not close buffers
vim.api.nvim_create_autocmd({ "TabClosed", }, {
	pattern = { "*", },
	callback = function()
		delete_hidden_buffers()
	end
})
--k("n", "<leader>tp", ":tabprevious<CR>", { noremap = true, desc = "Move to the previous tab" })	-- can also use `gT`
--k("n", "<leader>tn", ":tabnext<CR>", { noremap = true, desc = "Move to the next tab" })	-- can also use `gt`

-- Easy split generation
--k("n", "<leader>wv", ":vsplit", { noremap = true, desc = "Create a vertical split" })
--k("n", "<leader>ws", ":split", { noremap = true, desc = "Create a horizontal split" })

-- Easy split navigation
--k("n", "<leader>h", "<C-w>h", { noremap = true, desc = "Switch to the left split" })
--k("n", "<leader>l", "<C-w>l", { noremap = true, desc = "Switch to the right split" })
--k("n", "<leader>j", "<C-w>j", { noremap = true, desc = "Switch to the bottom split" })
--k("n", "<leader>k", "<C-w>k", { noremap = true, desc = "Switch to the top split" })

-- Adjust split sizes easier
k("n", "<leader>i", ":vertical resize +3<CR>", { noremap = true, desc = "Increase vertical split size" })
k("n", "<leader>d", ":vertical resize -3<CR>", { noremap = true, desc = "Decrease vertical split size" })

-- Buffer navigation
--k("n", "<leader>bn", ":bnext<CR>", { noremap = true, desc = "Go to the next buffer" })
--k("n", "<leader>bp", ":bprevious<CR>", { noremap = true, desc = "Go to the previous buffer" })
--k("n", "<leader>bc", ":bd!<CR>", { noremap = true, desc = "Close the current buffer" })

-- Automatically close brackets, parentheses, and quotes
k("i", "'", "''<left>", { noremap = true, desc = "Auto-complete single quotes" })
k("i", "\"", "\"\"<left>", { noremap = true, desc = "Auto-complete double quotes" })
k("i", "(", "()<left>", { noremap = true, desc = "Auto-complete parentheses" })
k("i", "[", "[]<left>", { noremap = true, desc = "Auto-complete square brackets" })
k("i", "{", "{}<left>", { noremap = true, desc = "Auto-complete curly braces" })
k("i", "{;", "{};<left><left>", { noremap = true, desc = "Auto-complete curly braces with a semicolon inside" })
k("i", "{<CR>", "{<CR>}<ESC>O", { noremap = true, desc = "Auto-complete curly braces and open code scope" })

-- TODO: Plugins keymaps
-- Open netrw in a 20% split in tree view
-- only for one tab
--k("n", "<leader>e", ":20Lex<CR>", { noremap = true, desc = "Toggle netrw tree view" })
-- for multiple tabs
local function toogle_netrw()
-- toogle netrw
	netrw_open = not netrw_open

-- open or close netrw in all the tabs
	local current_tabpage = vim.fn.tabpagenr()
	vim.cmd [[ tabdo 20Lex | wincmd l ]]
	vim.cmd(current_tabpage .. "tabnext")

-- to get the directory listing of the current tab, we need to reopen the
-- netrw in the current tab otherwise the netrw listing will show the folder
-- of the last tab in the list
	if netrw_open == true then
		vim.cmd [[ Lex ]]
		vim.cmd [[ 20Lex ]]
	end
end
vim.api.nvim_create_autocmd({ "VimEnter", "TabNewEntered" }, {
	pattern = { "*", },
	callback = function()
		if netrw_open == true then
			vim.cmd[[ 20Lex | wincmd l ]]
		end
	end
})
-- Open netrw in all tabs(very annoying without helper function)
k("n", "<leader>e", function() toogle_netrw() end, { noremap = true, desc = "Toggle netrw tree view" })
