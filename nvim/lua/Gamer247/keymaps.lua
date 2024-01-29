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
k("i", '"', '""<left>', { noremap = true, })
k("i", "(", "()<left>", { noremap = true, })
k("i", "[", "[]<left>", { noremap = true, })
k("i", "{", "{}<left>", { noremap = true, })
k("i", "{<CR>", "{<CR>}<ESC>O", { noremap = true, })

-- SNIPPETS
vim.api.nvim_create_autocmd({ "BufEnter", }, {
	group = vim.api.nvim_create_augroup('UserSnippets', { clear = false }),
	pattern = { "*.cpp", },
	callback = function()
		local config_path = vim.fn.stdpath('config')
		local path = vim.fn.expand('%:p:h')
		local executable = vim.fn.expand('%:p:r')
		local file = vim.fn.expand('%:p')

		k("n", "<leader>cpp", string.format(':-1read %s/snippets/cpp<CR>28jA<Tab>', config_path), { noremap = true, silent = true, })
		-- compile and run
		k("n", "<leader>cr", string.format('<ESC>:w | !g++ -std=c++20 -Wall -Wextra -Wshadow -O2 "%s" -o "%s" && "%s" < "%s/inp"<CR>', file, executable, executable, path), { noremap = true, silent = true, })
		-- run compiled
		k("n", "<leader>rc", string.format('<ESC>:!"%s" < "%s/inp"<CR>', executable, path), { noremap = true, silent = true, })
	end
})

--[[ TODO: Plugins keymaps
Open netrw in a 20% split in tree view
only for one tab
]]
k("n", "<leader>n", ":20Lex<CR>", { noremap = true, })
