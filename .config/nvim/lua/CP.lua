--[[ Use precompiled headers for faster compilation. Use the same flags and macros you use during the compilation of your projects.
e.g. for the cp template I use in the snippets of the neovim, precompiled bits/stdc++.h and ext/pb_ds/assoc_container.hpp using the command
replacing {} with header name in their respective directories, use `-Winvalid-pch` to check warnings related to pre compiled headers
sudo g++ -std=c++17 -Wall -Wextra -Wshadow -Winvalid-pch -funroll-loops -finline-functions -O2 -D {}
]]
local M = {}

M.autocmd_group = "CPEnvGroup"
M.buffers = {}
M.active = false
M.io_open = false
M.io_path = '/tmp'
M.io_files = { ('%s/inp'):format(M.io_path), ('%s/out'):format(M.io_path), }

local keymap_defs = {
	{ key = "c", cmd = function(file, exe) return table.concat({ ":w | !g++ -std=c++17 -Wall -Wextra -Wshadow -Winvalid-pch -funroll-loops -finline-functions -O2 \"", file, "\" -o \"", exe, "\" > ", M.io_path, "/out 2>&1<CR><CR>" }) end },
	{ key = "r", cmd = function(_, exe)   return table.concat({ ":!ulimit -Ss 262114 && \"", exe, "\" < ", M.io_path, "/inp > ", M.io_path, "/out 2>&1<CR><CR>" }) end },
	{ key = "sc", cmd = function(file, exe) return table.concat({ ":w | !g++ -std=c++17 -Wall -Wextra -Wshadow -Winvalid-pch -funroll-loops -finline-functions -O2 -ggdb \"", file, "\" -o \"", exe, "\" > ", M.io_path, "/out 2>&1<CR><CR>" }) end },
	{ key = "sr", cmd = function(_, exe)   return table.concat({ ":belowright split term://bash<CR>iulimit -Ss 262114 && \"", exe, "\" < ", M.io_path, "/inp" }) end },
}


local snippet_path = vim.fn.stdpath('config') .. '/snippets/cpp'
local snippet_files = vim.fn.readdir(snippet_path)

local function apply_keymaps(bufnr)
	local file = vim.api.nvim_buf_get_name(bufnr)
	local exe = table.concat({ M.io_path, '/', vim.fn.fnamemodify(file, ':t:r'), }, '')
	local buf_opts = { noremap = true, silent = true }
	local map = vim.api.nvim_buf_set_keymap

	for _, file in ipairs(snippet_files) do
		local keys = table.concat({ '<leader>', file, }, '')
		pcall(vim.api.nvim_buf_del_keymap, bufnr, 'n', keys)
		if file ~= 'cpp' then
			map(bufnr, 'n', keys, table.concat({ ':read ', snippet_path, '/', file, '<CR>', }, ''), buf_opts)
		else
			map(bufnr, 'n', keys, table.concat({ ':%d | read ', snippet_path, '/', file, '<CR>kddG5kA', }, ''), buf_opts)
		end
	end

	for _, def in ipairs(keymap_defs) do
		local keys = '<leader>' .. def.key
		pcall(vim.api.nvim_buf_del_keymap, bufnr, 'n', keys)
		map(bufnr, 'n', keys, def.cmd(file, exe), buf_opts)
	end
end

local function close_io(close_buf)
	for _, name in ipairs(M.io_files) do
		local bufnr = vim.fn.bufnr(name)
		if bufnr ~= -1 then
			for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
				vim.api.nvim_win_close(win, true)
			end
			if close_buf then
				vim.api.nvim_buf_delete(bufnr, { force = true, })
			end
		end
	end
	M.io_open = false
end

local function open_io()
	vim.cmd('silent only')
	local curwin = vim.api.nvim_get_current_win()
	vim.cmd(('silent belowright vsplit +setlocal\\ noswapfile\\ nobuflisted\\ wrap|vertical\\ resize\\ 40%% %s/out'):format(M.io_path))
	vim.cmd(('silent leftabove   split +setlocal\\ noswapfile\\ nobuflisted\\ wrap %s/inp'):format(M.io_path))
	vim.api.nvim_set_current_win(curwin)
	M.io_open = true
end

function M.start()
	if M.active then
		return
	end
	M.active = true

	local bufnr = vim.api.nvim_get_current_buf()
	local ft = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
	if ft == 'cpp' then
		apply_keymaps(bufnr)
		M.buffers[bufnr] = true
		vim.schedule(open_io)
	end

	local group = vim.api.nvim_create_augroup(M.autocmd_group, { clear = true })
	vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
		group = group,
		pattern = '*.cpp',
		callback = function()
			if not M.active then return end
			local bufnr = vim.api.nvim_get_current_buf()
			if not M.buffers[bufnr] then
				apply_keymaps(bufnr)
				M.buffers[bufnr] = true
			end
		end,
	})
	vim.api.nvim_create_autocmd('BufEnter', {
		group = group,
		callback = function()
			if not M.active then return end
			local bufnr = vim.api.nvim_get_current_buf()
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			if vim.tbl_contains(M.io_files, bufname) then return end
			local ft = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
			if ft ~= 'cpp' and M.io_open then
				close_io(false)
			elseif ft == 'cpp' and not M.io_open then
				vim.schedule(open_io)
			end
		end,
	})
end

function M.stop()
	for bufnr, _ in pairs(M.buffers) do
		if vim.api.nvim_buf_is_loaded(bufnr) then
			for _, file in ipairs(snippet_files) do
				pcall(vim.api.nvim_buf_del_keymap, bufnr, 'n', table.concat({ '<leader>', file, }, ''))
			end
			for _, def in ipairs(keymap_defs) do
				pcall(vim.api.nvim_buf_del_keymap, bufnr, 'n', table.concat({ '<leader>', def.key, }, ''))
			end
		end
	end
	pcall(vim.api.nvim_del_augroup_by_name, M.autocmd_group)
	close_io(true)
	M.buffers = {}
	M.active = false
end

-- User commands
vim.api.nvim_create_user_command('CP', M.start, {})
vim.api.nvim_create_user_command('CPStop', M.stop, {})

return M
