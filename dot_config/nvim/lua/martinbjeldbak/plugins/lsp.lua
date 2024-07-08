return {
	-- snippet engine
	{
		"L3MON4D3/LuaSnip", -- snippet engine
		version = "1.*",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},

	{ -- mason extension for lspconfig
		"williamboman/mason-lspconfig.nvim",
		---@class PluginLspOpts
		opts = {
			ensure_installed = {
				"basedpyright",
				"lemminx",
				"terraformls",
				"tflint",
				"docker_compose_language_service",
				"dockerls",
				"html",
				"jsonls",
				"jsonnet_ls",
				"yamlls",
				"lua_ls",
				"taplo",
				"bashls",
				"astro",
				"gopls",
				"marksman",
				"sqlls",
				"ruff_lsp",
				"cssls",
				"bufls",
			},
		},
	},

	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp", -- autocomplete engine
			"hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words
			"hrsh7th/cmp-path", -- nvim-cmp source for filesystem paths.
			"hrsh7th/cmp-nvim-lsp", -- show data sent by the language server.
			"hrsh7th/cmp-nvim-lsp-signature-help", -- display function signatures with current parameter emphasized
			"saadparwaiz1/cmp_luasnip", -- luasnip completion source for nvim-cmp
			"LuaSnip", -- snippet engine
			"b0o/schemastore.nvim",
		},
		---@class PluginLspOpts
		opts = function()
			return {
				diagnostics = {
					virtual_text = true,
				},
				-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
				-- Be aware that you also will need to properly configure your LSP server to
				-- provide the inlay hints.
				inlay_hints = {
					enabled = true,
					exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
				},
				-- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
				-- Be aware that you also will need to properly configure your LSP server to
				-- provide the code lenses.
				codelens = {
					enabled = true,
				},
				-- Enable lsp cursor word highlighting
				document_highlight = {
					enabled = true,
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
			}
		end,
		---@param opts PluginLspOpts
		config = function(_, opts)
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local mlsp = require("mason-lspconfig")
			local select_opts = { behavior = cmp.SelectBehavior.Select }

			-- diagnostics
			vim.diagnostic.config(opts.diagnostics)

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
					vim.keymap.set(
						"n",
						"<leader>wl",
						"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
						opts
					)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
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
					{ name = "path" }, -- gives completions based on the filesystem.
					{ name = "nvim_lsp", priority = 100 }, -- suggestions based on language server
					{ name = "nvim_lsp_signature_help" },
					-- { name = "buffer",                 keyword_length = 5, max_item_count = 15, priority = 50 }, -- provides suggestions based on the current file
					{ name = "luasnip", keyword_length = 2, priority = 3 }, -- it shows snippets loaded by luasnip in the suggestions
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
					["<Up>"] = cmp.mapping.select_prev_item(select_opts),
					["<Down>"] = cmp.mapping.select_next_item(select_opts),

					["<C-p>"] = cmp.mapping.select_prev_item(select_opts),
					["<C-n>"] = cmp.mapping.select_next_item(select_opts),

					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-d>"] = cmp.mapping.scroll_docs(4),

					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					-- ["<CR>"] = cmp.mapping.confirm({ select = false }),
					--

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

					-- ["<Tab>"] = cmp.mapping(function(fallback)
					--   local col = vim.fn.col(".") - 1

					--   if cmp.visible() then
					--     cmp.select_next_item(select_opts)
					--   elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
					--     fallback()
					--   else
					--     cmp.complete()
					--   end
					-- end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item(select_opts)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
			})

			--Enable (broadcasting) snippet capability for completion
			local lsp_capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
			lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true
			local lspconfig = require("lspconfig")
			lspconfig.hyprls.setup({
				filetypes = { "hyprlang" }, -- override this until TODO merged
			})

			-- See https://github.com/williamboman/mason-lspconfig.nvim#automatic-server-setup-advanced-feature
			mlsp.setup_handlers({
				function(server_name) -- default handler
					require("lspconfig")[server_name].setup({
						capabilities = lsp_capabilities,
					})
				end,
				-- Override specific server settings
				["cssls"] = function()
					lspconfig.cssls.setup({
						capabilities = lsp_capabilities,
					})
				end,
				["html"] = function()
					lspconfig.html.setup({
						capabilities = lsp_capabilities,
					})
				end,
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
					local gocfg = require("go.lsp").config()
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
			})
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},

	-- formatters
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_fix", "ruff_format" },
				javascript = { { "prettierd", "prettier" } },
				sql = { "sqlfmt", "sqlfluff", "pg_format" },
				tf = { "terraform_fmt" },
				ruby = { "rubyfmt", "rubocop", "standardrb" },
				proto = { "buf" },
				go = { "gofumpt", "goimports" },
				jsonnet = { "jsonnetfmt" },
				json = { "jq" },
				markdown = { "markdownlint-cli2" },
				sh = { "shellcheck", "shfmt" },
				css = { "stylelint" },
				yaml = { "yq" },
			},
			-- Set up format-on-save
			-- format_on_save = { timeout_ms = 500, lsp_fallback = true },
		},
		init = function()
			-- If you want the formatexpr, here is the place to set it
			vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
		end,
	},

	-- linter
	{
		"mfussenegger/nvim-lint",
		events = { "BufWritePost", "BufReadPost", "InsertLeave" },
		opts = {
			linters_by_ft = {
				markdown = { "markdownlint" }, -- "vale" is very strict
				make = { "checkmake" },
				eruby = { "erb_lint" },
				ruby = { "ruby", "rubocop" },
				dockerfile = { "hadolint" },
				proto = { "buf_lint" },
				sh = { "shellcheck", "zsh" },
				lua = { "selene" },
				python = { "ruff" },
				sql = { "sqlfluff" },
				css = { "stylelint" },
				tf = { "tfsec" },
				yaml = { "yamllint" },
				go = { "revive", "golangcilint" },
			},
		},
		config = function(_, opts)
			local lint = require("lint")
			lint.linters_by_ft = opts.linters_by_ft
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "InsertLeave" }, {
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},

	-- cmdline tools and lsp servers
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = {
			ui = { border = "rounded" },
		},
		config = function(_, opts)
			require("mason").setup(opts)
		end,
	},
}
