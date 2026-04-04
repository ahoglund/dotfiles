-- Personal plugin additions on top of Omarchy's LazyVim base.
-- Add new plugins here or override existing LazyVim plugin configs.
-- Reference: https://www.lazyvim.org/configuration/plugins

return {
  -- GitHub Copilot
  { "github/copilot.vim" },

  -- Testing (vim-test/vim-test is the current maintained fork of janko-m/vim-test)
  -- Keymaps are in keymaps.lua under <leader>t prefix
  {
    "vim-test/vim-test",
    dependencies = { "preservim/vimux" }, -- run tests in a tmux pane
  },

  -- Seamless Ctrl+hjkl navigation between nvim splits and tmux panes
  {
    "aserowy/tmux.nvim",
    config = true,
  },

  -- Ruby / Rails
  { "tpope/vim-rails", ft = { "ruby" } },
  { "tpope/vim-bundler", ft = { "ruby" } },
  { "tpope/vim-endwise", ft = { "ruby" } }, -- auto-add 'end' in Ruby

  -- Alignment (e.g. :Tabularize /=  or  :Tabularize /:\zs)
  { "godlygeek/tabular" },

  -- Go support
  -- Alternative: enable LazyVim's built-in Go extra via :LazyExtras
  { "fatih/vim-go", ft = { "go" } },

  -- LSP: additional language servers (auto-installed via Mason)
  -- LazyVim will install and configure these automatically
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {},
        sorbet = {}, -- Ruby type checking (Stripe's Sorbet)
      },
    },
  },
}
