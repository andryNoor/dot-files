local MiniMap = require("mini.map")

-- Generate encode symbol
-- local shade = MiniMap.gen_encode_symbols.shade('2x1')
-- local dot = MiniMap.gen_encode_symbols.dot('3x2')
local dot = MiniMap.gen_encode_symbols.dot('4x2')

-- integrations (highlights)
local search_integration = MiniMap.gen_integration.builtin_search({
  search = 'Search',
})

local diagnostic_integration = MiniMap.gen_integration.diagnostic({
  error = 'DiagnosticFloatingError',
  warn = 'DiagnosticFloatingWarn',
  info = 'DiagnosticFloatingInfo',
  hint = 'DiagnosticFloatingHint',
})

MiniMap.setup({
	-- Highlight integrations (none by default)
	-- integrations = nil,
	integrations = {
    search_integration,
    diagnostic_integration,
  },

	-- Symbols used to display data
	symbols = {
		-- Encode symbols. See `:h MiniMap.config` for specification and
		-- `:h MiniMap.gen_encode_symbols` for pre-built ones.
		-- Default: solid blocks with 3x2 resolution.
		encode = dot,

		-- Scrollbar parts for view and line. Use empty string to disable any.
		scroll_line = "█",
		scroll_view = "┃",
	},

	-- Window options
	window = {
		-- Whether window is focusable in normal way (with `wincmd` or mouse)
		focusable = false,

		-- Side to stick ('left' or 'right')
		side = "right",

		-- Whether to show count of multiple integration highlights
		show_integration_count = true,

		-- Total width
		width = 10,

		-- Value of 'winblend' option
		winblend = 25,
	},
})
