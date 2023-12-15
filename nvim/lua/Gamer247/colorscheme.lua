-- ensure that the tokyonight theme is installed
local ensure_tokyonight = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/colors/start/tokyonight.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		vim.print("Tokyonight theme is not installed. Installing theme...")
		fn.system({'proxychains', 'git', 'clone', '--depth', '1', 'https://github.com/folke/tokyonight.nvim', install_path})
		-- Only set if stored in `/pack` in any level at `/opt` level instead of `/start`
		--vim.cmd [[packadd tokyonight.nvim]]
		return true
	end
--vim.print("Tokyonight theme already installed. Loading it...")
	return false
end

-- check if tokyonight is installed or not
ensure_tokyonight()

-- setting colorscheme to `tokyonight-night`
vim.cmd [[ colorscheme tokyonight-night ]]
