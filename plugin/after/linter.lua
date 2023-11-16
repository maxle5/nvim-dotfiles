require("lint").linters_by_ft = {
	vue = { "eslint_d" },
	js = { "eslint_d" },
	ts = { "eslint_d" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
