-- ensure that the tokyonight theme is installed
local ensure_tokyonight = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/colors/start/tokyonight.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		vim.print("Tokyonight theme is not installed. Installing theme...")
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/folke/tokyonight.nvim', install_path})
		-- Only set if stored in `/pack` in any level at `/opt` level instead of `/start`
		--vim.cmd [[packadd tokyonight.nvim]]
		return true
	end
--vim.print("Tokyonight theme already installed. Loading it...")
	return false
end

-- check if tokyonight is installed or not
ensure_tokyonight()

require("tokyonight").setup({
	-- your configuration comes here
	-- or leave it empty to use the default settings
	style = "night", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
	light_style = "day", -- The theme is used when the background is set to light
	transparent = false, -- Enable this to disable setting the background color
	terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
	styles = {
		-- Style to be applied to different syntax groups
		-- Value is any valid attr-list value for `:help nvim_set_hl`
		comments = { italic = true },
		keywords = { italic = true },
		functions = {},
		variables = {},
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "dark", -- style for sidebars, see below
		floats = "dark", -- style for floating windows
	},
	sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
	hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
	dim_inactive = true, -- dims inactive windows
	lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

	--- You can override specific color groups to use other groups or a hex color
	--- function will be called with a ColorScheme table
	---@param colors ColorScheme
	on_colors = function(colors) end,

	--- You can override specific highlights to use other groups or a hex color
	--- function will be called with a Highlights and ColorScheme table
	---@param highlights Highlights
	---@param colors ColorScheme
	on_highlights = function(highlights, colors) end,
})

-- setting colorscheme to `tokyonight-night`
vim.cmd [[ colorscheme tokyonight-night ]]
