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
        "TSConstBuiltin",
        "TSConstMacro",
        "TSException",
        "TSKeyword",
        "TSKeywordFunction",
        "TSKeywordReturn",
        "TSFuncMacro",
        "TSKeywordOperator",
        "TSNamespace",
        "TSNone",
        "TSStringRegex",
        "TSStringEscape",
        "TSSymbol",
        "TSTagDelimiter",
        "TSTypeBuiltin",
        "TSVariableBuiltin",
        "Include",
        "TSInclude",
        "Conditional",
        "TSConditional",
        "Keyword",
        "Repeat",
        "Statement",
        "Boolean",
      },
      italic = {
        "TSFunction",
        "TSFuncBuiltin",
        -- 'TSConstructor',
        "TSMethod",
        "TSParameter",
        "TSParameterReference",
        "TSEmphasis",
        "SpecialChar",
        -- 'Operator',
      },
      bold = {
        "TSAttribute",
        "TSProperty",
        "TSTagAttribute",
        "luaTSField",
        "TSFieldKey",
        "TSPunctBracket",
        "TSPunctDelimiter",
        "TSPunctSpecial",
      },
    },
  },
}

return M
