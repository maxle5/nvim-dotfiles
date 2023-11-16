require("FTerm").setup({
	border = "rounded",
	dimensions = {
		height = 0.5,
		width = 0.5,
		y = 0,
	},
	cmd = "pwsh.exe",
})

-- Example keybindings
vim.keymap.set("n", "<leader>t", '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set("t", "<esc>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
