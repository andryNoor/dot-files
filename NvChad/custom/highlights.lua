local M = {
  overriden_hlgroups = {
    AlphaHeader = {
      fg = "blue",
    },

    CursorLine = {
      bg = "black2",
    },
  },

  overriden_hlgui = {
    HiLSPgui = {
      "LspReferenceText",
      "LspReferenceRead",
      "LspReferenceWrite",
      "DiagnosticHint",
      "DiagnosticError",
      "DiagnosticWarn",
      "DiagnosticInformation",
      "LspSignatureActiveParameter",
      "RenamerTitle",
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
