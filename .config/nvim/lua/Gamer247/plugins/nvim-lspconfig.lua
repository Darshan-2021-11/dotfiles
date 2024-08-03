-- ensure that nvim-lspconfig is installed
local ensure_nvim_lspconfig = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/plugins/start/nvim-lspconfig.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		vim.print("nvim-lspconfig is not installed. Installing it...")
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/neovim/nvim-lspconfig', install_path})
		-- Only set if stored in `/pack` in any level at `/opt` level instead of `/start`
		--vim.cmd [[packadd nvim-lspconfig.nvim]]
		return true
	end
--vim.print("nvim-lspconfig already installed. Loading it...")
	return false
end

-- check if nvim-lspconfig is installed or not
ensure_nvim_lspconfig()

local lspconfig = require('lspconfig')

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'gs', vim.lsp.buf.document_symbol, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<leader>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})

-- Setup language servers.

-- ensure that your system has clangd installed via AUR package or package manager
--lspconfig.clangd.setup {}

-- ensure that your system has pylsp(python-lsp-server) installed via AUR package or package manager
--lspconfig.pylsp.setup {}

-- ensure that your system has tsserver(typescript-language-server) installed via AUR package or package manager
lspconfig.tsserver.setup {}
