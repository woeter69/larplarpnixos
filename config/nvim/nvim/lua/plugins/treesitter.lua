require'nvim-treesitter.configs'.setup {
  ensure_installed = { "html", "css", "javascript" },  -- languages you want
  highlight = { enable = true },                       -- syntax highlighting
  auto_install = true,                                  -- install missing parsers automatically
}
