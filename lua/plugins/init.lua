-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- Set the leader key before lazy so the mappings work correctly (see lazy.nvim docs)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('lazy').setup({
  -- Colorscheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('plugins.catppuccin_conf')
    end,
  },

  -- Keymaps
  {
    'folke/which-key.nvim',
    dependencies = { 'echasnovski/mini.nvim', version = false },
    config = function()
      require('plugins.whichkey_conf')
    end,
  },

  -- Snacks
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require('plugins.snacks_conf')
    end,
  },

  -- LSP
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
      { 'j-hui/fidget.nvim', config = function() require('plugins.fidget_conf') end },
      'folke/neodev.nvim',
      { 'narutoxy/dim.lua', config = function() require('dim').setup({}) end },
    },
    config = function()
      require('plugins.lsp_conf')
    end,
  },

  -- Better error messages
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },

  -- Snippets
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.*',
    build = 'make install_jsregexp',
    config = function()
      require('plugins.luasnip_conf')
    end,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      require('plugins.cmp_conf')
    end,
  },

  -- Copilot
  {
    'github/copilot.vim',
    config = function()
      require('plugins.copilot_conf')
    end,
  },

  -- Telescope (fuzzy finder)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzy-native.nvim', build = 'make', cond = vim.fn.executable('make') == 1 },
      { 'nvim-telescope/telescope-frecency.nvim', version = '*', dependencies = { 'nvim-tree/nvim-web-devicons' } },
      { 'jvgrootveld/telescope-zoxide', config = function() require('telescope').load_extension('zoxide') end },
      { 'kelly-lin/telescope-ag', config = function() require('telescope').load_extension('ag') end },
    },
    config = function()
      require('plugins.telescope_conf')
    end,
  },

  -- Git
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({})
    end,
  },
  {
    'junegunn/gv.vim',
    dependencies = { 'tpope/vim-fugitive' },
  },

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
      pcall(require('nvim-treesitter.install').update({ with_sync = true }))
    end,
    config = function()
      require('plugins.treesitter_conf')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  { 'nvim-treesitter/playground', enabled = false },

  -- Comments
  {
    'terrortylor/nvim-comment',
    config = function()
      require('nvim_comment').setup()
    end,
  },

  -- Indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = function()
      require('plugins.indent_blankline_conf')
    end,
  },

  -- Cool cmdline
  {
    'folke/noice.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('plugins.noice_conf')
    end,
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('plugins.lualine_conf')
    end,
  },

  -- Show buffers as tabs
  'romgrk/barbar.nvim',

  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('plugins.nvim_tree_conf')
    end,
  },

  -- Save session (buffers, curr dir, etc.)
  {
    'Shatur/neovim-session-manager',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'stevearc/dressing.nvim', config = function() require('dressing').setup() end },
    },
    config = function()
      require('plugins.session_manager_conf')
    end,
  },

  -- Splash screen
  {
    'startup-nvim/startup.nvim',
    config = function()
      require('plugins.startup_conf')
    end,
  },

  -- LaTeX
  {
    'lervag/vimtex',
    config = function()
      require('plugins.vimtex_conf')
    end,
  },

  -- Winbar
  {
    'utilyre/barbecue.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('barbecue').setup()
    end,
  },

  -- Leap (fast text motions)
  {
    'ggandor/leap.nvim',
    dependencies = { 'tpope/vim-repeat' },
    config = function()
      require('leap').add_default_mappings()
    end,
  },

  -- Wakatime
  'wakatime/vim-wakatime',

  -- Terminal
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('plugins.toggleterm_conf')
    end,
  },

  -- Underline word under cursor
  {
    'RRethy/vim-illuminate',
    config = function()
      require('plugins.illuminate_conf')
    end,
  },

  -- 🦆
  'tamton-aquib/duck.nvim',

  -- Colorcolumn
  {
    'm4xshen/smartcolumn.nvim',
    enabled = false,
    config = function()
      require('plugins.smartcolumn_conf')
    end,
  },

  -- Surround
  {
    'kylechui/nvim-surround',
    config = true,
  },

  -- Peek definitions, references, etc
  {
    'dnlhc/glance.nvim',
    config = function()
      require('plugins.glance_conf')
    end,
  },

  -- Treat the file system as a text buffer
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup()
    end,
  },

  -- SSHFS
  {
    'nosduco/remote-sshfs.nvim',
    config = function()
      require('remote-sshfs').setup({})
    end,
  },

  -- Remote neovim (should replace SSHFS?)
  {
    'amitds1997/remote-nvim.nvim',
    version = '*', -- Pin to GitHub releases
    dependencies = {
      'nvim-lua/plenary.nvim', -- For standard functions
      'MunifTanjim/nui.nvim', -- To build the plugin UI
      'nvim-telescope/telescope.nvim', -- For picking between different remote methods
    },
    config = true,
  },

  -- Folds
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    config = function()
      require('ufo').setup()
    end,
  },

  -- Status column (the thing on the left with the line numbers)
  {
    'luukvbaal/statuscol.nvim',
    dependencies = { 'lewis6991/gitsigns.nvim' },
    config = function()
      require('plugins.statuscol_conf')
    end,
  },

  -- Better macros
  {
    'chrisgrieser/nvim-recorder',
    dependencies = { 'rcarriga/nvim-notify' },
    config = function()
      require('plugins.recorder_conf')
    end,
  },

  -- Scroll bar
  {
    'petertriho/nvim-scrollbar',
    config = function()
      require('plugins.scrollbar_conf')
    end,
  },

  -- Fancier markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    config = function(_, opts)
      require('render-markdown').setup(opts)
      require('render-markdown').enable()
    end,
  },

}, {
  ui = {
    border = 'rounded',
  },
})

