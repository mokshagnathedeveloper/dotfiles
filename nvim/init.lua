local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Global System Options
vim.opt.clipboard = "unnamedplus" -- Sync system clipboard

require("lazy").setup({
  -- Appearance
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  { "xiyaowong/transparent.nvim" }, 
  
  { 
    "nvim-lualine/lualine.nvim", 
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local status_ok, lualine = pcall(require, "lualine")
      if not status_ok then return end
      
      lualine.setup({
        options = {
          theme = 'auto', 
          globalstatus = true,
        }
      })
    end
  },
  
  -- Engineering Tools (LSP & Treesitter)
  { "neovim/nvim-lspconfig" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  
  -- Utility
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
})

-- Telescope keybindings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

-- Apply your colorscheme safely after Lazy sets up
pcall(vim.cmd.colorscheme, "catppuccin-mocha")

-- Setup transparency to clear the background layers
local trans_ok, transparent = pcall(require, "transparent")
if trans_ok then
  transparent.setup({
    extra_groups = {
      "NormalFloat", 
      "NvimTreeNormal", 
      "TelescopeNormal", 
      "TelescopeBorder",
    },
  })
end
