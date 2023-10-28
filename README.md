# My OS's dotfiles 🚀

**IMPORTANT:** These are primarily meant for inspiration. I wouldn't just blindly use them. Proceed at your own risk!

### Relevant Files

- [.config/yabai/yabairc](.config/yabai/yabairc)
- [.config/skhd/skhdrc](.config/skhd/skhdrc)

# Neovim Setup

_This is my clone of josean-dev's neovim configuration, here's his video, added dotfiles other than his neovim's setup_
📹 lazy.nvim Neovim Guide: [How To Use lazy.nvim for an Amazing And Simple Neovim Config](https://youtu.be/6mxWayq-s9I)

### Setup Requires

- True Color Terminal
- [Neovim](https://neovim.io/) (Version 0.9 or Later)
- [Nerd Font](https://www.nerdfonts.com/) - Any nerdfont, I am using SauceCodePro Nerd Font
- [Ripgrep](https://github.com/BurntSushi/ripgrep) - For Telescope Fuzzy Finder
- If working with typescript/javascript and the typescript language server, you might need to install node.

If you are using Arch Linux like I am, you can install relevant executables given here

```bash
pacman -S neovim
```

```bash
pacman -S ripgrep
```

```bash
pacman -S nodejs npm
```

```bash
pacman -S xclip
```

## Plugins

#### Plugin Manager

- [folke/lazy.nvim](https://github.com/folke/lazy.nvim) - Amazing plugin manager

#### Dependency For Other Plugins

- [nvim-lua/plenary](https://github.com/nvim-lua/plenary.nvim) - Useful lua functions other plugins use

#### Preferred Colorscheme

- [bluz71/vim-nightfly-guicolors](https://github.com/bluz71/vim-nightfly-guicolors)

#### Navigating Between Neovim Windows and Tmux

- [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)

#### Essentials

- [tpope/vim-surround](https://github.com/tpope/vim-surround) - manipulate surroundings with "ys", "ds", and "cs"
- [vim-scripts/ReplaceWithRegister](https://github.com/vim-scripts/ReplaceWithRegister) - replace things with register with "gr"

#### File Explorer

- [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)

#### VS Code Like Icons

- [kyazdani42/nvim-web-devicons](https://github.com/kyazdani42/nvim-web-devicons)

#### Neovim Greeter

- [goolord/alpha-nvim](https://github.com/goolord/alpha-nvim)

#### Status Line

- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)

#### Buffer Line

- [akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)

#### Keymap Suggestions

- [folke/which-key.nvim](https://github.com/folke/which-key.nvim)

#### Fuzzy Finder

- [nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim) - Dependency for better performance
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy Finder
- [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim) - select/input ui improvement

#### Marking Files With Prime's Harpoon

- [ThePrimeagen/harpoon](https://github.com/ThePrimeagen/harpoon)

#### Autocompletion

- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - Completion plugin
- [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer) - Completion source for text in current buffer
- [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path) - Completion source for file system paths
- [onsails/lspkind.nvim](https://github.com/onsails/lspkind.nvim) - Vs Code Like Icons for autocompletion

#### Snippets

- [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip) - Snippet engine
- [rafamadriz/friendly-snippets](https://github.com/rafamadriz/friendly-snippets) - Useful snippets for different languages
- [saadparwaiz1/cmp_luasnip](https://github.com/saadparwaiz1/cmp_luasnip) - Completion source for snippet autocomplete

#### Managing & Installing Language Servers, Linters & Formatters

- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)

#### LSP Configuration

- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Bridges gap b/w mason & lspconfig
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Easy way to configure lsp servers
- [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) - Smart code autocompletion with lsp

#### Formatting & Linting

- [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim) - Easy way to configure formatters
- [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint) - Easy way to configure linters
- [WhoIsSethDaniel/mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) - Auto install linters & formatters on startup

#### Comments

- [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim) - toggle comments with "gc"
- [JoosepAlviste/nvim-ts-context-commentstring](https://github.com/JoosepAlviste/nvim-ts-context-commentstring) - Requires treesitter

#### Treesitter Syntax Highlighting, Autoclosing & Text Objects

- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Treesitter configuration
- [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) - Treesitter configuration
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs) - Autoclose brackets, parens, quotes, etc...
- [windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) - Autoclose tags

#### Git

- [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Show line modifications on left hand side
