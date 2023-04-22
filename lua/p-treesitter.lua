require 'nvim-treesitter.install'.compilers = { "clang" }
require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "javascript",
    "typescript",
    "c",
    "tsx",
    "lua",
    "rust",
    "json",
    "graphql",
    "regex",
    "vim",
    "vimdoc",
    "query"
  },

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    disable = {},
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = {}
  }
}
