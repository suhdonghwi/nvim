local wk = require('which-key')

require('nvim-tree').setup()

wk.register({
  n = { ':NvimTreeToggle<CR>', 'Toggle NvimTree' }
}, { prefix = '<leader>' })
