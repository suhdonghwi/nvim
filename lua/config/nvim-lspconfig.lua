local wk = require('which-key')
local lspconfig = require('lspconfig')
local null_ls = require('null-ls')

wk.register({
  ['<leader>'] = { ':lua vim.lsp.buf.hover()<CR>', 'Hover' },
  l = {
    name = 'LSP', -- optional group name
    f = { ':lua vim.lsp.buf.format{ async = true }<CR>', 'Format Buffer' },
    d = { ':lua vim.diagnostic.open_float()<CR>', 'Show Diagnostics' },
    j = { ':lua vim.lsp.buf.definition()<CR>', 'Jump to Definition' },
    a = { ':lua vim.lsp.buf.code_action()<CR>', 'Code Action' },
    r = { ':lua vim.lsp.buf.rename()<CR>', 'Rename' },
  },
}, { prefix = '<leader>' })

vim.diagnostic.config({
  virtual_text = {
    prefix = '■ ', -- Could be '●', '▎', 'x'
  }
})

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'single'
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- Python
local function get_python_path(workspace)
  local util = lspconfig.util

  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return util.path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv in workspace directory.
  local match = vim.fn.glob(util.path.join(workspace, 'poetry.lock'))
  if match ~= '' then
    local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
    return util.path.join(venv, 'bin', 'python')
  end

  -- Fallback to system Python.
  -- return exepath('python3') or exepath('python') or 'python'
  return 'python'
end

lspconfig.pyright.setup {
  settings = {
    python = {
      pythonPath = 'll',
      analysis = {
        typeCheckingMode = 'strict',
      }
    }
  },
  before_init = function(_, config)
    config.settings.python.pythonPath = get_python_path(config.root_dir)
  end
}

-- Lua
local lua_runtime_path = vim.split(package.path, ';')
table.insert(lua_runtime_path, 'lua/init.lua')

lspconfig.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = lua_runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
      format = {
        enable = true,
        defaultConfig = {
          quote_style = 'single'
        }
      },
    },
  },
}

-- Rust
lspconfig.rust_analyzer.setup {}

-- Typescript
lspconfig.tsserver.setup {
  on_attach = function(client)
    client.server_capabilities.document_formatting = false
    -- client.resolved_capabilities.document_formatting = false
  end,
}

-- ESLint & Prettier
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.formatting.prettier
  }
})

-- HTML
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.html.setup {
  capabilities = capabilities,
  init_options = {
    provideFormatter = false
  }
}
