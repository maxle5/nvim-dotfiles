return {
    "nvim-telescope/telescope.nvim",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                file_ignore_patterns = { "wwwroot/.*", "wwwroot\\.*" },
            },
        })

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<C-p>", builtin.find_files, {})
        --vim.keymap.set("n", "<leader>ff", builtin.git_files, {})
        vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, {})
        --vim.keymap.set("n", "<leader><leader>", builtin.buffers, {})
        vim.keymap.set("n", "<C-f>", function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
    end,
}
