local ensure_theme = function(repo_name, repo_link)
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/colors/start/' .. repo_name
  if fn.empty(fn.glob(install_path)) > 0 then
    vim.print(repo_name .. ' theme is not installed. Installing theme...')
    fn.system({ 'git', 'clone', '--depth', '1', repo_link, install_path })
    -- Only set if stored in `/pack` in any level at `/opt` level instead of `/start`
    --vim.cmd [[ packadd repo_name ]]
    return true
  end
  return false
end
-- check if tokyonight theme is installed
--ensure_theme('tokyonight.nvim', 'https://github.com/folke/tokyonight.nvim')'
vim.cmd [[ colorscheme vim ]]
