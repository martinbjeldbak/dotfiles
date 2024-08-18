return {
	"ThePrimeagen/harpoon",
	keys = {
		{
			"<leader>a",
			function()
				require("harpoon.mark").add_file()
			end,
			desc = "Add file to Harpoon",
		},
		{
			"<C-e>",
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			desc = "Toggle harpoon quick menu",
		},
		{
			"<C-1>",
			function()
				require("harpoon.ui").nav_file(1)
			end,
			desc = "Navigate to file 1",
		},
		{
			"<C-2>",
			function()
				require("harpoon.ui").nav_file(2)
			end,
			desc = "Navigate to file 2",
		},
		{
			"<C-3>",
			function()
				require("harpoon.ui").nav_file(3)
			end,
			desc = "Navigate to file 3",
		},
		{
			"<C-4>",
			function()
				require("harpoon.ui").nav_file(4)
			end,
			desc = "Navigate to file 4",
		},
	},
}
