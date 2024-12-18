vim.api.nvim_set_keymap('n', '<leader>o', ':e ', { noremap = true, }) -- open a file relative to the current file
vim.api.nvim_set_keymap('n', '<leader>O', ':e %:p:h/', { noremap = true, }) -- open a file relative to the current path
vim.api.nvim_set_keymap('n', '<leader>bd', ':bdelete<CR>', { noremap = true, }) -- delete the current buffer from memory
vim.api.nvim_set_keymap('n', '<leader>bn', ':bnext<CR>', { noremap = true, }) -- switch to the next buffer
vim.api.nvim_set_keymap('n', '<leader>bp', ':bprevious<CR>', { noremap = true, }) -- switch to the previous buffer
--[[
vim.api.nvim_set_keymap('n', '<leader>to', ':tabnew ', { noremap = true, }) -- opens a file relative to current path(path where neovim was opened) or absolute path
vim.api.nvim_set_keymap('n', '<leader>tO', ':tabnew %:p:h/', { noremap = true, }) -- opens a file relative to current file
vim.api.nvim_set_keymap('n', '<leader>tc', ':tabclose<CR>', { noremap = true, }) -- this closes the tab but does not close buffers when used without close hidden buffer autocmd commented
]]

--[[ TODO: Plugins keymaps
Open netrw in a 20 width split in tree view
]]
vim.api.nvim_set_keymap('n', '<leader>n', ':20Lex<CR>', { noremap = true, })

-- SNIPPETS
local path = '/tmp' --path storing `inp` and `out` files
local function set_CP_cpp_keymaps()
  local config_path = vim.fn.stdpath('config')
  local executable = path .. '/' .. vim.fn.expand('%:p:t:r')
  local file = vim.fn.expand('%:p')

  -- Use precompiled headers for faster compilation. Use the same flags and macros you use during the compilation of your projects.
  -- e.g. for the cp template I use in the snippets of the neovim, precompiled bits/stdc++.h and ext/pb_ds/assoc_container.hpp using the command
  -- sudo g++ -std=c++17 -Wall -Wextra -Wshadow -Winvalid-pch -funroll-loops -finline-functions -O2 -D {}
  -- replacing {} with header name in their respective directories, use `-Winvalid-pch` to check warnings related to pre compiled headers
  local compile = 'g++ -std=c++17 -Wall -Wextra -Wshadow -Winvalid-pch -funroll-loops -finline-functions -O2 "' .. file .. '" -o "' .. executable .. '"'
  -- increasing stack size to 256mb with ulimit as soft limit
  -- for changing soft limit(-Ss), hard limit(-Hs), both(-s)
  local run = 'ulimit -Ss 262114 && "' .. executable .. '" < "' .. path .. '/inp"'

  -- `buffer = true` in opts make the keymaps only local to these buffers
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>cpp', ':%d | read ' .. config_path .. '/snippets/cpp<CR>kdd5jA', { noremap = true, silent = true, })
  -- compile
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>c', ':w | !' .. compile .. ' > "' .. path .. '/out" 2>&1<CR><CR>', { noremap = true, silent = true, })
  -- run compiled
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>r', ':!' .. run .. ' > "' .. path .. '/out" 2>&1<CR><CR>', { noremap = true, silent = true, })
  -- compile inside shell
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>sc', ':w | belowright split term://bash<CR>i' .. compile .. '<CR>exit', { noremap = true, silent = true, })
  -- compile run shell
  vim.api.nvim_buf_set_keymap(0, 'n', '<leader>sr', ':belowright split term://bash<CR>i' .. run .. '<CR>exit', { noremap = true, silent = true, })

end

vim.api.nvim_create_user_command("CP", function()
  vim.api.nvim_create_autocmd({ "BufEnter", }, {
    group = vim.api.nvim_create_augroup('UserSnippets', { clear = false }),
    pattern = { "*.cpp", },
    callback = set_CP_cpp_keymaps
  })
	set_CP_cpp_keymaps()
  -- Open input and output file to be used in keymaps
  local winnr = vim.api.nvim_get_current_win()
  vim.fn.execute('belowright 20vsplit ' .. path .. '/out' .. '| setlocal wrap | set nobuflisted')
  vim.fn.execute('leftabove split ' .. path .. '/inp' .. '| setlocal wrap | set nobuflisted')
  vim.api.nvim_set_current_win(winnr)
end, {})
