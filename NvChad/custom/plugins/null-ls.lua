local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt,
  -- b.formatting.prettierd.with { filetypes = { "html", "markdown", "css", "json", "jsonc" } },

  -- Lua
  b.formatting.stylua,

  -- Shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

  -- Python
  b.formatting.autopep8,

  -- Dart
  b.formatting.dart_format,

  -- Kotlin
  b.formatting.ktlint,

  -- Elixir
  b.formatting.mix,

  -- C# dotnet
  b.formatting.csharpier,

  -- cpp
  -- b.formatting.clang_format,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
