local ensure_plugin = function(repo_name, repo_link)
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/plugins/start/' .. repo_name
  if fn.empty(fn.glob(install_path)) > 0 then
    vim.print(repo_name .. ' plugin is not installed. Installing it...')
    fn.system({ 'git', 'clone', '--depth', '1', repo_link, install_path })
    -- Only set if stored in `/pack` in any level at `/opt` level instead of `/start`
    --vim.cmd [[ packadd repo_name ]]
    return true
  end
  return false
end

-- check if nvim-lspconfig is installed
ensure_plugin('nvim-lspconfig.nvim', 'https://github.com/neovim/nvim-lspconfig')

local lspconfig = require('lspconfig')

-- Global mappings for diagnostics.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

-- LspAttach autocommand to map keys only after the LSP server attaches to the buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <C-x><C-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }

    -- Core LSP keybindings
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gs', vim.lsp.buf.document_symbol, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)

    -- Workspace management
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)

    -- Code action and rename
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

    -- Formatting
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)

    -- Additional functionality for advanced usage
    -- Peek definition: shows definition in a floating window
    vim.keymap.set('n', 'gpd', function()
      vim.lsp.buf.definition({ reuse_win = true })
    end, opts)

    -- Go to next/previous symbol (if supported by LSP)
    vim.keymap.set('n', ']s', vim.lsp.buf.document_symbol, opts)
    vim.keymap.set('n', '[s', function()
      vim.lsp.buf.document_symbol({ direction = 'previous' })
    end, opts)

    -- Inlay hints (requires LSP support)
    vim.keymap.set('n', '<leader>ih', function()
      vim.lsp.inlay_hint(ev.buf, true)  -- enable inlay hints
    end, opts)

    -- Jump to diagnostic (error/warning/info) in the current buffer
    vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev, opts)

    -- Symbol search (if LSP supports workspace-wide symbol search)
    vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, opts)

    -- Trigger LSP server to restart for debugging purposes
    vim.keymap.set('n', '<leader>rs', vim.lsp.stop_client, opts)
  end,
})

-- Setup language servers.

-- ensure that your system has clangd installed via AUR package or package manager
--lspconfig.clangd.setup {}

-- ensure that your system has pylsp(python-lsp-server) installed via AUR package or package manager
--lspconfig.pylsp.setup {}

-- ensure that your system has tsserver(typescript-language-server) installed via AUR package or package manager
--lspconfig.tsserver.setup {}
