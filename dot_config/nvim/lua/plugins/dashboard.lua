return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	opts = {
		theme = "hyper",
		config = {
			week_header = {
				enable = true,
			},
			shortcut = {
				{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
				{
					icon = " ",
					icon_hl = "@variable",
					desc = "Files",
					group = "Label",
					action = "Telescope git_files",
					key = "f",
				},
				{
					icon = " ",
					icon_hl = "@variable",
					desc = "Grep",
					group = "Label",
					action = "Telescope live_grep",
					key = "g",
				},
				{
					desc = " dotfiles",
					group = "Number",
					action = "Telescope dotfiles",
					key = "d",
				},
			},
		},
	},
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
