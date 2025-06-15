return {
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      'mason.nvim',
      { 'mason-org/mason-lspconfig.nvim', config = function() end },
    },
    opts = function()
      ---@class PluginLspOpts
      local ret = {
        -- options for vim.diagnostic.config()
        ---@type vim.diagnostic.Opts
        diagnostics = {
          underline = true,
          update_in_insert = false,
          virtual_text = {
            spacing = 4,
            source = 'if_many',
            prefix = '●',
            -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
            -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
            -- prefix = "icons",
          },
          severity_sort = true,
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = '󰅚 ',
              [vim.diagnostic.severity.WARN] = '󰀪 ',
              [vim.diagnostic.severity.INFO] = '󰋽 ',
              [vim.diagnostic.severity.HINT] = '󰌶 ',
            },
          },
        },
        -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
        -- Be aware that you also will need to properly configure your LSP server to
        -- provide the inlay hints.
        inlay_hints = {
          enabled = true,
          exclude = { 'vue' }, -- filetypes for which you don't want to enable inlay hints
        },
        -- add any global capabilities here
        capabilities = {
          workspace = {
            fileOperations = {
              didRename = true,
              willRename = true,
            },
          },
        },
        -- options for vim.lsp.buf.format
        -- `bufnr` and `filter` is handled by the LazyVim formatter,
        -- but can be also overridden when specified
        format = {
          formatting_options = nil,
          timeout_ms = nil,
        },
        -- LSP Server Settings
        ---@type lspconfig.options
        servers = {
          lua_ls = {
            -- mason = false, -- set to false if you don't want this server to be installed with mason
            -- Use this to add any additional keymaps
            -- for specific lsp servers
            -- ---@type LazyKeysSpec[]
            -- keys = {},
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = 'Replace',
                },
                doc = {
                  privateName = { '^_' },
                },
                hint = {
                  enable = true,
                  setType = false,
                  paramType = true,
                  paramName = 'Disable',
                  semicolon = 'Disable',
                  arrayIndex = 'Disable',
                },
              },
            },
          },
        },
        -- you can do any additional lsp server setup here
        -- return true if you don't want this server to be setup with lspconfig
        ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
        setup = {
          -- example to setup with typescript.nvim
          -- tsserver = function(_, opts)
          --   require("typescript").setup({ server = opts })
          --   return true
          -- end,
          -- Specify * to use this function as a fallback for any server
          -- ["*"] = function(server, opts) end,
        },
      }
      return ret
    end,
    config = function(_, opts)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
          end
        end,
      })

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local blink = require 'blink.cmp'
      local capabilities = vim.tbl_deep_extend('force', {}, vim.lsp.protocol.make_client_capabilities(), blink.get_lsp_capabilities(), opts.capabilities or {})

      local function setup(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})
        if server_opts.enabled == false then
          return
        end

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup['*'] then
          if opts.setup['*'](server, server_opts) then
            return
          end
        end
        require('lspconfig')[server].setup(server_opts)
      end

      local mlsp = require 'mason-lspconfig'
      local all_mslp_servers = vim.tbl_keys(require('mason-lspconfig.mappings.server').lspconfig_to_package)

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      mlsp.setup {
        ensure_installed = vim.tbl_deep_extend('force', ensure_installed, {}),
        handlers = { setup },
      }

      --
      -- --  Add any additional override configuration in the following tables. Available keys are:
      -- --  - cmd (table): Override the default command used to start the server
      -- --  - filetypes (table): Override the default list of associated filetypes for the server
      -- --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      -- --  - settings (table): Override the default settings passed when initializing the server.
      -- TODO: add below files to lang
      -- --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      -- local servers = {
      -- 	gopls = {},
      -- 	lemminx = {},
      -- 	terraformls = {},
      -- 	tflint = {},
      -- 	html = {},
      -- 	jsonnet_ls = {},
      -- 	taplo = {},
      -- 	bashls = {},
      -- 	astro = {},
      -- 	marksman = {},
      -- 	sqlls = {},
      -- 	ruff = {},
      -- 	cssls = {},
      -- 	ts_ls = {},
      -- 	lua_ls = {
      -- 		settings = {
      -- 			Lua = {
      -- 				completion = {
      -- 					callSnippet = "Replace",
      -- 				},
      -- 				-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- 				-- diagnostics = { disable = { 'missing-fields' } },
      -- 			},
      -- 		},
      -- 	},
      -- }
    end,
    keys = {
      {
        '<leader>cl',
        function()
          Snacks.picker.lsp_config()
        end,
        desc = 'Lsp Info',
      },
      { 'gd', vim.lsp.buf.definition, desc = 'Goto Definition' },
      { 'gr', vim.lsp.buf.references, desc = 'References', nowait = true },
      { 'gI', vim.lsp.buf.implementation, desc = 'Goto Implementation' },
      { 'gy', vim.lsp.buf.type_definition, desc = 'Goto T[y]pe Definition' },
      { 'gD', vim.lsp.buf.declaration, desc = 'Goto Declaration' },
      {
        'K',
        function()
          return vim.lsp.buf.hover()
        end,
        desc = 'Hover',
      },
      {
        'gK',
        function()
          return vim.lsp.buf.signature_help()
        end,
        desc = 'Signature Help',
      },
      {
        '<c-k>',
        function()
          return vim.lsp.buf.signature_help()
        end,
        mode = 'i',
        desc = 'Signature Help',
      },
      { '<leader>ca', vim.lsp.buf.code_action, desc = 'Code Action', mode = { 'n', 'v' } },
      { '<leader>cc', vim.lsp.codelens.run, desc = 'Run Codelens', mode = { 'n', 'v' } },
      {
        '<leader>cC',
        vim.lsp.codelens.refresh,
        desc = 'Refresh & Display Codelens',
        mode = { 'n' },
      },
      {
        '<leader>cR',
        function()
          Snacks.rename.rename_file()
        end,
        desc = 'Rename File',
        mode = { 'n' },
      },
      { '<leader>cr', vim.lsp.buf.rename, desc = 'Rename' },
      -- { '<leader>cA', LazyVim.lsp.action.source, desc = 'Source Action', has = 'codeAction' },
      {
        ']]',
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = 'Next Reference',
      },
      {
        '[[',
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = 'Prev Reference',
      },
      {
        '<a-n>',
        function()
          Snacks.words.jump(vim.v.count1, true)
        end,
        desc = 'Next Reference',
      },
      {
        '<a-p>',
        function()
          Snacks.words.jump(-vim.v.count1, true)
        end,
        desc = 'Prev Reference',
      },
    },
  },

  {
    'mason-org/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>cm', '<cmd>Mason<cr>', desc = 'Mason' } },
    opts_extend = { 'ensure_installed' },
    opts = {
      ensure_installed = {
        'stylua',
        'shfmt',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require 'mason-registry'
      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },

  -- pin to v1 for now
  { 'mason-org/mason.nvim', version = '^1.0.0' },
  { 'mason-org/mason-lspconfig.nvim', version = '^1.0.0' },
}
