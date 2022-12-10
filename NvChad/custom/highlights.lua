local M = {
	overriden_hlgroups = {
		AlphaHeader = {
			fg = "blue",
		},

		CursorLine = {
			bg = "line",
		},
	},

	overriden_hlgui = {
		HiLSPgui = {
			-- all highlighted as italic
			"LspReferenceText",
			"LspReferenceRead",
			"LspReferenceWrite",
			"LspSignatureActiveParameter",
			"RenamerTitle",
			"DiagnosticHint",
			"DiagnosticError",
			"DiagnosticWarn",
			"DiagnosticInformation",
			"DiagnosticInfo", -- flutter-tools.nvim
		},
		HiTSgui = {
			italic_bold = {
				"TSAnnotation",
        "@annotation",
				"TSConstBuiltin",
        "@constant.builtin",
				"TSConstMacro",
        "@constant.macro",
				"TSException",
        "@exception",
				"TSKeyword",
				"TSKeywordFunction",
				"@keyword.function",
				"TSKeywordReturn",
				"@keyword.return",
				"TSFuncMacro",
        "@function.macro",
				"TSKeywordOperator",
        "@keyword.operator",
				"TSNamespace",
        "@namespace",
				"TSNone",
        "@none",
				"TSStringRegex",
        "@string.regex",
				"TSStringEscape",
        "@string.escape",
				"TSSymbol",
        "@symbol",
				"TSTagDelimiter",
        "@tag.delimiter",
				"TSTypeBuiltin",
        "@type.builtin",
				"TSVariableBuiltin",
        "@variable.builtin",
				"Include",
				"TSInclude",
        "@include",
				"Conditional",
				"TSConditional",
        "@conditional",
				"Keyword",
				"@keyword",
				"Repeat",
				"Statement",
				"Boolean",
			},
			italic = {
				"TSFunction",
        "@function",
				"TSFuncBuiltin",
        "@function.builtin",
				-- "TSConstructor",
        -- "@constructor",
				"TSMethod",
        "@method",
				"TSParameter",
        "@parameter",
				"TSParameterReference",
        "@reference",
				"TSEmphasis",
        "@text.emphasis",
				"SpecialChar",
        "@character",
				-- "Operator",
        -- "@keyword.operator",
			},
			bold = {
				"TSAttribute",
        "@attribute",
				"TSProperty",
        "@property",
				"TSTagAttribute",
        "@tag.attribute",
				"luaTSField",
        "@field",
				"TSFieldKey",
				"TSPunctBracket",
        "@panctuation.bracket",
				"TSPunctDelimiter",
        "@panctuation.delimiter",
				"TSPunctSpecial",
        "@panctuation.special",
			},
		},
	},
}

return M
