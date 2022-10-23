local present, null_ls = pcall(require, "null-ls")

if not present then
   return
end

local b = null_ls.builtins

local sources = {
  -- cpp
  b.diagnostics.cppcheck,
  b.diagnostics.clang_check,
  b.formatting.astyle,
  b.formatting.clang_format,
  b.formatting.uncrustify,
  -- cmake
  b.formatting.cmake_format,
  b.diagnostics.cmake_lint,
  -- shell
  b.formatting.shellharden,
  b.formatting.shfmt,
  b.code_actions.shellcheck.with { diagnostics_format = "#{m} [#{c}]",},
  -- python
  b.diagnostics.flake8,
  b.diagnostics.pycodestyle,
  b.diagnostics.pydocstyle,
  b.diagnostics.mypy,
  -- lua
  b.diagnostics.luacheck,
  -- text / md
  b.diagnostics.alex,
  b.diagnostics.markdownlint,
  b.diagnostics.misspell,
  b.diagnostics.proselint,
  b.diagnostics.write_good,
  -- other
  b.diagnostics.qmllint,
  -- test
  b.hover.dictionary,
  b.hover.printenv,
}

null_ls.setup {
   debug = true,
   sources = sources,
}
