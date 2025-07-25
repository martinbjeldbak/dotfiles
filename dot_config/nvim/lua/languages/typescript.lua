return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      -- make sure mason installs the server
      servers = {
        --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
        --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
        tsserver = {
          enabled = false,
        },
        ts_ls = {
          enabled = false,
        },
        vtsls = {
          -- explicitly add default filetypes, so that we can extend
          -- them in related extras
          filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                maxInlayHintLength = 30,
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = 'always' },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = 'literals' },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
        },
      },
      setup = {
        --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
        --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
        tsserver = function()
          -- disable tsserver
          return true
        end,
        ts_ls = function()
          -- disable tsserver
          return true
        end,
        -- vtsls = function(_, opts)
        --   LazyVim.lsp.on_attach(function(client, buffer)
        --     client.commands['_typescript.moveToFileRefactoring'] = function(command, ctx)
        --       ---@type string, string, lsp.Range
        --       local action, uri, range = unpack(command.arguments)
        --
        --       local function move(newf)
        --         client.request('workspace/executeCommand', {
        --           command = command.command,
        --           arguments = { action, uri, range, newf },
        --         })
        --       end
        --
        --       local fname = vim.uri_to_fname(uri)
        --       client.request('workspace/executeCommand', {
        --         command = 'typescript.tsserverRequest',
        --         arguments = {
        --           'getMoveToRefactoringFileSuggestions',
        --           {
        --             file = fname,
        --             startLine = range.start.line + 1,
        --             startOffset = range.start.character + 1,
        --             endLine = range['end'].line + 1,
        --             endOffset = range['end'].character + 1,
        --           },
        --         },
        --       }, function(_, result)
        --         ---@type string[]
        --         local files = result.body.files
        --         table.insert(files, 1, 'Enter new path...')
        --         vim.ui.select(files, {
        --           prompt = 'Select move destination:',
        --           format_item = function(f)
        --             return vim.fn.fnamemodify(f, ':~:.')
        --           end,
        --         }, function(f)
        --           if f and f:find '^Enter new path' then
        --             vim.ui.input({
        --               prompt = 'Enter move destination:',
        --               default = vim.fn.fnamemodify(fname, ':h') .. '/',
        --               completion = 'file',
        --             }, function(newf)
        --               return newf and move(newf)
        --             end)
        --           elseif f then
        --             move(f)
        --           end
        --         end)
        --       end)
        --     end
        --   end, 'vtsls')
        --   -- copy typescript settings to javascript
        --   opts.settings.javascript = vim.tbl_deep_extend('force', {}, opts.settings.typescript, opts.settings.javascript or {})
        -- end,
      },
    },
  },

  -- Filetype icons
  {
    'echasnovski/mini.icons',
    opts = {
      file = {
        ['.eslintrc.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
        ['.node-version'] = { glyph = '', hl = 'MiniIconsGreen' },
        ['.prettierrc'] = { glyph = '', hl = 'MiniIconsPurple' },
        ['.yarnrc.yml'] = { glyph = '', hl = 'MiniIconsBlue' },
        ['eslint.config.js'] = { glyph = '󰱺', hl = 'MiniIconsYellow' },
        ['package.json'] = { glyph = '', hl = 'MiniIconsGreen' },
        ['tsconfig.json'] = { glyph = '', hl = 'MiniIconsAzure' },
        ['tsconfig.build.json'] = { glyph = '', hl = 'MiniIconsAzure' },
        ['yarn.lock'] = { glyph = '', hl = 'MiniIconsBlue' },
      },
    },
  },
}
