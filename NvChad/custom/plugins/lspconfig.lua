local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local servers = { "html", "cssls", "emmet_ls", "clangd", "csharp_ls", "pyright", "dartls", "yamlls", "jsonls", "gopls", "sqls", "tsserver", "bashls" }
-- local servers = { "html", "cssls", "emmet_ls", "clangd", "pyright", "yamlls", "jsonls", "gopls", "sqls", "tsserver", "bashls" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		root_dir = vim.loop.cwd,
	})
end
