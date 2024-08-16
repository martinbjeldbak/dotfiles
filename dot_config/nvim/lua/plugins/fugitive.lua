return {
	"tpope/vim-fugitive",
	keys = {
		{ "<leader>gs", vim.cmd.Git, desc = "Git status" },
		{ "<leader>gc", "<cmd>Git commit<cr>", desc = "Git commit" },
		{ "<leader>gp", "<cmd>Git push<cr>", desc = "Git push" },
	},
	cmd = { "G", "GBrowse" },
	dependencies = {
		{
			"tpope/vim-rhubarb",
			dependencies = { "tyru/open-browser.vim" },
			init = function()
				vim.g.github_enterprise_urls = { "https://github.service.anz" }
			end,
		},
	},
}
