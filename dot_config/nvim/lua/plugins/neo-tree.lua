return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	cmd = "Neotree",
	keys = {
		{ "\\", ":Neotree reveal right<CR>", desc = "NeoTree reveal" },
	},
	opts = {
		filesystem = {
			filtered_items = {
				visible = true,
				hide_dotfiles = false,
				hide_gitignored = true,
				never_show = { ".git" },
			},
			window = {
				mappings = {
					["\\"] = "close_window",
				},
			},
			follow_current_file = {
				enabled = true,
			},
		},
	},
}
