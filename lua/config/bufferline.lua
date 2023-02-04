local wk = require('which-key')

require('bufferline').setup {}

wk.register({
  b = {
    name = 'bufferline',
    l = { ':BufferLineCycleNext<CR>', 'Next Buffer' }, -- create a binding with label
    h = { ':BufferLineCyclePrev<CR>', 'Prev Buffer' }, -- additional options for creating the keymap
    p = { ':BufferLinePick<CR>', 'Pick Buffer' }, -- just a label. don't create any mapping
    d = { ':bd<CR>', 'Delete Buffer' }, -- same as above
  },
}, { prefix = '<leader>' })
