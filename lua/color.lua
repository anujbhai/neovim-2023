function ColorMyPencils(color)
  vim.g.gruvbox_diagnostic_line_highlight = 1
  vim.o.background = 'dark'

  color = color or 'gruvbox'
  -- color = color or 'onedark'
  vim.cmd.colorscheme(color)

  vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
  vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })

  vim.fn.sign_define({
    {
      name = 'DiagnosticSignError',
      text = '󰀩',
      texthl = 'DiagnosticSignError',
      linehl = 'ErrorLine'
    },
    {
      name = 'DiagnosticSignWarn',
      text = '󰀦',
      texthl = 'DiagnosticSignWarn',
      linehl = 'WarningLine'
    },
    {
      name = 'DiagnosticSignInfo',
      text = '',
      texthl = 'DiagnosticSignInfo',
      linehl = 'InfoLine'
    },
    {
      name = 'DiagnosticSignHint',
      text = '󰸱',
      texthl = 'DiagnosticSignHint',
      linehl = 'HintLine'
    }
  })
end

ColorMyPencils()
