-- Change directory via terminal
vim.api.nvim_create_autocmd({ 'TermRequest' }, {
	desc = 'Handles OSC 7 dir change requests',
	group = vim.api.nvim_create_augroup('UserTerminal', { clear = false }),
	callback = function(ev)
		if string.sub(ev.data.sequence, 1, 4) == '\x1b]7;' then
			local dir = string.gsub(ev.data.sequence, '\x1b]7;file://[^/]*', '')
			if vim.fn.isdirectory(dir) == 0 then
				vim.notify('invalid dir: '..dir)
				return
			end
			vim.api.nvim_buf_set_var(ev.buf, 'osc7_dir', dir)
			if vim.o.autochdir and vim.api.nvim_get_current_buf() == ev.buf then
				vim.cmd.cd(dir)
			end
		end
	end
})
vim.api.nvim_create_autocmd({ 'TermEnter', 'DirChanged' }, {
	desc = 'Handles OSC 7 dir change requests',
	group = vim.api.nvim_create_augroup('UserTerminal', { clear = false }),
	callback = function(ev)
		if vim.b.osc7_dir and vim.fn.isdirectory(vim.b.osc7_dir) == 1 then
			vim.cmd.cd(vim.b.osc7_dir)
		end
	end
})

-- Set terminal title
vim.api.nvim_create_autocmd('TermOpen', {
	desc = 'Sets terminal title as per shell',
	pattern = '*',
	callback = function()
		vim.opt_local.statusline = "%{b:term_title}"
	end,
})
