--[[ TODO: Plugins keymaps
Open netrw in a 20 width split in tree view
]]
vim.api.nvim_set_keymap('n', '<leader>n', ':20Lex<CR>', { noremap = true, silent = true, })

--[[
vim.api.nvim_set_keymap('n', '<leader>bn', ':bnext<CR>', { noremap = true, silent = true, }) -- switch to the next buffer
vim.api.nvim_set_keymap('n', '<leader>bp', ':bprevious<CR>', { noremap = true, silent = true, }) -- switch to the previous buffer
vim.api.nvim_set_keymap('n', '<leader>to', ':tabnew ', { noremap = true, silent = true, }) -- opens a file relative to current path
vim.api.nvim_set_keymap('n', '<leader>tO', ':tabnew %:h/', { noremap = true, silent = true, }) -- opens a file relative to current file
vim.api.nvim_set_keymap('n', '<leader>tc', ':tabclose<CR>', { noremap = true, silent = true, }) -- this closes the tab but not included buffers
vim.api.nvim_set_keymap('n', '<leader>o', ':e ', { noremap = true, silent = true, }) -- open a file relative to the current path
vim.api.nvim_set_keymap('n', '<leader>O', ':e %:h/', { noremap = true, silent = true, }) -- open a file relative to the current file
vim.api.nvim_set_keymap('n', '<leader>bw', ':bwipe<CR>', { noremap = true, silent = true, }) -- delete the current buffer from memory
]]
