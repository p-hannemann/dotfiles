return {
  {
    "williamboman/mason.nvim",
    config = function()
      require('mason').setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          "lua_ls",
          "tsserver",
          -- "eslint",
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- load lsp keymap
      require("plugins.lsp.keymaps")

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.tsserver.setup({})
      -- lspconfig.eslint.setup({})
    end
  },
}
