require("mason").setup()
require("mason-lspconfig").setup()

local lsp_configurations = require("lspconfig.configs")
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- if not lsp_configurations.roslyn then
-- 	lsp_configurations.roslyn = {
-- 		default_config = {
-- 			name = "roslyn",
-- 			cmd = {
-- 				"dotnet",
-- 				"e:\\roslyn\\artifacts\\bin\\Microsoft.CodeAnalysis.LanguageServer\\Debug\\net7.0\\Microsoft.CodeAnalysis.LanguageServer.dll",
-- 				-- "--debug",
-- 				"--logLevel=Debug",
-- 				"--extensionLogDirectory=c:\\temp\\",
-- 				"--telemetryLevel=all",
-- 			},
-- 			filetypes = { "cs" },
-- 			root_dir = require("lspconfig.util").root_pattern("*.sln"),
-- 		},
-- 	}
-- end

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

require("roslyn").setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- require("lspconfig").roslyn.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- })

require("lspconfig").lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
		},
	},
})

require("lspconfig").volar.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
