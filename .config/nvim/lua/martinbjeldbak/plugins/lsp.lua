return {
  -- snippet engine
  {
    "L3MON4D3/LuaSnip", -- snippet engine
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function(_, opts)
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neodev.nvim",
        opts = {
          experimental = { pathStrict = true },
          library = {
            plugins = { "nvim-dap-ui"},
            types = true
          }
        }
      },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim", -- mason extension for lspconfig
      "hrsh7th/nvim-cmp",                 -- autocomplete engine
      "hrsh7th/cmp-buffer",               -- nvim-cmp source for buffer words
      "hrsh7th/cmp-path",                 -- nvim-cmp source for filesystem paths.
      "hrsh7th/cmp-nvim-lsp",             -- show data sent by the language server.
      "hrsh7th/cmp-nvim-lsp-signature-help", -- display function signatures with current parameter emphasized
      "saadparwaiz1/cmp_luasnip",         -- luasnip completion source for nvim-cmp
      "LuaSnip",                          -- snippet engine
      "b0o/schemastore.nvim",
    },
    ---@class PluginLspOpts
    opts = {
      diagnostics = {
        virtual_text = true,
      },
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      -- Heavily inspired by https://github.com/VonHeikemen/nvim-starter/blob/03-lsp/init.lua
      require("mason").setup({
        ui = { border = "rounded" },
      })
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local mlsp = require("mason-lspconfig")
      local select_opts = { behavior = cmp.SelectBehavior.Select }

      -- diagnostics
      vim.diagnostic.config(opts.diagnostics)

      mlsp.setup({
        ensure_installed = {
          "cssls",
          "dockerls",
          "docker_compose_language_service",
          "eslint",
          "tsserver",
          "lua_ls",
          "html",
          "bashls",
          "yamlls",
        },
      })

      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set("n", "vd", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wl", '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({async = true}) end, opts)
          vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
          vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
          vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
        end,
      })

      cmp.setup({
        experimental = {
          ghost_text = true, -- :h cmp-config.experimental.ghost_text
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = {
          { name = "path" },                                                      -- gives completions based on the filesystem.
          { name = "nvim_lsp",               priority = 100 },                    -- suggestions based on language server
          { name = "nvim_lsp_signature_help" },
          -- { name = "buffer",                 keyword_length = 5, max_item_count = 15, priority = 50 }, -- provides suggestions based on the current file
          { name = "luasnip",                keyword_length = 2, priority = 3 },  -- it shows snippets loaded by luasnip in the suggestions
        },
        formatting = {
          fields = { "menu", "abbr", "kind" },
          format = function(entry, item)
            local menu_icon = {
              nvim_lsp = "λ",
              luasnip = "⋗",
              buffer = "Ω",
              path = "🖫",
            }
            item.menu = menu_icon[entry.source.name]
            return item
          end,
        },
        -- See :help cmp-mapping
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping(
            cmp.mapping.complete({
              config = { reason = cmp.ContextReason.Auto },
            }),
            { "i", "c" }
          ),
          ["<Up>"] = cmp.mapping.select_prev_item(select_opts),
          ["<Down>"] = cmp.mapping.select_next_item(select_opts),

          ["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
          ["<C-n>"] = cmp.mapping.select_next_item(select_opts),

          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),

          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),

          ["<C-f>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-b>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            local col = vim.fn.col(".") - 1

            if cmp.visible() then
              cmp.select_next_item(select_opts)
            elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
              fallback()
            else
              cmp.complete()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item(select_opts)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
      })

      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lspconfig = require("lspconfig")

      -- See https://github.com/williamboman/mason-lspconfig.nvim#automatic-server-setup-advanced-feature
      mlsp.setup_handlers({
        function (server_name) -- default handler
          require("lspconfig")[server_name].setup({
            capabilities = lsp_capabilities,
          })
        end,
        -- Override specific server settings
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = lsp_capabilities,
            settings = {
              Lua = {
                runtime = {
                  -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                  version = "LuaJIT",
                },
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { "vim" },
                },
                workspace = {
                  -- Make the server aware of Neovim runtime files
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false, -- https://github.com/folke/neodev.nvim/issues/88
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                  enable = false,
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
        end,
        ["gopls"] = function()
          require("go").setup() -- https://github.com/ray-x/go.nvim/issues/112#issuecomment-1116715000
          local gocfg = require("go.lsp").config() -- config() return the go.nvim gopls setup
          gocfg["capabilities"] = lsp_capabilities
          gocfg["dap_debug"] = true
          gocfg["dap_debug_gui"] = true
          lspconfig.gopls.setup(gocfg)
        end,
        ["tsserver"] = function()
          lspconfig.tsserver.setup({
            capabilities = lsp_capabilities,
            settings = {
              completions = {
                completeFunctionCalls = true,
              },
            },
          })
        end,
        ["jsonls"] = function()
          lspconfig.jsonls.setup({
            capabilities = lsp_capabilities,
            settings = {
              json = {
                schemas = require("schemastore").json.schemas(),
                validate = { enable = true },
              },
            },
            filetypes = {
              "json",
              "jsonc",
              "json5",
            },
          })
        end,
        ["yamlls"] = function()
          lspconfig.yamlls.setup({
            capabilities = lsp_capabilities,
            settings = {
              yaml = {
                schemaStore = {
                  enable = false,
                  -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                  url = "",
                },
                schemas = require("schemastore").yaml.schemas(),
              },
            },
          })
        end,
        ["lemminx"] = function()
          lspconfig.lemminx.setup({
            capabilities = lsp_capabilities,
            cmd = {
              "lemminx",
              "-Djavax.net.ssl.trustStore=/Library/Java/JavaVirtualMachines/temurin-11.jdk/Contents/Home/lib/security/cacerts",
            },
          })
        end,
        ["pylsp"] = function()
          lspconfig.pylsp.setup({
            settings = {
              pylsp = {
                plugins = {
                  pylint = {
                    enabled = false
                  }
                }
              }
            }
          })
        end,
      })
    end,
  },

  -- formatters
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = {
  --     "mason.nvim",
  --     "nvim-lua/plenary.nvim",
  --   },
  --   opts = function()
  --     local null_ls = require("null-ls")
  --     local gotest_codeaction = require("go.null_ls").gotest_action()
  --     local golangci_lint = require("go.null_ls").golangci_lint()

  --     local sources = {
  --       null_ls.builtins.code_actions.shellcheck,
  --       null_ls.builtins.code_actions.xo,
  --       -- null_ls.builtins.code_actions.gitsigns, -- integration with gitsigns.nvim -- uncomment as never use

  --       -- null_ls.builtins.completion.luasnip,
  --       -- null_ls.builtins.completion.spell,

  --       null_ls.builtins.diagnostics.actionlint,
  --       null_ls.builtins.diagnostics.checkmake,
  --       null_ls.builtins.diagnostics.chktex,
  --       null_ls.builtins.diagnostics.codespell,
  --       null_ls.builtins.diagnostics.dotenv_linter,
  --       null_ls.builtins.diagnostics.erb_lint,
  --       -- using xo instead, which is wrapper on top of eslint
  --       -- null_ls.builtins.diagnostics.eslint.with({
  --       --   prefer_local = "node_modules/.bin",
  --       -- }),
  --       null_ls.builtins.diagnostics.hadolint,
  --       null_ls.builtins.diagnostics.jshint,
  --       null_ls.builtins.diagnostics.jsonlint,
  --       null_ls.builtins.diagnostics.luacheck,
  --       null_ls.builtins.diagnostics.markdownlint.with({
  --         extra_args = {
  --           "--disable",
  --           "MD013", -- line length
  --         },
  --       }),
  --       null_ls.builtins.diagnostics.proselint,
  --       null_ls.builtins.diagnostics.buf,
  --       null_ls.builtins.diagnostics.protoc_gen_lint,
  --       null_ls.builtins.diagnostics.protolint,
  --       null_ls.builtins.diagnostics.reek,
  --       null_ls.builtins.diagnostics.revive,
  --       null_ls.builtins.formatting.golines.with({
  --         extra_args = {
  --           "--max-len=180",
  --           "--base-formatter=gofumpt",
  --         },
  --       }),
  --       null_ls.builtins.diagnostics.rubocop,
  --       -- null_ls.builtins.diagnostics.ruff, -- python
  --       null_ls.builtins.diagnostics.shellcheck,
  --       null_ls.builtins.diagnostics.sqlfluff,
  --       null_ls.builtins.diagnostics.standardrb,
  --       null_ls.builtins.diagnostics.staticcheck, -- golang
  --       null_ls.builtins.diagnostics.stylelint,
  --       -- null_ls.builtins.diagnostics.terraform_validate, -- causes module not installed error, will try and rely on lsp
  --       -- null_ls.builtins.diagnostics.textlint, -- causes weird bug at top of markdown files
  --       null_ls.builtins.diagnostics.tfsec,
  --       null_ls.builtins.diagnostics.todo_comments,
  --       null_ls.builtins.diagnostics.trail_space,
  --       null_ls.builtins.diagnostics.tsc.with({
  --         prefer_local = "node_modules/.bin",
  --       }),
  --       -- null_ls.builtins.diagnostics.write_good, -- too pedantic!
  --       null_ls.builtins.diagnostics.xo.with({
  --         prefer_local = "node_modules/.bin",
  --       }),
  --       null_ls.builtins.diagnostics.yamllint,
  --       null_ls.builtins.diagnostics.zsh,

  --       null_ls.builtins.formatting.stylua,

  --       -- from go.nvim https://github.com/ray-x/go.nvim#integrate-null-ls
  --       golangci_lint,
  --       gotest_codeaction,
  --     }

  --     return {
  --       sources = sources,
  --       debounce = 1000,
  --       default_timeout = 5000,
  --     }
  --   end,
  -- },

  -- cmdline tools and lsp servers
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "black",
      },
    },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
}
