return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				vimgrep_arguments = {
					"rg",
					"-L",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				path_display = { "smart" },
				color_devicons = true,
				file_ignore_patterns = { "node_modules", "target" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "bottom",
						preview_width = 0.55,
						results_width = 0.55,
					},
					vertical = {
						mirror = false,
					},
					width = 0.80,
					height = 0.80,
					preview_cutoff = 20,
				},
			},
		})

		-- telescope.load_extension("fzf")
		telescope.load_extension("ui-select")
		--		telescope.load_extension("harpoon")

		-- set keymaps
		local wk = require("which-key")
		wk.register({
			["<A-f>"] = { builtin.find_files, "Find File", nowait = true },
			["<A-g>"] = { builtin.git_files, "Find Git File", nowait = true },
			["<A-s>"] = {
				function()
					builtin.grep_string({ search = vim.fn.input("Grep > ") })
				end,
				"Find String",
				nowait = true,
			},
		})
	end,
}
