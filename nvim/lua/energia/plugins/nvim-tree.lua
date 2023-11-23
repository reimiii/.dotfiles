return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local nvimtree = require("nvim-tree")

		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- change color for arrows in tree to light blue
		vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#458588 ]])
		vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#83a598 ]])

		-- configure nvim-tree
		nvimtree.setup({
			sort_by = "case_sensitive",
			update_focused_file = {
				enable = true,
				update_cwd = true,
			},
			view = {
				width = 30,
				preserve_window_proportions = false,
				number = true,
				relativenumber = true,
			},
			-- change folder arrow icons
			renderer = {
				group_empty = true,
				indent_markers = {
					enable = true,
				},
				icons = {
					glyphs = {
						folder = {
							-- arrow_closed = "", -- arrow when folder is closed
							-- arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				dotfiles = true,
			},
			git = {
				ignore = false,
			},
		})

		local wk = require("which-key")
		wk.register({
			["<leader>e"] = { "<cmd>NvimTreeToggle<CR>", "Toggle file explorer", nowait = true },
		})
	end,
}
