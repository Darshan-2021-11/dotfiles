local k = vim.keymap.set

-- Tab bindings
k("n", "<leader>toa", ":tabnew ", { noremap = true, }) -- opens a file relative to current path(path where neovim was opened) or absolute path
k("n", "<leader>tor", ":tabnew %:p:h/", { noremap = true, }) -- opens a file relative to current file
--k("n", "<leader>tt", ":tab ", { noremap = true, }) -- opens a new tab for a comand specified here
k("n", "<leader>tc", ":tabclose<CR>", { noremap = true, }) -- , this closes the tab but does not close buffers when used without close hidden buffer autocmd commented

-- Automatically close brackets, parentheses, and quotes
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

		-- `buffer = true` in opts make the keymaps only local to these buffers
		k("n", "<leader>cpp", string.format(':-1read %s/snippets/cpp<CR>26jA<Tab>', config_path), { buffer = true, noremap = true, silent = true, })
		-- compile and run
		k("n", "<leader>cr", string.format('<ESC>:w | !g++ -std=c++20 -Wall -Wextra -Wshadow -Winvalid-pch -O2 "%s" -o "%s" && "%s" < "%s/inp"<CR>', file, executable, executable, path), { buffer = true, noremap = true, silent = true, })
		-- run compiled
		k("n", "<leader>rc", string.format('<ESC>:!"%s" < "%s/inp"<CR>', executable, path), { buffer = true, noremap = true, silent = true, })

		-- Use precompiled headers for faster compilation. Use the same flags and
		-- macros you use during the compilation of your projects.
		-- e.g. for the cp template I use in the snippets of the neovim,
		-- precompiled bits/stdc++.h and ext/pb_ds/assoc_container.hpp using the
		-- the command
		-- sudo g++ -std=c++20 -Wall -Wextra -Wshadow -O2 -D_GLIBCXX_DEBUG=" " {}
		-- replacing {} with header name in their respective directories
	end
})

--[[ TODO: Plugins keymaps
Open netrw in a 20% split in tree view
only for one tab
]]
k("n", "<leader>n", ":20Lex<CR>", { noremap = true, })
