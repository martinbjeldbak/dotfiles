return {
	"folke/zen-mode.nvim",
	dependencies = {
		"folke/twilight.nvim", -- keep section in focus
	},
	opts = {
		window = {
			width = 90,
			options = {
				number = true,
				relativenumber = true,
			},
		},
		plugins = {
			tmux = { enabled = true },
		},
	},
	keys = {
		{
			"<leader>zz",
			function()
				require("zen-mode").toggle()
				vim.wo.wrap = false
			end,
			desc = "Enter zen mode",
		},
	},
}
