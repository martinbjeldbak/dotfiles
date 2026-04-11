vim.g.mapleader = " "

-- Display line number
vim.opt.number = true
-- Display relative to current cursor
vim.opt.relativenumber = true
-- Ignore case when searching
vim.opt.ignorecase = true
-- Automatically switch to case-sensitive if capital leter used
vim.opt.smartcase = true
-- Decrease time in ms of inactivity before calling CursorHold or writing to swap
vim.opt.updatetime = 250

-- yank to system clipboard
vim.opt.clipboard = "unnamedplus"

vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/nvim-lua/plenary.nvim", -- treesitter dependency
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/nvim-tree/nvim-web-devicons", -- fzf-lua icons
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/mfussenegger/nvim-lint", -- linter
	"https://github.com/stevearc/conform.nvim", -- formatter
	"https://github.com/b0o/SchemaStore.nvim",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
	"https://github.com/christoomey/vim-tmux-navigator",
})

vim.cmd.colorscheme("catppuccin-frappe")

-- New UI opt-in
require("vim._core.ui2").enable({})

require("mason").setup()

require("conform").setup({
	formatters_by_ft = {
		astro = { "prettier" },
		nix = { "nixfmt" },
		lua = { "stylua" },
		python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
		-- You can customize some of the format options for the filetype (:help conform.format)
		rust = { "rustfmt", lsp_format = "fallback" },
		-- Conform will run the first available formatter
		javascript = { "prettierd", "prettier", stop_after_first = true },
		json = { "jq" },
		yaml = { "yq" },
		markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
		sh = { "shellcheck", "shfmt" },
		proto = { "buf" },
	},
})

require("lint").linters_by_ft = { -- nvim-lint
	dockerfile = { "hadolint" },
	markdown = { "markdownlint-cli2" },
	make = { "checkmake" },
	zsh = { "zsh" },
	sh = { "shellcheck", "zsh" },
	["yaml.ghaction"] = { "actionlint" },
	["*"] = { "typos" },
	yaml = { "yamllint" },
}

require("blink.cmp").setup({
	fuzzy = {
		implementation = "prefer_rust_with_warning",
	},
})

require("mini.basics").setup({
	options = {
		extra_ui = true,
	},
})

require("mini.clue").setup()

-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require("mini.ai").setup({ n_lines = 500 })

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require("mini.surround").setup()

-- - gc    - Toggle comment
-- - gcc   - Toggle comment on current line
require("mini.comment").setup()

require("mini.align").setup()

require("mini.statusline").setup({ use_icons = true })

vim.lsp.enable("ty") -- Python LSP
vim.lsp.enable("shellcheck")
vim.lsp.config("yamllint", {})
vim.lsp.enable("yamllint")
vim.lsp.config("yamlls", {
	settings = {
		yaml = {
			schemaStore = {
				-- You must disable built-in schemaStore support if you want to use
				-- this plugin and its advanced options like `ignore`.
				enable = false,
				-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
				url = "",
			},
			schemas = require("schemastore").yaml.schemas(),
		},
	},
})
vim.lsp.enable("yamlls")
vim.lsp.config("lua-language-server", {})
vim.lsp.enable("lua-language-server")
vim.lsp.enable("stylua")
vim.lsp.enable("lua_ls")

