local on_attach = function(client, bufnr)
	vim.print("LSP attached...")

	-- show help in a floating window
	vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
	vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })

	vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { buffer = 0 })
	vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { buffer = 0 })
	vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", { buffer = 0 })

	vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0 })
	vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { buffer = 0 })
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
end

return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
		"jmederosalvarado/roslyn.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"tsserver",
			},
		})

		-- setup LSPs
		require("lspconfig").lua_ls.setup({
			on_attach = on_attach,
		})
		require("lspconfig").rust_analyzer.setup({
			on_attach = on_attach,
		})
		require("lspconfig").volar.setup({
			on_attach = on_attach,
		})
		require("lspconfig").tsserver.setup({
			on_attach = on_attach,
		})
		require("roslyn").setup({
			on_attach = on_attach,
			-- capabilities = <capabilities you would pass to nvim-lspconfig>, -- required
		})
	end,
}
