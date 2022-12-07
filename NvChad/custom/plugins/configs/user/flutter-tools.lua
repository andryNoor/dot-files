-- workaround to make null-ls formatting (dart_format) works
local on_attach = function(client, bufnr)
	if vim.g.vim_version > 7 then
		-- nightly
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	else
		-- stable
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
	end

	require("core.utils").load_mappings("lspconfig", { buffer = bufnr })

	if client.server_capabilities.signatureHelpProvider then
		require("nvchad_ui.signature").setup(client)
	end
end

-- actual flutter-tools setup (config)
require("flutter-tools").setup({
	decorations = {
		statusline = {
			-- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
			-- this will show the current version of the flutter app from the pubspec.yaml file
			app_version = true,
			-- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
			-- this will show the currently running device if an application was started with a specific
			-- device
			device = true,
		},
	},
	flutter_path = "/usr/bin/flutter",
	widget_guides = {
		enabled = true,
	},
	closing_tags = {
		highlight = "Comment", -- highlight for the closing tag
		-- prefix = ">", -- character to use for close tag e.g. > Widget
		prefix = "// ", -- character to use for close tag
		enabled = true, -- set to false to disable
	},
	lsp = {
		color = { -- show the derived colours for dart variables
			enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
			background = true, -- highlight the background
			-- foreground = true, -- highlight the foreground
			virtual_text = true, -- show the highlight using virtual text
			virtual_text_str = "■", -- the virtual text character to highlight
		},
		on_attach = on_attach,
		-- capabilities = require("plugins.configs.lspconfig").capabilities,
	},
})
