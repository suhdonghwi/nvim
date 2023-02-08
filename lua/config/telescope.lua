local wk = require('which-key')

wk.register({
  t = {
    name = 'Telescope',
    f = { ':Telescope find_files<CR>', 'Find File' },
    g = { ':Telescope live_grep<CR>', 'Live Grep' },
    d = { ':Telescope diagnostics<CR>', 'Diagnostics' },
    b = { ':Telescope buffers<CR>', 'Buffers' },
  },
}, { prefix = '<leader>' })
