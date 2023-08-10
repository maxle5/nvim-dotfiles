--local on_attach = function(client, bufnr)
--    local opts = { buffer = bufnr, remap = false }

--    vim.print('hello from roslyn');

--    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
--    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
--    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
--    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
--    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
--    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
--    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
--    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
--    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
--    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
--end

---- Set up nvim-cmp.
--local cmp = require'cmp'
--cmp.setup({
--  snippet = {
--    -- REQUIRED - you must specify a snippet engine
--    expand = function(args)
--      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
--      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--    end,
--  },
--  window = {
--    -- completion = cmp.config.window.bordered(),
--    -- documentation = cmp.config.window.bordered(),
--  },
--  mapping = cmp.mapping.preset.insert({
--    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--    ["<C-Space>"] = cmp.mapping.complete(),
--  }),
--  sources = cmp.config.sources({
--    { name = 'nvim_lsp' },
--    { name = 'vsnip' }, -- For vsnip users.
--    -- { name = 'luasnip' }, -- For luasnip users.
--    -- { name = 'ultisnips' }, -- For ultisnips users.
--    -- { name = 'snippy' }, -- For snippy users.
--  }, {
--    { name = 'buffer' },
--  })
--})

---- Set up lspconfig.
--local capabilities = require('cmp_nvim_lsp').default_capabilities()


--require('lspconfig').lua_ls.setup({
--    on_attach = on_attach,
--    capabilities = capabilities
--})

--require('lspconfig').roslyn.setup({
--    on_attach = on_attach,
--    capabilities = capabilities
--})




-- LSPZERO STUFF
local lsp = require("lsp-zero").preset('recommended');

-- lsp.ensure_installed({
--     'tsserver',
--     'rust_analyzer',
--     'volar',
--     'lua_ls',
-- })

local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.print('hello from roslyn');

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    -- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    -- vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    -- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    -- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    -- vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    -- vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    -- vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end

lsp.on_attach(on_attach)

lsp.setup()

-- You need to setup `cmp` after lsp-zero
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = {
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
  }
})


-- lsp.set_preferences({
--     sign_icons = {
--         error = 'E',
--         warn = 'W',
--         hint = 'H',
--         info = 'I'
--     }
-- })


-- lsp.format_on_save({
--     format_opts = {
--         async = false,
--         timeout_ms = 10000,
--     },
--     servers = {
--         ['lua_ls'] = { 'lua' },
--         ['rust_analyzer'] = { 'rust' },
--         -- ['prettier'] = { 'javascript', 'typescript', 'vue' }
--         -- if you have a working setup with null-ls
--         -- you can specify filetypes it can format.
--         -- ['null-ls'] = {'javascript', 'typescript'},
--     }
-- })


local lsp_configurations = require('lspconfig.configs')
if not lsp_configurations.roslyn then
    lsp_configurations.roslyn = {
        default_config = {
            name = 'roslyn',
            cmd = {
                "dotnet",
                "c:\\users\\max.GA\\.vscode\\extensions\\ms-dotnettools.csharp-2.0.346-win32-x64\\.roslyn\\Microsoft.CodeAnalysis.LanguageServer.dll",
                "--logLevel=Information",
                --"--starredCompletionComponentPath=C:\\Users\\max.GA\\.vscode\\extensions\\ms-dotnettools.vscodeintellicode-csharp-0.1.26-win32-x64\\components\\starred-suggestions\\node_modules\\@vsintellicode\\starred-suggestions-csharp",
                --"--extension=C:\\Users\\max.GA\\.vscode\\extensions\\ms-dotnettools.csdevkit-0.3.21-win32-x64\\components\\roslyn-visualstudio-languageservices-devkit\\node_modules\\@microsoft\\visualstudio-languageservices-devkit\\Microsoft.VisualStudio.LanguageServices.DevKit.dll",
                --"--sessionId=af60e874-a2e7-41d4-8854-b6e1646b9f601686121999271",
                "--telemetryLevel=all",
                "--extensionLogDirectory=c:\\temp\\"
            },
            filetypes = { 'cs' },
            root_dir = require('lspconfig.util').root_pattern('*.sln'),
        }
    }
end

require('lspconfig').roslyn.setup({
    on_attach = on_attach
});

-- vim.diagnostic.config({
--     virtual_text = true
-- })

-- vim.api.nvim_create_user_command("LspCapabilities", function()
--     local curBuf = vim.api.nvim_get_current_buf()
--     local clients = vim.lsp.get_active_clients { bufnr = curBuf }

--     for _, client in pairs(clients) do
--         if client.name ~= "null-ls" then
--             local capAsList = {}
--             for key, value in pairs(client.server_capabilities) do
--                 if value and key:find("Provider") then
--                     local capability = key:gsub("Provider$", "")
--                     table.insert(capAsList, "- " .. capability)
--                 end
--             end
--             table.sort(capAsList) -- sorts alphabetically
--             local msg = "# " .. client.name .. "\n" .. table.concat(capAsList, "\n")
--             vim.notify(msg, "trace", {
--                 on_open = function(win)
--                     local buf = vim.api.nvim_win_get_buf(win)
--                     vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
--                 end,
--                 timeout = 14000,
--             })
--             fn.setreg("+", "Capabilities = " .. vim.inspect(client.server_capabilities))
--         end
--     end
-- end, {})
