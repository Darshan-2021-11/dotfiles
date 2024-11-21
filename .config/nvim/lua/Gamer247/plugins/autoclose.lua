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

-- check if autoclose.nvim is installed
ensure_plugin('autoclose.nvim', 'https://github.com/m4xshen/autoclose.nvim')
require("autoclose").setup()
