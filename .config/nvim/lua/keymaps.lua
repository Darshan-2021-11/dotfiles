--[[ TODO: Plugins keymaps
Open netrw in a 20 width split in tree view
]]
vim.api.nvim_set_keymap('n', '<leader>n', ':20Lex<CR>', { noremap = true, })

-- SNIPPETS
local function set_CP_cpp_keymaps(path)
	local snippet_path = vim.fn.stdpath('config') .. '/snippets/cpp'
	local executable = path .. '/' .. vim.fn.expand('%:t:r')
	local file = vim.fn.expand('%:p')

	--[[ Use precompiled headers for faster compilation. Use the same flags and macros you use during the compilation of your projects.
	e.g. for the cp template I use in the snippets of the neovim, precompiled bits/stdc++.h and ext/pb_ds/assoc_container.hpp using the command
	replacing {} with header name in their respective directories, use `-Winvalid-pch` to check warnings related to pre compiled headers
	sudo g++ -std=c++17 -Wall -Wextra -Wshadow -Winvalid-pch -funroll-loops -finline-functions -O2 -D {}
	]]
	local compile = 'g++ -std=c++17 -Wall -Wextra -Wshadow -Winvalid-pch -funroll-loops -finline-functions -O2 "' .. file .. '" -o "' .. executable .. '"'
	local debug = 'g++ -std=c++17 -Wall -Wextra -Wshadow -Winvalid-pch -funroll-loops -finline-functions -O2 -ggdb "' .. file .. '" -o "' .. executable .. '"'
	-- increasing stack size to 256mb with ulimit as soft limit
	-- for changing soft limit(-Ss), hard limit(-Hs), both(-s)
	local run = 'ulimit -Ss 262114 && "' .. executable .. '" < "' .. path .. '/inp"'

	-- `buffer = true` in opts make the keymaps only local to these buffers
	vim.api.nvim_buf_set_keymap(0, 'n', '<leader>cpp', ':%d | read ' .. snippet_path .. '/cpp<CR>kddG30<C-e>5kA', { noremap = true, silent = true, })
	-- map filename of snippet folder to copy contents
	local files = vim.fn.readdir(snippet_path)
	for _, file in ipairs(files) do
		if file ~= 'cpp' then
			vim.api.nvim_buf_set_keymap(0, 'n', '<leader>' .. file, ':read ' .. snippet_path .. '/' .. file .. '<CR>', { noremap = true, silent = true, })
		end
	end
	-- compile
	vim.api.nvim_buf_set_keymap(0, 'n', '<leader>c', ':w | !' .. compile .. ' > "' .. path .. '/out" 2>&1<CR><CR>', { noremap = true, silent = true, })
	-- run compiled
	vim.api.nvim_buf_set_keymap(0, 'n', '<leader>r', ':!' .. run .. ' > "' .. path .. '/out" 2>&1<CR><CR>', { noremap = true, silent = true, })
	-- compile inside shell
	vim.api.nvim_buf_set_keymap(0, 'n', '<leader>sc', ':w | belowright split term://bash<CR>i' .. debug .. '<CR>exit', { noremap = true, silent = true, })
	-- compile run shell
	vim.api.nvim_buf_set_keymap(0, 'n', '<leader>sr', ':belowright split term://bash<CR>i' .. run, { noremap = true, silent = true, })
end

vim.api.nvim_create_user_command('CP', function()
	--path storing `inp` and `out` files
	local path = '/tmp';

	vim.fn.execute('only')
	set_CP_cpp_keymaps(path)
	-- Open input and output file to be used in keymaps
	local winnr = vim.api.nvim_get_current_win()
	vim.fn.execute('belowright vsplit +setlocal\\ noswapfile\\ nobuflisted\\ wrap\\ |\\ vertical\\ resize\\ 40% ' .. path .. '/out')
	vim.fn.execute('leftabove split +setlocal\\ noswapfile\\ nobuflisted\\ wrap ' .. path .. '/inp')
	--[[
	vim.fn.execute('belowright vsplit ' .. path .. '/out' .. '| setlocal wrap nobuflisted noswapfile | vertical resize 40%')
	vim.fn.execute('leftabove split ' .. path .. '/inp' .. '| setlocal wrap nobuflisted noswapfile')
	]]
	vim.api.nvim_set_current_win(winnr)

	vim.api.nvim_create_autocmd({ 'BufEnter', }, {
		desc = 'Create competitive programming environment',
		group = vim.api.nvim_create_augroup('UserSnippets', { clear = false }),
		pattern = { '*.cpp', },
		callback = function()
			set_CP_cpp_keymaps(path)
		end
	})
end, {})

--[[
vim.api.nvim_set_keymap('n', '<leader>bn', ':bnext<CR>', { noremap = true, }) -- switch to the next buffer
vim.api.nvim_set_keymap('n', '<leader>bp', ':bprevious<CR>', { noremap = true, }) -- switch to the previous buffer
vim.api.nvim_set_keymap('n', '<leader>to', ':tabnew ', { noremap = true, }) -- opens a file relative to current path
vim.api.nvim_set_keymap('n', '<leader>tO', ':tabnew %:h/', { noremap = true, }) -- opens a file relative to current file
vim.api.nvim_set_keymap('n', '<leader>tc', ':tabclose<CR>', { noremap = true, }) -- this closes the tab but not included buffers
vim.api.nvim_set_keymap('n', '<leader>o', ':e ', { noremap = true, }) -- open a file relative to the current path
vim.api.nvim_set_keymap('n', '<leader>O', ':e %:h/', { noremap = true, }) -- open a file relative to the current file
vim.api.nvim_set_keymap('n', '<leader>bw', ':bwipe<CR>', { noremap = true, }) -- delete the current buffer from memory
]]
