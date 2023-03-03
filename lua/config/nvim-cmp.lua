local cmp = require('cmp')
local lspkind = require('lspkind')

local border_opts =
{ border = 'single', winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None' }

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Down>'] = cmp.mapping.select_next_item(),
        ['<Up>'] = cmp.mapping.select_prev_item(),
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
    })
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  }),
  window = {
    completion = cmp.config.window.bordered(border_opts),
    documentation = cmp.config.window.bordered(border_opts),
  }
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)
