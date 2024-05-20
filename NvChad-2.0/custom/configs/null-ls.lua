local null_ls = require "null-ls"

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
  b.formatting.prettier.with { filetypes = { "html", "markdown", "css" } }, -- so prettier works only on these filetypes

  -- Lua
  b.formatting.stylua,

  -- cpp family
  b.formatting.clang_format,
  b.formatting.csharpier,

  -- Dart
  b.formatting.dart_format,

  -- Python
  -- b.formatting.autopep8,
  b.formatting.ruff,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
