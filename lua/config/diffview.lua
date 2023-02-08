local wk = require('which-key')

wk.register({
  d = {
    name = 'Diffview',
    o = { ':DiffviewOpen<CR>', 'Open diff view' },
    c = { ':DiffviewClose<CR>', 'Close diff view' },
  },
}, { prefix = '<leader>' })
