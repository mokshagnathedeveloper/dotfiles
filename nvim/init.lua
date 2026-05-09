local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Appearance
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "xiyaowong/transparent.nvim" }, -- ADD THIS LINE HERE
  
  -- Engineering Tools (LSP & Treesitter)
  { "neovim/nvim-lspconfig" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  
  -- Utility
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
})
