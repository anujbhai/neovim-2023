-- Setup language servers.
-- local lspconfig = require('lspconfig')
-- lspconfig.pyright.setup {}
-- lspconfig.tsserver.setup {}
-- lspconfig.rust_analyzer.setup {
-- Server-specific settings. See `:help lspconfig-setup`
-- settings = {
-- ['rust-analyzer'] = {},
-- },
-- }


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
local on_attach    = function(_, bufnr)
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- local opts = { buffer = bufnr, noremap = true, silent = true }
  -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  -- vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', opts)
  -- vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, opts)
  -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  -- vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  -- vim.keymap.set('n', '<leader>d', '<cmd>Telescope lsp_document_symbols<cr>', opts)

  -- format on save
  vim.api.nvim_create_autocmd('BufWritePre', {
    -- group = vim.api.nvim_create_augroup('LspFormatting', { clear = true }),
    buffer = bufnr,
    callback = function()
      -- if isTsserver == true then
      -- require('typescript').actions.removeUnused({ sync = true })
      -- end
      vim.lsp.buf.format()
    end
  })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lsp_config   = {
  capabilities = capabilities,
  group = vim.api.nvim_create_augroup('LspFormatting', { clear = true }),
  on_attach = function(_, bufnr)
    on_attach(_, bufnr)
  end
}

require('mason-lspconfig').setup_handlers({
  function(server_name)
    require('lspconfig')[server_name].setup(lsp_config)
  end,
  lua_ls = function()
    require('lspconfig').lua_ls.setup(vim.tbl_extend('force', lsp_config, {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' }
          }
        }
      }
    }))
  end,
  tsserver = function()
    require('typescript').setup({
      server = vim.tbl_extend('force', lsp_config, {
        on_attach = function(_, bufnr)
          on_attach(_, bufnr)
        end,
        init_options = {
          preferences = {
            importModuleSpecifierPreference = 'project=relative',
            jsxAttributeCompletionStyle = 'none'
          }
        }
      })
    })
  end
})

vim.keymap.set('n', '<leader>o', '<cmd>TypescriptOrganizeImports<cr>')
vim.keymap.set('n', '<leader>a', '<cmd>TypescriptAddMissingImports<cr>')
