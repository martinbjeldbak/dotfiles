return {
    -- dashboard
    {
        'nvimdev/dashboard-nvim',
        event = "VimEnter",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            theme = "hyper",
            config = {
                week_header = {
                    enable = true,
                },
                shortcut = {
                    { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
                    {
                        icon = ' ',
                        icon_hl = '@variable',
                        desc = 'Files',
                        group = 'Label',
                        action = 'Telescope git_files',
                        key = 'f',
                    },
                    {
                        icon = ' ',
                        icon_hl = '@variable',
                        desc = 'Grep',
                        group = 'Label',
                        action = 'Telescope live_grep',
                        key = 'g',
                    },
                    {
                        desc = ' dotfiles',
                        group = 'Number',
                        action = 'Telescope dotfiles',
                        key = 'd',
                    },
                },
            },
        },
    },

    -- Make it rain
    {
        "eandrju/cellular-automaton.nvim",
        cmd = "CellularAutomaton",
        keys = {
            { "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Contemplate life" }
        },
    },

    -- Statusline
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-web-devicons",
        },
        opts = {
            options = {
                theme = "catppuccin",
            },
            extensions = {
                "fugitive",
                "fzf",
                "nvim-tree",
            },
        },
    }
}
