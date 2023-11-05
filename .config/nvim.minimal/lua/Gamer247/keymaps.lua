local k = vim.keymap.set

-- Cursor centred while scrolling
-- not used `zz` because if caps lock is on, it will save and quit
k("n", "<C-d>", "<C-d>z.")
k("n", "<C-u>", "<C-u>z.")

-- Tab bindings
k("n", "<leader>to", ":tabnew ", { noremap = true, desc = "Create a new tab" })
k("n", "<leader>tt", ":tab ", { noremap = true, desc = "Create a new tab while executing a shell or vim command" })
k("n", "<leader>te", ":tab terminal<CR>i", { noremap = true, desc = "Create a new tab opening default terminal in insert mode" })
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
-- Can use a custom function
--k("n", "<leader>tc", function()
--	vim.cmd[[tabclose]]
--	delete_hidden_buffers()
--end, { noremap = true, desc = "Close the current tab" }) -- this closes the tab but does not close buffers
k("n", "<leader>tc", ":tabclose<CR>", { noremap = true, desc = "Close the current tab" }) -- this closes the tab but does not close buffers
-- But I prefer autocmd
vim.api.nvim_create_autocmd({ "TabClosed", }, {
	pattern = { "*", },
	callback = function()
		delete_hidden_buffers()
	end
})
k("n", "<leader>tp", ":tabprevious<CR>", { noremap = true, desc = "Move to the previous tab" })	-- can also use `gT`
k("n", "<leader>tn", ":tabnext<CR>", { noremap = true, desc = "Move to the next tab" })	-- can also use `gt`

-- Easy split generation
k("n", "<leader>wv", ":vsplit", { noremap = true, desc = "Create a vertical split" })
k("n", "<leader>ws", ":split", { noremap = true, desc = "Create a horizontal split" })

-- Easy split navigation
k("n", "<leader>h", "<C-w>h", { noremap = true, desc = "Switch to the left split" })
k("n", "<leader>l", "<C-w>l", { noremap = true, desc = "Switch to the right split" })
k("n", "<leader>j", "<C-w>j", { noremap = true, desc = "Switch to the bottom split" })
k("n", "<leader>k", "<C-w>k", { noremap = true, desc = "Switch to the top split" })

-- Adjust split sizes easier
k("n", "<leader>i", ":vertical resize +3<CR>", { noremap = true, desc = "Increase vertical split size" })
k("n", "<leader>d", ":vertical resize -3<CR>", { noremap = true, desc = "Decrease vertical split size" })

-- Buffer navigation
k("n", "<leader>bn", ":bnext<CR>", { noremap = true, desc = "Go to the next buffer" })
k("n", "<leader>bp", ":bprevious<CR>", { noremap = true, desc = "Go to the previous buffer" })
k("n", "<leader>bc", ":bd!<CR>", { noremap = true, desc = "Close the current buffer" })

-- Automatically create if, case, and function templates
k("n", "<leader>if", "iif [ @ ]; then<CR><CR>else<CR><CR>fi<ESC>/@<CR>", { noremap = true, desc = "Automatically create an if statement" })
k("n", "<leader>case", "icase \"$@\" in<CR><CR>@)   <CR>;;<CR><CR>esac<ESC>5kI<ESC>/@<CR>", { noremap = true, desc = "Automatically create a case statement" })
k("n", "<leader>func", "i@() {<CR><CR>}<ESC>2kI<ESC>/@<CR>", { noremap = true, desc = "Automatically create a function" })

-- Easy way to get back to normal mode from the home row
--k("i", "kj", "<Esc>", { noremap = true, desc = "Simulate ESC with 'kj'" })
--k("i", "jk", "<Esc>", { noremap = true, desc = "Simulate ESC with 'jk'" })

-- Automatically close brackets, parentheses, and quotes
k("i", "'", "''<left>", { noremap = true, desc = "Auto-complete single quotes" })
k("i", "\"", "\"\"<left>", { noremap = true, desc = "Auto-complete double quotes" })
k("i", "(", "()<left>", { noremap = true, desc = "Auto-complete parentheses" })
k("i", "[", "[]<left>", { noremap = true, desc = "Auto-complete square brackets" })
k("i", "{", "{}<left>", { noremap = true, desc = "Auto-complete curly braces" })
k("i", "{;", "{};<left><left>", { noremap = true, desc = "Auto-complete curly braces with a semicolon inside" })
k("i", "{<CR>", "{<CR>}<ESC>O", { noremap = true, desc = "Auto-complete curly braces and open code scope" })

-- TODO: Plugins keymaps
-- Open netrw in a 18% split in tree view
k("n", "<leader>e", ":18Lex<CR>", { noremap = true, desc = "Toggle netrw tree view" })
-- Open netrw in all tabs
--k("n", "<leader>e", ":tabdo 20Lex<CR>", { noremap = true, desc = "Toggle netrw tree view" })