vim.keymap.set("n", "?", function()
	require("which-key").show({ global = false })
end)

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>,", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", { desc = "Switch Buffer" })
vim.keymap.set("n", "<leader>/", "<cmd>FzfLua live_grep<cr>", { desc = "Grep (Root Dir)" })
vim.keymap.set("n", "<leader>:", "<cmd>FzfLua command_history<cr>", { desc = "Command History" })
vim.keymap.set("n", "<leader><space>", "<cmd>FzfLua files<cr>", { desc = "Find Files (Root Dir)" })
-- find
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", { desc = "Buffers" })
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Find Files (Root Dir)" })
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua git_files<cr>", { desc = "Find Files (git-files)" })
vim.keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", { desc = "Recent" })
-- git
vim.keymap.set("n", "<leader>gc", "<cmd>FzfLua git_commits<CR>", { desc = "Commits" })
vim.keymap.set("n", "<leader>gs", "<cmd>FzfLua git_status<CR>", { desc = "Status" })
vim.keymap.set("n", '<leader>s"', "<cmd>FzfLua registers<cr>", { desc = "Registers" })
vim.keymap.set("n", "<leader>sa", "<cmd>FzfLua autocmds<cr>", { desc = "Auto Commands" })
vim.keymap.set("n", "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", { desc = "Buffer" })
vim.keymap.set("n", "<leader>sc", "<cmd>FzfLua command_history<cr>", { desc = "Command History" })
vim.keymap.set("n", "<leader>sC", "<cmd>FzfLua commands<cr>", { desc = "Commands" })
vim.keymap.set("n", "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", { desc = "Document Diagnostics" })
vim.keymap.set("n", "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", { desc = "Workspace Diagnostics" })
vim.keymap.set("n", "<leader>sg", "<cmd>FzfLua live_grep<cr>", { desc = "Grep (Root Dir)" })
vim.keymap.set("n", "<leader>sh", "<cmd>FzfLua help_tags<cr>", { desc = "Help Pages" })
vim.keymap.set("n", "<leader>sH", "<cmd>FzfLua highlights<cr>", { desc = "Search Highlight Groups" })
vim.keymap.set("n", "<leader>sj", "<cmd>FzfLua jumps<cr>", { desc = "Jumplist" })
vim.keymap.set("n", "<leader>sk", "<cmd>FzfLua keymaps<cr>", { desc = "Key Maps" })
vim.keymap.set("n", "<leader>sl", "<cmd>FzfLua loclist<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>sM", "<cmd>FzfLua man_pages<cr>", { desc = "Man Pages" })
vim.keymap.set("n", "<leader>sm", "<cmd>FzfLua marks<cr>", { desc = "Jump to Mark" })
vim.keymap.set("n", "<leader>sR", "<cmd>FzfLua resume<cr>", { desc = "Resume" })
vim.keymap.set("n", "<leader>sq", "<cmd>FzfLua quickfix<cr>", { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>sw", "<cmd>FzfLua grep_cword<cr>", { desc = "Word (Root Dir)" })
vim.keymap.set("n", "<leader>sW", "<cmd>FzfLua grep_cWORD<cr>", { desc = "Word Under Cursor (Root Dir)" })
vim.keymap.set("v", "<leader>sw", "<cmd>FzfLua grep_visual<cr>", { desc = "Selection (Root Dir)" })
vim.keymap.set("n", "<leader>uC", "<cmd>FzfLua colorschemes<cr>", { desc = "Colorscheme with Preview" })
vim.keymap.set("n", "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "Goto Symbol" })
vim.keymap.set("n", "<leader>ss", "<cmd>FzfLua lsp_live_workspace_symbols<cr>", { desc = "Goto Symbol (Workspace)" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
--      { 'gr', vim.lsp.buf.references, desc = 'References', nowait = true },
--      { 'gI', vim.lsp.buf.implementation, desc = 'Goto Implementation' },
--      { 'gy', vim.lsp.buf.type_definition, desc = 'Goto T[y]pe Definition' },
--      { 'gD', vim.lsp.buf.declaration, desc = 'Goto Declaration' },
--      {
--        'K',
--        function()
--          return vim.lsp.buf.hover()
--        end,
--        desc = 'Hover',
--      },
--      {
--        'gK',
--        function()
--          return vim.lsp.buf.signature_help()
--        end,
--        desc = 'Signature Help',
--      },
--      {
--        '<c-k>',
--        function()
--          return vim.lsp.buf.signature_help()
--        end,
--        mode = 'i',
--        desc = 'Signature Help',
--      },
--      { '<leader>ca', vim.lsp.buf.code_action, desc = 'Code Action', mode = { 'n', 'v' } },
--      { '<leader>cc', vim.lsp.codelens.run, desc = 'Run Codelens', mode = { 'n', 'v' } },
--      {
--        '<leader>cC',
--        vim.lsp.codelens.refresh,
--        desc = 'Refresh & Display Codelens',
--        mode = { 'n' },
--      },
--      {
--        '<leader>cR',
--        function()
--          Snacks.rename.rename_file()
--        end,
--        desc = 'Rename File',
--        mode = { 'n' },
--      },
--    { '<leader>cr', vim.lsp.buf.rename, desc = 'Rename' },
--    {
--      ']]',
--      function()
--        Snacks.words.jump(vim.v.count1)
--      end,
--      desc = 'Next Reference',
--    },
--    {
--      '[[',
--      function()
--        Snacks.words.jump(-vim.v.count1)
--      end,
--      desc = 'Prev Reference',
--    },
--    {
--      '<a-n>',
--      function()
--        Snacks.words.jump(vim.v.count1, true)
--      end,
--      desc = 'Next Reference',
--    },
--    {
--      '<a-p>',
--      function()
--        Snacks.words.jump(-vim.v.count1, true)
--      end,
--      desc = 'Prev Reference',
--    },
