return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				transparent_mode = true,
			})

			-- load the colorscheme here
			vim.cmd([[colorscheme gruvbox]])
		end,
	},
}
