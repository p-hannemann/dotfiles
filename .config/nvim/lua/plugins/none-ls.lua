return {
	{
		"nvimtools/none-ls.nvim",
		-- dependencies = {
		--   "nvimtools/none-ls-extras.nvim",
		-- },
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.diagnostics.rubocop,
					null_ls.builtins.formatting.rubocop,
					null_ls.builtins.formatting.prettier,
				},
			})
		end,
		keys = {
			{ "<leader>gf", vim.lsp.buf.format, desc = "Format Code" },
		},
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {},
				automatic_installation = true,
			})
		end,
	},
}
